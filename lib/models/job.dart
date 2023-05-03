import 'package:flutter/material.dart';
import 'package:vermelha_app/models/character.dart';
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

Character getInitializedCharacterByJob(Job job) {
  return {
    Job.fighter: Character(
      job: Job.fighter,
      name: '戦士',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 100,
      mp: 100,
      attack: 10,
      defense: 10,
      magicPower: 10,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.attack,
        StatusParameter.defense,
      ],
      battleRules: [],
    ),
    Job.paladin: Character(
      job: Job.paladin,
      name: '神殿騎士',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 100,
      mp: 100,
      attack: 10,
      defense: 10,
      magicPower: 10,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.defense,
        StatusParameter.mp,
      ],
      battleRules: [],
    ),
    Job.ranger: Character(
      job: Job.ranger,
      name: 'レンジャー',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 100,
      mp: 100,
      attack: 10,
      defense: 10,
      magicPower: 10,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.attack,
        StatusParameter.speed,
      ],
      battleRules: [],
    ),
    Job.wizard: Character(
      job: Job.wizard,
      name: '魔法使い',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 100,
      mp: 100,
      attack: 10,
      defense: 10,
      magicPower: 10,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      battleRules: [],
    ),
    Job.shaman: Character(
      job: Job.shaman,
      name: 'シャーマン',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 100,
      mp: 100,
      attack: 10,
      defense: 10,
      magicPower: 10,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      battleRules: [],
    ),
    Job.priest: Character(
      job: Job.priest,
      name: '僧侶',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 100,
      mp: 100,
      attack: 10,
      defense: 10,
      magicPower: 10,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      battleRules: [],
    ),
  }[job]!;
}
