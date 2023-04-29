import 'package:flutter/foundation.dart';

import 'package:vermelha_app/db/db_connection.dart';
import 'package:vermelha_app/models/character.dart';

class CharacterRepository {
  Future<List<Character>> findAll() async {
    try {
      final db = await openVermelhaDatabase();
      final result = await db.query('characters');
      return result.map((json) => Character.fromJson(json)).toList();
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<Character> findById(int id) async {
    final db = await openVermelhaDatabase();
    final result = await db.query(
      'characters',
      where: 'id = ?',
      whereArgs: [id],
    );
    return Character.fromJson(result.first);
  }

  Future<Character> save(Character character) async {
    final db = await openVermelhaDatabase();
    final id = await db.insert('characters', character.toJson());
    return character.copyWith(id: id);
  }

  Future<Character> update(Character character) async {
    final db = await openVermelhaDatabase();
    await db.update(
      'characters',
      character.toJson(),
      where: 'id = ?',
      whereArgs: [character.id],
    );
    return character;
  }

  Future<void> delete(Character character) async {
    final db = await openVermelhaDatabase();
    await db.delete(
      'characters',
      where: 'id = ?',
      whereArgs: [character.id],
    );
  }
}
