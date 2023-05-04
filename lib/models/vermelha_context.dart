import 'dart:math';

import 'package:vermelha_app/models/player_character.dart';

class VermelhaContext {
  final List<PlayerCharacter> allies;
  final List<PlayerCharacter> enemies;

  final random = Random();

  VermelhaContext({
    required this.allies,
    required this.enemies,
  });
}
