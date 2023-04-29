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

  static BattleRule fromJson(Map<String, dynamic> json) {
    return BattleRule(
      id: json['id'],
      owner: json['owner'],
      priority: json['priority'],
      name: json['name'],
      condition: json['condition'],
      action: json['action'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner': owner,
      'priority': priority,
      'name': name,
      'condition': condition,
      'action': action,
    };
  }

  BattleRule copyWith({
    int? id,
    Character? owner,
    int? priority,
    String? name,
    Condition? condition,
    Action? action,
  }) {
    return BattleRule(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      priority: priority ?? this.priority,
      name: name ?? this.name,
      condition: condition ?? this.condition,
      action: action ?? this.action,
    );
  }
}
