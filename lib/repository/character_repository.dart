import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';

import 'package:vermelha_app/db/db_connection.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/equipment_slot.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/item_catalog.dart';
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
    final inventoryRows = await db.query(
      'character_inventory',
      where: 'character_id = ?',
      whereArgs: [id],
    );
    final List<Item> inventory = [];
    for (var row in inventoryRows) {
      final itemId = row['item_id'] as String?;
      if (itemId == null) {
        continue;
      }
      final item = findItemById(itemId);
      if (item != null) {
        inventory.add(item);
      }
    }

    final equipmentRows = await db.query(
      'character_equipment',
      where: 'character_id = ?',
      whereArgs: [id],
    );
    final Map<EquipmentSlot, Item?> equipment = {};
    for (var row in equipmentRows) {
      final slot = equipmentSlotFromDb(row['slot']);
      final itemId = row['item_id'] as String?;
      if (slot == null || itemId == null) {
        continue;
      }
      equipment[slot] = findItemById(itemId);
    }

    character = character.copyWith(
      battleRules: battleRules,
      inventory: inventory,
      equipment: equipment,
    );
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
      for (var item in character.inventory) {
        await txn.insert('character_inventory', {
          'character_id': id,
          'item_id': item.id,
        });
      }
      for (var entry in character.equipment.entries) {
        final item = entry.value;
        if (item == null) {
          continue;
        }
        await txn.insert('character_equipment', {
          'character_id': id,
          'slot': equipmentSlotToDb(entry.key),
          'item_id': item.id,
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
      await txn.delete(
        'character_inventory',
        where: 'character_id = ?',
        whereArgs: [character.id],
      );
      for (var item in character.inventory) {
        await txn.insert('character_inventory', {
          'character_id': character.id,
          'item_id': item.id,
        });
      }
      await txn.delete(
        'character_equipment',
        where: 'character_id = ?',
        whereArgs: [character.id],
      );
      for (var entry in character.equipment.entries) {
        final item = entry.value;
        if (item == null) {
          continue;
        }
        await txn.insert('character_equipment', {
          'character_id': character.id,
          'slot': equipmentSlotToDb(entry.key),
          'item_id': item.id,
        });
      }
      return character;
    });
    return updatedCharacter;
  }

  Future<void> updateVitals(PlayerCharacter character) async {
    try {
      final db = await DbConnection().database;
      await db.update(
        'character',
        {
          'hp': character.hp,
          'mp': character.mp,
        },
        where: 'id = ?',
        whereArgs: [character.id],
      );
    } catch (e, s) {
      debugPrint('Failed to update vitals for character ${character.id}: $e');
      debugPrintStack(stackTrace: s);
    }
  }

  Future<bool> updateVitalsBatch(List<PlayerCharacter> characters) async {
    if (characters.isEmpty) {
      return true;
    }
    try {
      final db = await DbConnection().database;
      await db.transaction((txn) async {
        for (final character in characters) {
          await txn.update(
            'character',
            {
              'hp': character.hp,
              'mp': character.mp,
            },
            where: 'id = ?',
            whereArgs: [character.id],
          );
        }
      });
      return true;
    } catch (e, s) {
      debugPrint('Failed to batch update vitals: $e');
      debugPrintStack(stackTrace: s);
      return false;
    }
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
      await txn.delete(
        'character_inventory',
        where: 'character_id = ?',
        whereArgs: [character.id],
      );
      await txn.delete(
        'character_equipment',
        where: 'character_id = ?',
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
