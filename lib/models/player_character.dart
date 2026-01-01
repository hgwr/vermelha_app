import 'dart:convert';

import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/equipment_slot.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/party_position.dart';
import 'package:vermelha_app/models/status_parameter.dart';

class PlayerCharacter extends Character {
  Job? job;
  int exp = 0;
  bool isActive = true;
  PartyPosition? partyPosition;
  List<Item> inventory;
  Map<EquipmentSlot, Item?> equipment;
  int inventoryCapacity;
  Map<StatusParameter, int> jobBonus;

  PlayerCharacter({
    uuid,
    id,
    required name,
    required level,
    required maxHp,
    required maxMp,
    required hp,
    required mp,
    required attack,
    required defense,
    required magicPower,
    required speed,
    required priorityParameters,
    required battleRules,
    this.inventory = const [],
    this.equipment = const {},
    this.inventoryCapacity = 10,
    this.jobBonus = const {},
    this.job,
    this.exp = 0,
    this.isActive = true,
    this.partyPosition,
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

  static PlayerCharacter fromJson(Map<String, dynamic> json) {
    return PlayerCharacter(
      id: json['id'],
      name: json['name'],
      level: json['level'],
      maxHp: json['max_hp'],
      maxMp: json['max_mp'],
      hp: json['hp'],
      mp: json['mp'],
      attack: json['attack'],
      defense: json['defense'],
      magicPower: json['magic_power'],
      speed: json['speed'],
      job: getJobById(json['job_id'] as int),
      priorityParameters: <StatusParameter>[],
      battleRules: <BattleRule>[],
      exp: json['exp'],
      jobBonus: _decodeJobBonus(json['job_bonus']),
      isActive: json['is_active'] == 1,
      partyPosition: partyPositionFromDb(json['party_position']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'level': level,
      'max_hp': maxHp,
      'max_mp': maxMp,
      'hp': hp,
      'mp': mp,
      'attack': attack,
      'defense': defense,
      'magic_power': magicPower,
      'speed': speed,
      'job_id': job?.id,
      'exp': exp,
      'job_bonus': _encodeJobBonus(jobBonus),
      'is_active': isActive ? 1 : 0,
      'party_position': partyPosition?.index,
    };
  }

  static Map<StatusParameter, int> _decodeJobBonus(Object? value) {
    if (value == null) {
      return {};
    }
    final raw = value is String ? value : value.toString();
    if (raw.isEmpty) {
      return {};
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return {};
      }
      final Map<StatusParameter, int> bonuses = {};
      decoded.forEach((key, amount) {
        final keyString = key.toString();
        final parameter = _statusParameterFromName(keyString);
        if (parameter == null || amount is! num) {
          return;
        }
        bonuses[parameter] = amount.round();
      });
      return bonuses;
    } catch (_) {
      return {};
    }
  }

  static String _encodeJobBonus(Map<StatusParameter, int> jobBonus) {
    final mapped = jobBonus.map((key, value) => MapEntry(key.name, value));
    return jsonEncode(mapped);
  }

  static StatusParameter? _statusParameterFromName(String name) {
    try {
      return StatusParameter.values.byName(name);
    } catch (_) {
      return null;
    }
  }

  @override
  PlayerCharacter copyWith({
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
    Job? job,
    List<StatusParameter>? priorityParameters,
    List<BattleRule>? battleRules,
    List<Item>? inventory,
    Map<EquipmentSlot, Item?>? equipment,
    int? inventoryCapacity,
    Map<StatusParameter, int>? jobBonus,
    int? exp,
    bool? isActive,
    PartyPosition? partyPosition,
  }) {
    return PlayerCharacter(
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
      job: job ?? this.job,
      priorityParameters: priorityParameters ?? this.priorityParameters,
      battleRules: battleRules ?? this.battleRules,
      inventory: inventory ?? this.inventory,
      equipment: equipment ?? this.equipment,
      inventoryCapacity: inventoryCapacity ?? this.inventoryCapacity,
      jobBonus: jobBonus ?? this.jobBonus,
      exp: exp ?? this.exp,
      isActive: isActive ?? this.isActive,
      partyPosition: partyPosition ?? this.partyPosition,
    );
  }
}
