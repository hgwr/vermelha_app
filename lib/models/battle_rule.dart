import 'package:flutter/foundation.dart';

import './action.dart';
import './target.dart';
import './condition.dart';

class BattleRule {
  final int id;
  final String name;
  final Action action;
  final int priority;
  final Target target;
  final Condition condition;

  const BattleRule({
    required this.id,
    required this.name,
    required this.action,
    required this.priority,
    required this.target,
    required this.condition,
  });
}
