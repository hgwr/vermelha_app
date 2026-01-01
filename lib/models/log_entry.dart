enum LogType {
  explore,
  battle,
  loot,
  system,
}

enum LogMessageId {
  explorationStart,
  battleEncounter,
  battleVictory,
  lootNone,
  campHeal,
  returnToCity,
}

class LogEntry {
  final DateTime timestamp;
  final LogType type;
  final LogMessageId messageId;

  LogEntry({
    required this.timestamp,
    required this.type,
    required this.messageId,
  });
}
