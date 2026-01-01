import 'package:vermelha_app/models/log_entry.dart';

class DungeonState {
  static const int defaultBattlesToUnlockNextFloor = 3;

  final int floor;
  final String seed;
  final int battleCountOnFloor;
  final int battlesToUnlockNextFloor;
  final List<LogEntry> eventLog;
  final bool isPaused;

  const DungeonState({
    required this.floor,
    required this.seed,
    required this.battleCountOnFloor,
    required this.battlesToUnlockNextFloor,
    required this.eventLog,
    required this.isPaused,
  });
}
