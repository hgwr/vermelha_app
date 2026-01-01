enum LogType {
  explore,
  battle,
  loot,
  system,
}

enum LogMessageId {
  explorationStart,
  battleEncounter,
  battleAction,
  battleVictory,
  lootNone,
  campHeal,
  returnToCity,
}

class LogEntry {
  final DateTime timestamp;
  final LogType type;
  final LogMessageId messageId;
  final Map<String, String>? data;

  LogEntry({
    required this.timestamp,
    required this.type,
    required this.messageId,
    this.data,
  });
}
