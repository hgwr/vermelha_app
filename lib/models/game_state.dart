import 'package:vermelha_app/models/dungeon_state.dart';
import 'package:vermelha_app/models/party.dart';
import 'package:vermelha_app/models/player_character.dart';

class GameState {
  final List<PlayerCharacter> roster;
  final Party party;
  final int gold;
  final int maxReachedFloor;
  final DungeonState? activeDungeon;

  const GameState({
    required this.roster,
    required this.party,
    required this.gold,
    required this.maxReachedFloor,
    required this.activeDungeon,
  });
}
