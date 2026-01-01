import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/status_parameter.dart';

enum EnemyType {
  regular,
  irregular,
}

class Enemy extends Character {
  final EnemyType type;
  bool isTelegraphing;

  Enemy({
    required this.type,
    this.isTelegraphing = false,
    String? uuid,
    int? id,
    required String name,
    required int level,
    required int maxHp,
    required int maxMp,
    required int hp,
    required int mp,
    required int attack,
    required int defense,
    required int magicPower,
    required int speed,
    required List<StatusParameter> priorityParameters,
    required List<BattleRule> battleRules,
  }) : super(
          uuid: uuid,
          id: id,
          name: name,
          level: level,
          maxHp: maxHp,
          maxMp: maxMp,
          hp: hp,
          mp: mp,
          attack: attack,
          defense: defense,
          magicPower: magicPower,
          speed: speed,
          priorityParameters: priorityParameters,
          battleRules: battleRules,
        );
}
