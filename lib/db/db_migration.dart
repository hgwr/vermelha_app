import 'package:flutter/foundation.dart';

import 'package:vermelha_app/db/db_connection.dart';

const debug = true && kDebugMode;

const String dbMigrationTableCreate = '''
CREATE TABLE IF NOT EXISTS db_migration (id INTEGER PRIMARY KEY, version INTEGER NOT NULL)
''';

Map<int, String> databaseMigrations = {
  23042300001: dbMigrationTableCreate,
  23042300110: '''
drop table if exists character
''',
  23042300120: '''
drop table if exists status_parameter
''',
  23042300130: '''
drop table if exists battle_rule
''',
  23042300210: '''
CREATE TABLE IF NOT EXISTS character (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    level INTEGER NOT NULL,
    max_hp INTEGER NOT NULL,
    max_mp INTEGER NOT NULL,
    hp INTEGER NOT NULL,
    mp INTEGER NOT NULL,
    attack INTEGER NOT NULL,
    defense INTEGER NOT NULL,
    magic_power INTEGER NOT NULL,
    speed INTEGER NOT NULL,
    job_id INTEGER)
    ''',
  23042300220: '''
CREATE TABLE IF NOT EXISTS status_parameter (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    character_id INTEGER NOT NULL,
    FOREIGN KEY(character_id) REFERENCES character(id))
    ''',
  23042300230: '''
CREATE TABLE IF NOT EXISTS battle_rule (
    id INTEGER PRIMARY KEY,
    owner_id INTEGER NOT NULL,
    priority INTEGER NOT NULL,
    name TEXT NOT NULL,
    condition_uuid TEXT NOT NULL,
    action_uuid TEXT NOT NULL,
    FOREIGN KEY(owner_id) REFERENCES character(id))
    ''',
  23050500100: '''
alter table character add column exp INTEGER NOT NULL DEFAULT 0
''',
  23050500110: '''
alter table character add column is_active INTEGER NOT NULL DEFAULT 1
''',
};

Future<void> migrateDatabase() async {
  debugPrint("Database migration started");

  var db = await DbConnection().database;
  await db.execute(dbMigrationTableCreate);

  // if (debug) {
  //   await db.execute('UPDATE db_migration SET version = 0');
  // }

  var rows = await db.query('db_migration');
  int databaseVersion = 0;
  if (rows.isEmpty) {
    await db.execute('INSERT INTO db_migration (version) VALUES (0)');
  } else {
    databaseVersion = (rows[0]['version'] ?? 0) as int;
  }
  if (debug) {
    debugPrint("Database version: $databaseVersion");
  }

  var migrationNumbers = databaseMigrations.keys.toList();
  migrationNumbers.sort();
  final versions =
      migrationNumbers.where((version) => version > databaseVersion);
  for (var version in versions) {
    if (debug) {
      debugPrint("Migrating to version $version");
      debugPrint(databaseMigrations[version]!);
    }
    await db.execute(databaseMigrations[version]!);
    await db.execute("UPDATE db_migration SET version = $version");
  }

  debugPrint("Database migration finished");
}
