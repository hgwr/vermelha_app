import 'dart:math';

import 'package:vermelha_app/models/character.dart';

class VermelhaContext {
  final List<Character> allies;
  final List<Character> enemies;

  final random = Random();

  VermelhaContext({
    required this.allies,
    required this.enemies,
  });
}
