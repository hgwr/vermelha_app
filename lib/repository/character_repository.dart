import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:vermelha_app/db/db_connection.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/player_character.dart';
import '../models/status_parameter.dart';

class CharacterRepository {
  Future<List<PlayerCharacter>> findAll() async {
    try {
      final db = await DbConnection().database;
      final result = await db.query('character');
      List<PlayerCharacter> characters = [];
      for (var json in result) {
        var character = PlayerCharacter.fromJson(json);
        character = await _setParams(db, character);
        characters.add(character);
      }
      return characters;
    } catch (e, s) {
      debugPrint("$e");
      debugPrint("$s");
      return [];
    }
  }

  Future<PlayerCharacter> findById(int id) async {
    final db = await DbConnection().database;
    final result = await db.query(
      'character',
      where: 'id = ?',
      whereArgs: [id],
    );
    var character = PlayerCharacter.fromJson(result.first);
    character = await _setParams(db, character);
    return character;
  }

  Future<PlayerCharacter> _setParams(
      Database db, PlayerCharacter character) async {
    final id = character.id!;
    final statusParamJsonList = await db.query(
      'status_parameter',
      where: 'character_id = ?',
      whereArgs: [id],
    );
    character = character.copyWith(
      priorityParameters: statusParamJsonList.map((json) {
        return getStatusParameterByName(json['name'] as String);
      }).toList(),
    );
    final battleRuleJsonList = await db.query(
      'battle_rule',
      where: 'owner_id = ?',
      whereArgs: [id],
    );
    List<BattleRule> battleRules = [];
    for (var json in battleRuleJsonList) {
      battleRules.add(BattleRule.fromJson(json, character));
    }
    character = character.copyWith(battleRules: battleRules);
    return character;
  }

  Future<PlayerCharacter> save(PlayerCharacter character) async {
    final db = await DbConnection().database;
    final newCharacter = await db.transaction((txn) async {
      final id = await txn.insert('character', character.toJson());
      for (var priorityParameter in character.priorityParameters) {
        await txn.insert('status_parameter', {
          'name': priorityParameter.name,
          'character_id': id,
        });
      }
      for (var battleRule in character.battleRules) {
        await txn.insert('battle_rule', {
          'owner_id': id,
          'priority': battleRule.priority,
          'name': battleRule.name,
          'condition_uuid': battleRule.condition.uuid,
          'target_uuid': battleRule.target.uuid,
          'action_uuid': battleRule.action.uuid,
        });
      }
      return character.copyWith(id: id);
    });
    return newCharacter;
  }

  Future<PlayerCharacter> update(PlayerCharacter character) async {
    final db = await DbConnection().database;
    final updatedCharacter = await db.transaction((txn) async {
      await txn.update(
        'character',
        character.toJson(),
        where: 'id = ?',
        whereArgs: [character.id],
      );
      await txn.delete(
        'status_parameter',
        where: 'character_id = ?',
        whereArgs: [character.id],
      );
      for (var priorityParameter in character.priorityParameters) {
        await txn.insert('status_parameter', {
          'name': priorityParameter.name,
          'character_id': character.id,
        });
      }
      await txn.delete(
        'battle_rule',
        where: 'owner_id = ?',
        whereArgs: [character.id],
      );
      for (var battleRule in character.battleRules) {
        await txn.insert('battle_rule', {
          'owner_id': character.id,
          'priority': battleRule.priority,
          'name': battleRule.name,
          'condition_uuid': battleRule.condition.uuid,
          'target_uuid': battleRule.target.uuid,
          'action_uuid': battleRule.action.uuid,
        });
      }
      return character;
    });
    return updatedCharacter;
  }

  Future<int> delete(PlayerCharacter character) async {
    final db = await DbConnection().database;
    debugPrint("deleting character with id ${character.id}");
    final count = await db.transaction((txn) async {
      await txn.delete(
        'status_parameter',
        where: 'character_id = ?',
        whereArgs: [character.id],
      );
      await txn.delete(
        'battle_rule',
        where: 'owner_id = ?',
        whereArgs: [character.id],
      );
      final count = await txn.delete(
        'character',
        where: 'id = ?',
        whereArgs: [character.id],
      );
      debugPrint("Character deleted successfully with id ${character.id}");
      return count;
    });
    return count;
  }
}
