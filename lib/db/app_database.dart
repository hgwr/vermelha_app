import 'dart:async';

import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class Characters extends Table {
  @override
  String get tableName => 'character';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get level => integer()();
  IntColumn get maxHp => integer().named('max_hp')();
  IntColumn get maxMp => integer().named('max_mp')();
  IntColumn get hp => integer()();
  IntColumn get mp => integer()();
  IntColumn get attack => integer()();
  IntColumn get defense => integer()();
  IntColumn get magicPower => integer().named('magic_power')();
  IntColumn get speed => integer()();
  IntColumn get jobId => integer().named('job_id').nullable()();
  IntColumn get exp =>
      integer().withDefault(const Constant(0))();
  IntColumn get isActive =>
      integer().named('is_active').withDefault(const Constant(1))();
  IntColumn get partyPosition =>
      integer().named('party_position').nullable()();
  TextColumn get jobBonus => text().named('job_bonus').nullable()();
}

class StatusParameters extends Table {
  @override
  String get tableName => 'status_parameter';

  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get characterId => integer()
      .named('character_id')
      .references(Characters, #id)();
}

class BattleRules extends Table {
  @override
  String get tableName => 'battle_rule';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get ownerId =>
      integer().named('owner_id').references(Characters, #id)();
  IntColumn get priority => integer()();
  TextColumn get name => text()();
  TextColumn get conditionUuid => text().named('condition_uuid')();
  TextColumn get actionUuid => text().named('action_uuid')();
  TextColumn get targetUuid => text().named('target_uuid').nullable()();
}

class GameStates extends Table {
  @override
  String get tableName => 'game_state';

  IntColumn get id => integer()();
  IntColumn get gold => integer()();
  IntColumn get maxReachedFloor =>
      integer().named('max_reached_floor')();
  IntColumn get activeFloor => integer().named('active_floor').nullable()();
  IntColumn get battleCountOnFloor =>
      integer().named('battle_count_on_floor')();
  IntColumn get battlesToUnlockNextFloor =>
      integer().named('battles_to_unlock_next_floor')();
  TextColumn get eventLog => text().named('event_log').nullable()();
  IntColumn get isPaused =>
      integer().named('is_paused').withDefault(const Constant(1))();
  TextColumn get seed => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class CharacterInventories extends Table {
  @override
  String get tableName => 'character_inventory';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get characterId => integer()
      .named('character_id')
      .references(Characters, #id)();
  TextColumn get itemId => text().named('item_id')();
}

class CharacterEquipments extends Table {
  @override
  String get tableName => 'character_equipment';

  IntColumn get id => integer().autoIncrement()();
  IntColumn get characterId => integer()
      .named('character_id')
      .references(Characters, #id)();
  TextColumn get slot => text()();
  TextColumn get itemId => text().named('item_id')();
}

@DriftDatabase(
  tables: [
    Characters,
    StatusParameters,
    BattleRules,
    GameStates,
    CharacterInventories,
    CharacterEquipments,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase._internal()
      : super(
          driftDatabase(
            name: 'vermelha_database',
            web: DriftWebOptions(
              sqlite3Wasm: Uri.parse('sqlite3.wasm'),
              driftWorker: Uri.parse('drift_worker.js'),
              onResult: _logWebResult,
            ),
            native: DriftNativeOptions(
              databasePath: () async {
                final dir = await getApplicationDocumentsDirectory();
                return p.join(dir.path, 'vermelha_database.db');
              },
            ),
          ),
        );

  static final AppDatabase _instance = AppDatabase._internal();

  factory AppDatabase() => _instance;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
        },
        onUpgrade: (m, from, to) async {
          if (from < 1) {
            await m.createAll();
          }
        },
      );

  @override
  int get schemaVersion => 1;
}

void _logWebResult(WasmDatabaseResult result) {
  if (!kDebugMode || result.missingFeatures.isEmpty) {
    return;
  }
  debugPrint(
    'drift web storage: ${result.chosenImplementation} (missing '
    '${result.missingFeatures.join(', ')})',
  );
}
