import 'package:flutter/material.dart';
import 'package:vermelha_app/models/dungeon_state.dart';
import 'package:vermelha_app/models/game_state.dart';

class DungeonProvider extends ChangeNotifier {
  static const int defaultBattlesToUnlockNextFloor = 3;

  int maxReachedFloor = 1;
  int? activeFloor;
  int battleCountOnFloor = 0;
  int battlesToUnlockNextFloor = defaultBattlesToUnlockNextFloor;

  bool get isExploring => activeFloor != null;

  void startExploration(int floor) {
    activeFloor = floor;
    battleCountOnFloor = 0;
    notifyListeners();
  }

  void applyGameState(GameState state) {
    maxReachedFloor = state.maxReachedFloor;
    final activeDungeon = state.activeDungeon;
    if (activeDungeon == null) {
      activeFloor = null;
      battleCountOnFloor = 0;
      battlesToUnlockNextFloor = defaultBattlesToUnlockNextFloor;
    } else {
      activeFloor = activeDungeon.floor;
      battleCountOnFloor = activeDungeon.battleCountOnFloor;
      battlesToUnlockNextFloor = activeDungeon.battlesToUnlockNextFloor;
    }
    notifyListeners();
  }

  DungeonState? toDungeonState() {
    if (!isExploring || activeFloor == null) {
      return null;
    }
    return DungeonState(
      floor: activeFloor!,
      battleCountOnFloor: battleCountOnFloor,
      battlesToUnlockNextFloor: battlesToUnlockNextFloor,
    );
  }

  void reset() {
    maxReachedFloor = 1;
    activeFloor = null;
    battleCountOnFloor = 0;
    battlesToUnlockNextFloor = defaultBattlesToUnlockNextFloor;
    notifyListeners();
  }

  void registerBattle() {
    if (!isExploring) {
      return;
    }
    battleCountOnFloor += 1;
    if (activeFloor != null &&
        activeFloor == maxReachedFloor &&
        battleCountOnFloor >= battlesToUnlockNextFloor) {
      maxReachedFloor = activeFloor! + 1;
    }
    notifyListeners();
  }

  void returnToCity() {
    activeFloor = null;
    battleCountOnFloor = 0;
    notifyListeners();
  }
}
