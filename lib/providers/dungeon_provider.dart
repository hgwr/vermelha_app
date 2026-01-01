import 'package:flutter/material.dart';

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
