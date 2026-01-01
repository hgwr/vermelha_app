import 'dart:convert';

import 'package:sqflite/sqflite.dart';
import 'package:vermelha_app/db/db_connection.dart';
import 'package:uuid/uuid.dart';
import 'package:vermelha_app/models/dungeon_state.dart';
import 'package:vermelha_app/models/game_state.dart';
import 'package:vermelha_app/models/log_entry.dart';
import 'package:vermelha_app/models/party.dart';
import 'package:vermelha_app/models/player_character.dart';

class GameStateRepository {
  static const int _singletonId = 1;

  Future<GameState> load({
    List<PlayerCharacter> roster = const [],
  }) async {
    final db = await DbConnection().database;
    final result = await db.query(
      'game_state',
      where: 'id = ?',
      whereArgs: [_singletonId],
      limit: 1,
    );
    if (result.isEmpty) {
      final state = GameState(
        roster: roster,
        party: Party.fromRoster(roster),
        gold: 0,
        maxReachedFloor: 1,
        activeDungeon: null,
      );
      await save(state);
      return state;
    }

    final row = result.first;
    final activeFloor = row['active_floor'] as int?;
    final battleCount = row['battle_count_on_floor'] as int? ?? 0;
    final battlesToUnlock =
        row['battles_to_unlock_next_floor'] as int? ??
            DungeonState.defaultBattlesToUnlockNextFloor;
    final isPaused = (row['is_paused'] as int? ?? 1) == 1;
    final eventLog = _decodeEventLog(row['event_log'] as String?);
    final seedValue = row['seed'] as String?;
    final activeDungeon = activeFloor == null
        ? null
        : DungeonState(
            floor: activeFloor,
            seed: (seedValue == null || seedValue.isEmpty)
                ? const Uuid().v4()
                : seedValue,
            battleCountOnFloor: battleCount,
            battlesToUnlockNextFloor: battlesToUnlock,
            eventLog: eventLog,
            isPaused: isPaused,
          );

    return GameState(
      roster: roster,
      party: Party.fromRoster(roster),
      gold: row['gold'] as int? ?? 0,
      maxReachedFloor: row['max_reached_floor'] as int? ?? 1,
      activeDungeon: activeDungeon,
    );
  }

  Future<void> save(GameState state) async {
    final db = await DbConnection().database;
    final activeDungeon = state.activeDungeon;
    final eventLog = activeDungeon?.eventLog ?? const <LogEntry>[];
    final data = {
      'id': _singletonId,
      'gold': state.gold,
      'max_reached_floor': state.maxReachedFloor,
      'active_floor': activeDungeon?.floor,
      'seed': activeDungeon?.seed,
      'battle_count_on_floor': activeDungeon?.battleCountOnFloor ?? 0,
      'battles_to_unlock_next_floor':
          activeDungeon?.battlesToUnlockNextFloor ??
              DungeonState.defaultBattlesToUnlockNextFloor,
      'event_log': jsonEncode(eventLog.map((entry) => entry.toJson()).toList()),
      'is_paused': (activeDungeon?.isPaused ?? true) ? 1 : 0,
    };
    await db.insert(
      'game_state',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  List<LogEntry> _decodeEventLog(String? value) {
    if (value == null || value.isEmpty) {
      return [];
    }
    try {
      final decoded = jsonDecode(value);
      if (decoded is! List) {
        return [];
      }
      return decoded
          .whereType<Map>()
          .map((entry) => LogEntry.fromJson(
                Map<String, dynamic>.from(entry),
              ))
          .toList();
    } catch (_) {
      return [];
    }
  }
}
