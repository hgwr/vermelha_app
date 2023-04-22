import 'package:flutter/foundation.dart';

import './target.dart';
import './comparator.dart';

class Condition {
  final int id;
  final String name;
  final String type;
  final Target target;
  final int value;
  final Comparator comparator;

  const Condition({
    required this.id,
    required this.name,
    required this.type,
    required this.target,
    required this.value,
    required this.comparator,
  });
}
