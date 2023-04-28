import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';

class BattleRule {
  final int id;
  final Character owner;
  final int priority;
  final String name;
  final Condition condition;
  final Action action;

  const BattleRule({
    required this.id,
    required this.owner,
    required this.priority,
    required this.name,
    required this.condition,
    required this.action,
  });
}
