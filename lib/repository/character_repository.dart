import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:vermelha_app/db/app_database.dart' as db;
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/equipment_slot.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/item_catalog.dart';
import 'package:vermelha_app/models/player_character.dart';
import '../models/status_parameter.dart';

class CharacterRepository {
  CharacterRepository({db.AppDatabase? database})
      : _database = database ?? db.AppDatabase();

  final db.AppDatabase _database;

  Future<void> deleteAll() async {
    await _database.transaction(() async {
      await _database.delete(_database.battleRules).go();
      await _database.delete(_database.statusParameters).go();
      await _database.delete(_database.characterInventories).go();
      await _database.delete(_database.characterEquipments).go();
      await _database.delete(_database.characters).go();
    });
  }

  Future<List<PlayerCharacter>> findAll() async {
    try {
      final result = await _database.select(_database.characters).get();
      List<PlayerCharacter> characters = [];
      for (final row in result) {
        var character = _playerCharacterFromRow(row);
        character = await _setParams(_database, character);
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
    final result = await (_database.select(_database.characters)
          ..where((tbl) => tbl.id.equals(id))
          ..limit(1))
        .getSingle();
    var character = _playerCharacterFromRow(result);
    character = await _setParams(_database, character);
    return character;
  }

  Future<PlayerCharacter> _setParams(
      db.AppDatabase database, PlayerCharacter character) async {
    final id = character.id!;
    final statusParamRows = await (database.select(database.statusParameters)
          ..where((tbl) => tbl.characterId.equals(id)))
        .get();
    character = character.copyWith(
      priorityParameters: statusParamRows.map((row) {
        return getStatusParameterByName(row.name);
      }).toList(),
    );
    final battleRuleRows = await (database.select(database.battleRules)
          ..where((tbl) => tbl.ownerId.equals(id)))
        .get();
    List<BattleRule> battleRules = [];
    for (final row in battleRuleRows) {
      battleRules.add(BattleRule.fromJson(_battleRuleToJson(row), character));
    }
    final inventoryRows = await (database.select(database.characterInventories)
          ..where((tbl) => tbl.characterId.equals(id)))
        .get();
    final List<Item> inventory = [];
    for (final row in inventoryRows) {
      final item = findItemById(row.itemId);
      if (item != null) {
        inventory.add(item);
      }
    }

    final equipmentRows = await (database.select(database.characterEquipments)
          ..where((tbl) => tbl.characterId.equals(id)))
        .get();
    final Map<EquipmentSlot, Item?> equipment = {};
    for (final row in equipmentRows) {
      final slot = equipmentSlotFromDb(row.slot);
      if (slot == null) {
        continue;
      }
      equipment[slot] = findItemById(row.itemId);
    }

    character = character.copyWith(
      battleRules: battleRules,
      inventory: inventory,
      equipment: equipment,
    );
    return character;
  }

  Future<PlayerCharacter> save(PlayerCharacter character) async {
    final newCharacter = await _database.transaction(() async {
      final id = await _database
          .into(_database.characters)
          .insert(_characterToCompanion(character, includeId: false));
      for (var priorityParameter in character.priorityParameters) {
        await _database.into(_database.statusParameters).insert(
              db.StatusParametersCompanion(
                name: Value(priorityParameter.name),
                characterId: Value(id),
              ),
            );
      }
      for (var battleRule in character.battleRules) {
        await _database.into(_database.battleRules).insert(
              db.BattleRulesCompanion(
                ownerId: Value(id),
                priority: Value(battleRule.priority),
                name: Value(battleRule.name),
                conditionUuid: Value(conditionAlwaysId),
                targetUuid: Value(battleRule.target.uuid),
                actionUuid: Value(battleRule.action.uuid),
              ),
            );
      }
      for (var item in character.inventory) {
        await _database.into(_database.characterInventories).insert(
              db.CharacterInventoriesCompanion(
                characterId: Value(id),
                itemId: Value(item.id),
              ),
            );
      }
      for (var entry in character.equipment.entries) {
        final item = entry.value;
        if (item == null) {
          continue;
        }
        await _database.into(_database.characterEquipments).insert(
              db.CharacterEquipmentsCompanion(
                characterId: Value(id),
                slot: Value(equipmentSlotToDb(entry.key)),
                itemId: Value(item.id),
              ),
            );
      }
      return character.copyWith(id: id);
    });
    return newCharacter;
  }

  Future<PlayerCharacter> update(PlayerCharacter character) async {
    final updatedCharacter = await _database.transaction(() async {
      await (_database.update(_database.characters)
            ..where((tbl) => tbl.id.equals(character.id!)))
          .write(_characterToCompanion(character, includeId: false));
      await (_database.delete(_database.statusParameters)
            ..where((tbl) => tbl.characterId.equals(character.id!)))
          .go();
      for (var priorityParameter in character.priorityParameters) {
        await _database.into(_database.statusParameters).insert(
              db.StatusParametersCompanion(
                name: Value(priorityParameter.name),
                characterId: Value(character.id!),
              ),
            );
      }
      await (_database.delete(_database.battleRules)
            ..where((tbl) => tbl.ownerId.equals(character.id!)))
          .go();
      for (var battleRule in character.battleRules) {
        await _database.into(_database.battleRules).insert(
              db.BattleRulesCompanion(
                ownerId: Value(character.id!),
                priority: Value(battleRule.priority),
                name: Value(battleRule.name),
                conditionUuid: Value(conditionAlwaysId),
                targetUuid: Value(battleRule.target.uuid),
                actionUuid: Value(battleRule.action.uuid),
              ),
            );
      }
      await (_database.delete(_database.characterInventories)
            ..where((tbl) => tbl.characterId.equals(character.id!)))
          .go();
      for (var item in character.inventory) {
        await _database.into(_database.characterInventories).insert(
              db.CharacterInventoriesCompanion(
                characterId: Value(character.id!),
                itemId: Value(item.id),
              ),
            );
      }
      await (_database.delete(_database.characterEquipments)
            ..where((tbl) => tbl.characterId.equals(character.id!)))
          .go();
      for (var entry in character.equipment.entries) {
        final item = entry.value;
        if (item == null) {
          continue;
        }
        await _database.into(_database.characterEquipments).insert(
              db.CharacterEquipmentsCompanion(
                characterId: Value(character.id!),
                slot: Value(equipmentSlotToDb(entry.key)),
                itemId: Value(item.id),
              ),
            );
      }
      return character;
    });
    return updatedCharacter;
  }

  Future<void> updateVitals(PlayerCharacter character) async {
    try {
      await (_database.update(_database.characters)
            ..where((tbl) => tbl.id.equals(character.id!)))
          .write(
        db.CharactersCompanion(
          hp: Value(character.hp),
          mp: Value(character.mp),
        ),
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
      await _database.transaction(() async {
        for (final character in characters) {
          await (_database.update(_database.characters)
                ..where((tbl) => tbl.id.equals(character.id!)))
              .write(
            db.CharactersCompanion(
              hp: Value(character.hp),
              mp: Value(character.mp),
            ),
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
    debugPrint("deleting character with id ${character.id}");
    final count = await _database.transaction(() async {
      await (_database.delete(_database.statusParameters)
            ..where((tbl) => tbl.characterId.equals(character.id!)))
          .go();
      await (_database.delete(_database.battleRules)
            ..where((tbl) => tbl.ownerId.equals(character.id!)))
          .go();
      await (_database.delete(_database.characterInventories)
            ..where((tbl) => tbl.characterId.equals(character.id!)))
          .go();
      await (_database.delete(_database.characterEquipments)
            ..where((tbl) => tbl.characterId.equals(character.id!)))
          .go();
      final count = await (_database.delete(_database.characters)
            ..where((tbl) => tbl.id.equals(character.id!)))
          .go();
      debugPrint("Character deleted successfully with id ${character.id}");
      return count;
    });
    return count;
  }

  db.CharactersCompanion _characterToCompanion(
    PlayerCharacter character, {
    required bool includeId,
  }) {
    final json = character.toJson();
    return db.CharactersCompanion(
      id: includeId && json['id'] != null
          ? Value(json['id'] as int)
          : const Value.absent(),
      name: Value(json['name'] as String),
      level: Value(json['level'] as int),
      maxHp: Value(json['max_hp'] as int),
      maxMp: Value(json['max_mp'] as int),
      hp: Value(json['hp'] as int),
      mp: Value(json['mp'] as int),
      attack: Value(json['attack'] as int),
      defense: Value(json['defense'] as int),
      magicPower: Value(json['magic_power'] as int),
      speed: Value(json['speed'] as int),
      jobId: Value(json['job_id'] as int?),
      exp: Value(json['exp'] as int),
      jobBonus: Value(json['job_bonus'] as String?),
      isActive: Value(json['is_active'] as int),
      partyPosition: Value(json['party_position'] as int?),
    );
  }

  PlayerCharacter _playerCharacterFromRow(db.Character row) {
    return PlayerCharacter.fromJson({
      'id': row.id,
      'name': row.name,
      'level': row.level,
      'max_hp': row.maxHp,
      'max_mp': row.maxMp,
      'hp': row.hp,
      'mp': row.mp,
      'attack': row.attack,
      'defense': row.defense,
      'magic_power': row.magicPower,
      'speed': row.speed,
      'job_id': row.jobId,
      'exp': row.exp,
      'job_bonus': row.jobBonus,
      'is_active': row.isActive,
      'party_position': row.partyPosition,
    });
  }

  Map<String, dynamic> _battleRuleToJson(db.BattleRule row) {
    return {
      'id': row.id,
      'owner_id': row.ownerId,
      'priority': row.priority,
      'name': row.name,
      'condition_uuid': row.conditionUuid,
      'target_uuid': row.targetUuid,
      'action_uuid': row.actionUuid,
    };
  }
}
