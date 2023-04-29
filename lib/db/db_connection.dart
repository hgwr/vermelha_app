import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

Future<Database> openVermelhaDatabase() async {
  final String path = p.join(await getDatabasesPath(), 'vermelha_database.db');
  return openDatabase(path);
}
