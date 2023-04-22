import 'package:flutter/foundation.dart';

enum Comparator {
  eq(operator: '=='),
  ne(operator: '!='),
  gt(operator: '>'),
  gte(operator: '>='),
  lt(operator: '<'),
  lte(operator: '<=');

  final String operator;

  const Comparator({
    required this.operator,
  });

  bool compare(Comparable a, Comparable b) {
    if (operator == eq.operator) {
        return a.compareTo(b) == 0;
    } else if (operator == ne.operator) {
        return a.compareTo(b) != 0;
    } else if (operator == gt.operator) {
        return a.compareTo(b) > 0;
    } else if (operator == gte.operator) {
        return a.compareTo(b) >= 0;
    } else if (operator == lt.operator) {
        return a.compareTo(b) < 0;
    } else if (operator == lte.operator) {
        return a.compareTo(b) <= 0;
    } else {
        return false;
    }
  }
}
