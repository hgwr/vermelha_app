import 'package:drift/drift.dart';
import 'package:vermelha_app/db/app_database.dart' as db;
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/player_character.dart';

class BattleRuleRepository {
  BattleRuleRepository({db.AppDatabase? database})
      : _database = database ?? db.AppDatabase();

  final db.AppDatabase _database;

  Future<List<BattleRule>> findAll(PlayerCharacter ch) async {
    final ownerId = ch.id;
    if (ownerId == null) {
      return [];
    }
    final result = await (_database.select(_database.battleRules)
          ..where((tbl) => tbl.ownerId.equals(ownerId)))
        .get();
    return result
        .map((row) => BattleRule.fromJson(_toJson(row), ch))
        .toList();
  }

  Future<BattleRule> findById(int id, PlayerCharacter ch) async {
    final result = await (_database.select(_database.battleRules)
          ..where((tbl) => tbl.id.equals(id))
          ..limit(1))
        .getSingle();
    return BattleRule.fromJson(_toJson(result), ch);
  }

  Future<BattleRule> save(BattleRule battleRule) async {
    final ownerId = battleRule.owner.id;
    if (ownerId == null) {
      throw StateError('BattleRule owner must be saved before insert.');
    }
    final id = await _database.into(_database.battleRules).insert(
          db.BattleRulesCompanion(
            ownerId: Value(ownerId),
            priority: Value(battleRule.priority),
            name: Value(battleRule.name),
            conditionUuid: Value(conditionAlwaysId),
            targetUuid: Value(battleRule.target.uuid),
            actionUuid: Value(battleRule.action.uuid),
          ),
        );
    return battleRule.copyWith(id: id);
  }

  Future<BattleRule> update(BattleRule battleRule) async {
    final ownerId = battleRule.owner.id;
    if (ownerId == null) {
      throw StateError('BattleRule owner must be saved before update.');
    }
    await (_database.update(_database.battleRules)
          ..where((tbl) => tbl.id.equals(battleRule.id!)))
        .write(
      db.BattleRulesCompanion(
        ownerId: Value(ownerId),
        priority: Value(battleRule.priority),
        name: Value(battleRule.name),
        conditionUuid: Value(conditionAlwaysId),
        targetUuid: Value(battleRule.target.uuid),
        actionUuid: Value(battleRule.action.uuid),
      ),
    );
    return battleRule;
  }

  Future<void> delete(BattleRule battleRule) async {
    await (_database.delete(_database.battleRules)
          ..where((tbl) => tbl.id.equals(battleRule.id!)))
        .go();
  }

  Map<String, dynamic> _toJson(db.BattleRule row) {
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
