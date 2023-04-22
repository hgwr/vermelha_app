import 'package:flutter/foundation.dart';
import 'package:vermelha_app/models/status_parameter.dart';

import './battle_rule.dart';
import './status_parameter.dart';

class Character {
  int? id;
  String name;
  int level;
  int hp;
  int mp;
  int attack;
  int defense;
  int magicPower;
  int speed;
  List<StatusParameter> priorityParameters;
  List<BattleRule> battleRules;

  Character({
    this.id,
    required this.name,
    required this.level,
    required this.hp,
    required this.mp,
    required this.attack,
    required this.defense,
    required this.magicPower,
    required this.speed,
    required this.priorityParameters,
    required this.battleRules,
  });
}
