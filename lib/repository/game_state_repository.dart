import 'package:sqflite/sqflite.dart';
import 'package:vermelha_app/db/db_connection.dart';
import 'package:vermelha_app/models/dungeon_state.dart';
import 'package:vermelha_app/models/game_state.dart';
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
    final activeDungeon = activeFloor == null
        ? null
        : DungeonState(
            floor: activeFloor,
            battleCountOnFloor: battleCount,
            battlesToUnlockNextFloor: battlesToUnlock,
          );

    return GameState(
      roster: roster,
      gold: row['gold'] as int? ?? 0,
      maxReachedFloor: row['max_reached_floor'] as int? ?? 1,
      activeDungeon: activeDungeon,
    );
  }

  Future<void> save(GameState state) async {
    final db = await DbConnection().database;
    final activeDungeon = state.activeDungeon;
    final data = {
      'id': _singletonId,
      'gold': state.gold,
      'max_reached_floor': state.maxReachedFloor,
      'active_floor': activeDungeon?.floor,
      'battle_count_on_floor': activeDungeon?.battleCountOnFloor ?? 0,
      'battles_to_unlock_next_floor':
          activeDungeon?.battlesToUnlockNextFloor ??
              DungeonState.defaultBattlesToUnlockNextFloor,
    };
    await db.insert(
      'game_state',
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}
