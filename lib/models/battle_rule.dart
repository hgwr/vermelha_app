import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/condition.dart';

class BattleRule {
  final int? id;
  final Character owner;
  final int priority;
  final String name;
  Condition condition;
  Action action;

  BattleRule({
    this.id,
    required this.owner,
    required this.priority,
    required this.name,
    required this.condition,
    required this.action,
  });

  static BattleRule fromJson(Map<String, dynamic> json, PlayerCharacter owner) {
    Condition condition = getConditionByUuid(json['condition_uuid']);
    Action action = getActionByUuid(json['action_uuid']);
    return BattleRule(
      id: json['id'],
      owner: owner,
      priority: json['priority'],
      name: json['name'],
      condition: condition,
      action: action,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': owner.id,
      'priority': priority,
      'name': name,
      'condition_uuid': condition.uuid,
      'action_uuid': action.uuid,
    };
  }

  BattleRule copyWith({
    int? id,
    PlayerCharacter? owner,
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
