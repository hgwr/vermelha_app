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

  static Character fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'],
      name: json['name'],
      level: json['level'],
      maxHp: json['maxHp'],
      maxMp: json['maxMp'],
      hp: json['hp'],
      mp: json['mp'],
      attack: json['attack'],
      defense: json['defense'],
      magicPower: json['magicPower'],
      speed: json['speed'],
      job: Job.values.firstWhere((job) => job.name == json['job']),
      priorityParameters: json['priorityParameters']
          .map<StatusParameter>((parameter) => StatusParameter.values
              .firstWhere((statusParameter) =>
                  statusParameter.name == parameter['name']))
          .toList(),
      battleRules: json['battleRules']
          .map<BattleRule>((battleRule) => BattleRule.fromJson(battleRule))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'maxHp': maxHp,
      'maxMp': maxMp,
      'hp': hp,
      'mp': mp,
      'attack': attack,
      'defense': defense,
      'magicPower': magicPower,
      'speed': speed,
      'job': job?.name,
      'priorityParameters': priorityParameters
          .map((statusParameter) => {'name': statusParameter.name})
          .toList(),
      'battleRules': battleRules.map((battleRule) => battleRule.toJson()),
    };
  }

  Character copyWith({
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
    Job? job,
    List<StatusParameter>? priorityParameters,
    List<BattleRule>? battleRules,
  }) {
    return Character(
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
      job: job ?? this.job,
      priorityParameters: priorityParameters ?? this.priorityParameters,
      battleRules: battleRules ?? this.battleRules,
    );
  }
}
