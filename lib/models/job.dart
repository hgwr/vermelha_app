import 'package:flutter/material.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/status_parameter.dart';

enum Job {
  fighter(id: 1, name: '戦士'),
  paladin(id: 2, name: '神殿騎士'),
  ranger(id: 3, name: 'レンジャー'),
  wizard(id: 4, name: '魔法使い'),
  shaman(id: 5, name: 'シャーマン'),
  priest(id: 6, name: '僧侶');

  final int id;
  final String name;

  const Job({
    required this.id,
    required this.name,
  });
}

Job getJobById(int id) {
  switch (id) {
    case 1:
      return Job.fighter;
    case 2:
      return Job.paladin;
    case 3:
      return Job.ranger;
    case 4:
      return Job.wizard;
    case 5:
      return Job.shaman;
    case 6:
      return Job.priest;
    default:
      return Job.fighter;
  }
}

Image getImageByJob(Job job) {
  switch (job) {
    case Job.fighter:
      return Image.asset('assets/images/1_fighter.png');
    case Job.paladin:
      return Image.asset('assets/images/2_paladin.png');
    case Job.ranger:
      return Image.asset('assets/images/3_ranger.png');
    case Job.wizard:
      return Image.asset('assets/images/4_wizard.png');
    case Job.shaman:
      return Image.asset('assets/images/5_shaman.png');
    case Job.priest:
      return Image.asset('assets/images/6_priest.png');
  }
}

PlayerCharacter getInitializedCharacterByJob(Job job) {
  return {
    Job.fighter: PlayerCharacter(
      job: Job.fighter,
      name: '戦士',
      level: 1,
      maxHp: 110,
      hp: 110,
      maxMp: 90,
      mp: 90,
      attack: 12,
      defense: 11,
      magicPower: 8,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.attack,
        StatusParameter.defense,
      ],
      battleRules: <BattleRule>[],
    ),
    Job.paladin: PlayerCharacter(
      job: Job.paladin,
      name: '神殿騎士',
      level: 1,
      maxHp: 115,
      hp: 115,
      maxMp: 95,
      mp: 95,
      attack: 10,
      defense: 12,
      magicPower: 9,
      speed: 9,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.defense,
        StatusParameter.mp,
      ],
      battleRules: <BattleRule>[],
    ),
    Job.ranger: PlayerCharacter(
      job: Job.ranger,
      name: 'レンジャー',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 90,
      mp: 90,
      attack: 11,
      defense: 9,
      magicPower: 9,
      speed: 12,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.attack,
        StatusParameter.speed,
      ],
      battleRules: <BattleRule>[],
    ),
    Job.wizard: PlayerCharacter(
      job: Job.wizard,
      name: '魔法使い',
      level: 1,
      maxHp: 90,
      hp: 90,
      maxMp: 115,
      mp: 115,
      attack: 8,
      defense: 8,
      magicPower: 13,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      battleRules: <BattleRule>[],
    ),
    Job.shaman: PlayerCharacter(
      job: Job.shaman,
      name: 'シャーマン',
      level: 1,
      maxHp: 95,
      hp: 95,
      maxMp: 110,
      mp: 110,
      attack: 9,
      defense: 9,
      magicPower: 12,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      battleRules: <BattleRule>[],
    ),
    Job.priest: PlayerCharacter(
      job: Job.priest,
      name: '僧侶',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 110,
      mp: 110,
      attack: 8,
      defense: 10,
      magicPower: 11,
      speed: 9,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      battleRules: <BattleRule>[],
    ),
  }[job]!;
}
