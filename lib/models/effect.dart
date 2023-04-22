import 'package:flutter/foundation.dart';

import './character.dart';

abstract class Effect {

  final int id;
  final String name;
  final String type;
  final int damage;
  final int heal;
  final int mpCost;
  final int duration;
  final String status;

  const Effect({
    required this.id,
    required this.name,
    required this.type,
    required this.damage,
    required this.heal,
    required this.mpCost,
    required this.duration,
    required this.status,
  });

  void applyEffect(Character subject, Character target);
}
