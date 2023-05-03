import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

class DbConnection {
  static final DbConnection _instance = DbConnection._internal();
  factory DbConnection() => _instance;
  DbConnection._internal();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path =
        p.join(await getDatabasesPath(), 'vermelha_database.db');
    return await openDatabase(path);
  }
}
