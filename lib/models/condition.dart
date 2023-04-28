import 'package:vermelha_app/models/vermelha_comparator.dart';
import 'package:vermelha_app/models/vermelha_context.dart';
import 'package:vermelha_app/models/character.dart';

abstract class Condition {
  final int id;
  final String name;
  final int value;
  final VermelhaComparator comparator;

  const Condition({
    required this.id,
    required this.name,
    required this.value,
    required this.comparator,
  });

  Character? getTarget(VermelhaContext context);

  bool isSatisfy();
}
