import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:vermelha_app/db/app_database.dart' as db;
import 'package:uuid/uuid.dart';
import 'package:vermelha_app/models/dungeon_state.dart';
import 'package:vermelha_app/models/game_state.dart';
import 'package:vermelha_app/models/log_entry.dart';
import 'package:vermelha_app/models/party.dart';
import 'package:vermelha_app/models/player_character.dart';

class GameStateRepository {
  static const int _singletonId = 1;
  static const Uuid _uuid = Uuid();
  final db.AppDatabase _database;

  GameStateRepository({db.AppDatabase? database})
      : _database = database ?? db.AppDatabase();

  Future<GameState> load({
    List<PlayerCharacter> roster = const [],
  }) async {
    final result = await (_database.select(_database.gameStates)
          ..where((tbl) => tbl.id.equals(_singletonId))
          ..limit(1))
        .getSingleOrNull();
    if (result == null) {
      final state = GameState(
        roster: roster,
        party: Party.fromRoster(roster),
        gold: 0,
        maxReachedFloor: 1,
        battleCountOnFloor: 0,
        battlesToUnlockNextFloor:
            DungeonState.defaultBattlesToUnlockNextFloor,
        activeDungeon: null,
      );
      await save(state);
      return state;
    }

    final activeFloor = result.activeFloor;
    final battleCount = result.battleCountOnFloor;
    final battlesToUnlock = result.battlesToUnlockNextFloor;
    final isPaused = (result.isPaused) == 1;
    final eventLog = _decodeEventLog(result.eventLog);
    final seedValue = result.seed;
    final activeDungeon = activeFloor == null
        ? null
        : DungeonState(
            floor: activeFloor,
            seed: (seedValue == null || seedValue.isEmpty)
                ? _uuid.v4()
                : seedValue,
            battleCountOnFloor: battleCount,
            battlesToUnlockNextFloor: battlesToUnlock,
            eventLog: eventLog,
            isPaused: isPaused,
          );

    return GameState(
      roster: roster,
      party: Party.fromRoster(roster),
      gold: result.gold,
      maxReachedFloor: result.maxReachedFloor,
      battleCountOnFloor: battleCount,
      battlesToUnlockNextFloor: battlesToUnlock,
      activeDungeon: activeDungeon,
    );
  }

  Future<void> save(GameState state) async {
    final activeDungeon = state.activeDungeon;
    final eventLog = activeDungeon?.eventLog ?? const <LogEntry>[];
    final battleCount = activeDungeon?.battleCountOnFloor ??
        state.battleCountOnFloor;
    final battlesToUnlock = activeDungeon?.battlesToUnlockNextFloor ??
        state.battlesToUnlockNextFloor;
    await _database.into(_database.gameStates).insert(
          db.GameStatesCompanion(
            id: const Value(_singletonId),
            gold: Value(state.gold),
            maxReachedFloor: Value(state.maxReachedFloor),
            activeFloor: Value(activeDungeon?.floor),
            seed: Value(activeDungeon?.seed),
            battleCountOnFloor: Value(battleCount),
            battlesToUnlockNextFloor: Value(battlesToUnlock),
            eventLog: Value(
              jsonEncode(eventLog.map((entry) => entry.toJson()).toList()),
            ),
            isPaused: Value((activeDungeon?.isPaused ?? true) ? 1 : 0),
          ),
          mode: InsertMode.insertOrReplace,
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
