import 'package:vermelha_app/db/db_connection.dart';
import 'package:vermelha_app/models/battle_rule.dart';

class BattleRuleRepository {
  Future<List<BattleRule>> findAll() async {
    final db = await DbConnection().database;
    final result = await db.query('battle_rules');
    return result.map((json) => BattleRule.fromJson(json)).toList();
  }

  Future<BattleRule> findById(int id) async {
    final db = await DbConnection().database;
    final result = await db.query(
      'battle_rules',
      where: 'id = ?',
      whereArgs: [id],
    );
    return BattleRule.fromJson(result.first);
  }

  Future<BattleRule> save(BattleRule battleRule) async {
    final db = await DbConnection().database;
    final id = await db.insert('battle_rules', battleRule.toJson());
    return battleRule.copyWith(id: id);
  }

  Future<BattleRule> update(BattleRule battleRule) async {
    final db = await DbConnection().database;
    await db.update(
      'battle_rules',
      battleRule.toJson(),
      where: 'id = ?',
      whereArgs: [battleRule.id],
    );
    return battleRule;
  }

  Future<void> delete(BattleRule battleRule) async {
    final db = await DbConnection().database;
    await db.delete(
      'battle_rules',
      where: 'id = ?',
      whereArgs: [battleRule.id],
    );
  }
}
