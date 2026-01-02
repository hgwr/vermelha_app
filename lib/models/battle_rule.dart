import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/target.dart';
import 'package:vermelha_app/models/condition.dart';

class BattleRule {
  final int? id;
  final Character owner;
  final int priority;
  final String name;
  Target target;
  Action action;

  BattleRule({
    this.id,
    required this.owner,
    required this.priority,
    required this.name,
    required this.target,
    required this.action,
  });

  static BattleRule fromJson(Map<String, dynamic> json, PlayerCharacter owner) {
    final targetUuid = json['target_uuid'] as String?;
    final conditionUuid = json['condition_uuid'] as String?;
    final target = targetFromLegacyRule(
      targetUuid: targetUuid,
      conditionUuid: conditionUuid,
    );
    Action action = getActionByUuid(json['action_uuid']);
    return BattleRule(
      id: json['id'],
      owner: owner,
      priority: json['priority'],
      name: json['name'],
      target: target,
      action: action,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'owner_id': owner.id,
      'priority': priority,
      'name': name,
      'condition_uuid': conditionAlwaysId,
      'target_uuid': target.uuid,
      'action_uuid': action.uuid,
    };
  }

  BattleRule copyWith({
    int? id,
    PlayerCharacter? owner,
    int? priority,
    String? name,
    Target? target,
    Action? action,
  }) {
    return BattleRule(
      id: id ?? this.id,
      owner: owner ?? this.owner,
      priority: priority ?? this.priority,
      name: name ?? this.name,
      target: target ?? this.target,
      action: action ?? this.action,
    );
  }
}
