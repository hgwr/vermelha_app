enum LogType {
  explore,
  battle,
  loot,
  system,
}

enum LogMessageId {
  explorationStart,
  explorationMove,
  explorationTreasure,
  explorationTrap,
  battleEncounter,
  battleAction,
  battleVictory,
  lootNone,
  lootGold,
  lootItem,
  campHeal,
  returnToCity,
}

LogType _logTypeFromString(String value) {
  return LogType.values.firstWhere(
    (type) => type.name == value,
    orElse: () => LogType.system,
  );
}

LogMessageId _logMessageIdFromString(String value) {
  return LogMessageId.values.firstWhere(
    (id) => id.name == value,
    orElse: () => LogMessageId.explorationStart,
  );
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

  Map<String, dynamic> toJson() {
    return {
      'timestamp': timestamp.toIso8601String(),
      'type': type.name,
      'message_id': messageId.name,
      'data': data,
    };
  }

  static LogEntry fromJson(Map<String, dynamic> json) {
    final rawData = json['data'];
    Map<String, String>? data;
    if (rawData is Map) {
      data = rawData.map(
        (key, value) => MapEntry(key.toString(), value.toString()),
      );
    }
    return LogEntry(
      timestamp: DateTime.parse(json['timestamp'] as String),
      type: _logTypeFromString(json['type'] as String),
      messageId: _logMessageIdFromString(json['message_id'] as String),
      data: data,
    );
  }
}
