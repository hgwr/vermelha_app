import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/status_parameter.dart';

class Character {
  String? uuid;
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
  List<StatusParameter> priorityParameters;
  List<BattleRule> battleRules;

  Character({
    this.uuid,
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
    required this.priorityParameters,
    required this.battleRules,
  });

  Character copyWith({
    String? uuid,
    int? id,
    String? name,
    int? level,
    int? maxHp,
    int? maxMp,
    int? hp,
    int? mp,
    int? attack,
    int? defense,
    int? magicPower,
    int? speed,
    List<StatusParameter>? priorityParameters,
    List<BattleRule>? battleRules,
  }) {
    return Character(
      uuid: uuid ?? this.uuid,
      id: id ?? this.id,
      name: name ?? this.name,
      level: level ?? this.level,
      maxHp: maxHp ?? this.maxHp,
      maxMp: maxMp ?? this.maxMp,
      hp: hp ?? this.hp,
      mp: mp ?? this.mp,
      attack: attack ?? this.attack,
      defense: defense ?? this.defense,
      magicPower: magicPower ?? this.magicPower,
      speed: speed ?? this.speed,
      priorityParameters: priorityParameters ?? this.priorityParameters,
      battleRules: battleRules ?? this.battleRules,
    );
  }
}
