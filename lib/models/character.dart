import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/status_parameter.dart';

class Character {
  int? id;
  String name;
  int level;
  int maxHp;
  int maxMp;
  int hp;
  int mp;
  int attack;
  int defense;
  int magicPower;
  int speed;
  Job? job;
  List<StatusParameter> priorityParameters;
  List<BattleRule> battleRules;

  Character({
    this.id,
    required this.name,
    required this.level,
    required this.maxHp,
    required this.maxMp,
    required this.hp,
    required this.mp,
    required this.attack,
    required this.defense,
    required this.magicPower,
    required this.speed,
    this.job,
    required this.priorityParameters,
    required this.battleRules,
  });
}
