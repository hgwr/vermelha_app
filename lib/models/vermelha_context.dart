import 'dart:math';

import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/player_character.dart';

class VermelhaContext {
  final List<PlayerCharacter> allies;
  final List<Character> enemies;
  final Map<Character, Character> lastAttackers;
  final Set<Character> defending;

  final random = Random();

  VermelhaContext({
    required this.allies,
    required this.enemies,
    Map<Character, Character>? lastAttackers,
    Set<Character>? defending,
  })  : lastAttackers = lastAttackers ?? {},
        defending = defending ?? {};

  VermelhaContext copyWith({
    List<PlayerCharacter>? allies,
    List<Character>? enemies,
    Map<Character, Character>? lastAttackers,
    Set<Character>? defending,
  }) {
    return VermelhaContext(
      allies: allies ?? this.allies,
      enemies: enemies ?? this.enemies,
      lastAttackers: lastAttackers ?? this.lastAttackers,
      defending: defending ?? this.defending,
    );
  }
}
