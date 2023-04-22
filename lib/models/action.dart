import 'package:flutter/foundation.dart';

import './effect.dart';
import './condition.dart';

class Action {
  final int id;
  final String name;
  final String type;
  final Effect effect;
  final int power;
  final int accuracy;
  final int mpCost;
  final Condition condition;

  const Action({
    required this.id,
    required this.name,
    required this.type,
    required this.effect,
    required this.power,
    required this.accuracy,
    required this.mpCost,
    required this.condition,
  });
}
