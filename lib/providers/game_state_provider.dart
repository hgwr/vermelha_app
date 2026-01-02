import 'dart:async';

import 'package:flutter/material.dart';
import 'package:vermelha_app/models/game_state.dart';
import 'package:vermelha_app/models/party.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/dungeon_provider.dart';
import 'package:vermelha_app/repository/game_state_repository.dart';

class GameStateProvider extends ChangeNotifier {
  final GameStateRepository _repository;
  CharactersProvider? _charactersProvider;
  DungeonProvider? _dungeonProvider;

  int gold = 0;
  bool _loaded = false;

  GameStateProvider([GameStateRepository? repository])
      : _repository = repository ?? GameStateRepository();

  void updateDependencies(
    CharactersProvider charactersProvider,
    DungeonProvider dungeonProvider,
  ) {
    if (_charactersProvider != charactersProvider) {
      _charactersProvider?.removeListener(_autoSave);
      _charactersProvider = charactersProvider;
      _charactersProvider?.addListener(_autoSave);
    }
    if (_dungeonProvider != dungeonProvider) {
      _dungeonProvider?.removeListener(_autoSave);
      _dungeonProvider = dungeonProvider;
      _dungeonProvider?.addListener(_autoSave);
    }
  }

  bool get hasActiveDungeon => _dungeonProvider?.isExploring ?? false;

  Future<void> startNewGame() async {
    if (_charactersProvider != null) {
      await _charactersProvider!.clearAll();
    }
    gold = 0;
    _dungeonProvider?.reset();
    _loaded = true;
    await saveGame();
    notifyListeners();
  }

  Future<void> loadGame() async {
    if (_charactersProvider != null) {
      await _charactersProvider!.loadCharacters();
    }
    final roster = _charactersProvider?.characters ?? [];
    final state = await _repository.load(roster: roster);
    gold = state.gold;
    _dungeonProvider?.applyGameState(state);
    _loaded = true;
    notifyListeners();
  }

  Future<void> saveGame() async {
    if (_charactersProvider == null || _dungeonProvider == null) {
      return;
    }
    final state = GameState(
      roster: _charactersProvider!.characters,
      party: Party.fromRoster(_charactersProvider!.characters),
      gold: gold,
      maxReachedFloor: _dungeonProvider!.maxReachedFloor,
      activeDungeon: _dungeonProvider!.toDungeonState(),
    );
    await _repository.save(state);
  }

  Future<bool> spendGold(int amount) async {
    if (gold < amount) {
      return false;
    }
    gold -= amount;
    await saveGame();
    notifyListeners();
    return true;
  }

  Future<void> addGold(int amount) async {
    gold += amount;
    await saveGame();
    notifyListeners();
  }

  void _autoSave() {
    if (!_loaded) {
      return;
    }
    unawaited(saveGame());
  }
}
