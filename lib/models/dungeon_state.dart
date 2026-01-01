class DungeonState {
  static const int defaultBattlesToUnlockNextFloor = 3;

  final int floor;
  final int battleCountOnFloor;
  final int battlesToUnlockNextFloor;

  const DungeonState({
    required this.floor,
    required this.battleCountOnFloor,
    required this.battlesToUnlockNextFloor,
  });
}
