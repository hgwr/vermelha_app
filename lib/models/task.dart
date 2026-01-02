import 'package:flutter/foundation.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/vermelha_context.dart';

enum TaskStatus {
  running,
  finished,
  canceled,
}

class Task {
  final String uuid;
  final DateTime startedAt;
  DateTime lastUpdatedAt;
  DateTime? finishedAt;
  final Character subject;
  final Action action;
  final List<Character> targets;
  TaskStatus status;
  double progress = 0;
  final int durationMs;
  int elapsedMs;
  final bool wasTelegraphing;

  Task({
    required this.uuid,
    required this.startedAt,
    required this.lastUpdatedAt,
    this.finishedAt,
    required this.subject,
    required this.action,
    required this.targets,
    required this.status,
    required this.progress,
    required this.durationMs,
    required this.elapsedMs,
    required this.wasTelegraphing,
  });

  double progressPercentage(VermelhaContext context) {
    if (status == TaskStatus.finished) {
      return 100;
    }
    if (status == TaskStatus.canceled) {
      return 0;
    }
    if (durationMs > 0) {
      return (elapsedMs / durationMs) * 100;
    }
    final totalDuration = action.computeDuration(
      action.baseDurationSeconds,
      context,
      subject,
      targets,
    );
    return (elapsedMs / (totalDuration * 1000)) * 100;
  }
}
