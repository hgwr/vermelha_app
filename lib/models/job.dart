import 'package:flutter/material.dart';

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
