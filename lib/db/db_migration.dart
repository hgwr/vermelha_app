import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

const debug = true && kDebugMode;

Map<int, String> databaseMigrations = {
  int.parse('2023_0423_2000_001'.replaceAll('_', '')): '''
CREATE TABLE IF NOT EXISTS db_migration (id INTEGER PRIMARY KEY, version INTEGER NOT NULL)
''',
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
    ''',
  int.parse('2023_0423_2000_003'.replaceAll('_', '')): '''
CREATE TABLE IF NOT EXISTS status_parameter (
    id INTEGER PRIMARY KEY,
    name TEXT NOT NULL,
    character_id INTEGER NOT NULL,
    FOREIGN KEY(character_id) REFERENCES character(id))
    ''',
  int.parse('2023_0423_2000_104'.replaceAll('_', '')): '''
drop table if exists battle_rule
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
  final String path = join(await getDatabasesPath(), 'vermelha_database.db');
  return openDatabase(path);
}

Future<void> migrateDatabase() async {
  var db = await openVermelhaDatabase();
  await db.execute(
      'CREATE TABLE IF NOT EXISTS db_migration (id INTEGER PRIMARY KEY, version INTEGER NOT NULL)');

  if (debug) {
    await db.execute('UPDATE db_migration SET version = 0');
  }

  var rows = await db.query('db_migration');
  int databaseVersion = 0;
  if (rows.length == 0) {
    await db.execute('INSERT INTO db_migration (version) VALUES (0)');
  } else {
    databaseVersion = (rows[0]['version'] ?? 0) as int;
  }
  if (debug) {
    print("Database version: $databaseVersion");
  }

  var migrationNumbers = databaseMigrations.keys.toList();
  migrationNumbers.sort();
  migrationNumbers
      .where((version) => version > databaseVersion)
      .forEach((version) async {
    print("Migrating to version $version");
    print(databaseMigrations[version]!);
    await db.execute(databaseMigrations[version]!);
    await db.execute('UPDATE db_migration SET version = $version');
  });

  if (debug) {
    rows = await db.query("character");
    print("Characters:");
    print(rows);
    rows = await db.query("status_parameter");
    print("Status Parameters:");
    print(rows);
    rows = await db.query("battle_rule");
    print("Battle Rules:");
    print(rows);
  }

  db.close();
}
