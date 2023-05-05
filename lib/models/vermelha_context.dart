import 'dart:math';

import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/player_character.dart';

class VermelhaContext {
  final List<PlayerCharacter> allies;
  final List<Character> enemies;

  final random = Random();

  VermelhaContext({
    required this.allies,
    required this.enemies,
  });

  VermelhaContext copyWith({
    List<PlayerCharacter>? allies,
    List<Character>? enemies,
  }) {
    return VermelhaContext(
      allies: allies ?? this.allies,
      enemies: enemies ?? this.enemies,
    );
  }
}
