import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

const debug = true && kDebugMode;

const String dbMigrationTableCreate = '''
CREATE TABLE IF NOT EXISTS db_migration (id INTEGER PRIMARY KEY, version INTEGER NOT NULL)
''';

Map<int, String> databaseMigrations = {
  int.parse('2023_0423_2000_001'.replaceAll('_', '')): dbMigrationTableCreate,
  int.parse('2023_0423_2000_002'.replaceAll('_', '')): '''
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
    speed INTEGER NOT NULL)
    job_id INTEGER,
    ''',
  int.parse('2023_0423_2000_003'.replaceAll('_', '')): '''
CREATE TABLE IF NOT EXISTS status_parameter (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    character_id INTEGER NOT NULL,
    FOREIGN KEY(character_id) REFERENCES character(id))
    ''',
  int.parse('2023_0423_2000_105'.replaceAll('_', '')): '''
CREATE TABLE IF NOT EXISTS battle_rule (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    description TEXT NOT NULL,
    character_id INTEGER NOT NULL,
    FOREIGN KEY(character_id) REFERENCES character(id))
    ''',
};

Future<Database> openVermelhaDatabase() async {
  final String path = p.join(await getDatabasesPath(), 'vermelha_database.db');
  return openDatabase(path);
}

Future<void> migrateDatabase() async {
  var db = await openVermelhaDatabase();
  await db.execute(dbMigrationTableCreate);

  if (debug) {
    await db.execute('UPDATE db_migration SET version = 0');
  }

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
  migrationNumbers
      .where((version) => version > databaseVersion)
      .forEach((version) async {
    if (debug) {
      debugPrint("Migrating to version $version");
      debugPrint(databaseMigrations[version]!);
    }
    await db.execute(databaseMigrations[version]!);
    await db.execute('UPDATE db_migration SET version = $version');
  });

  db.close();
}
