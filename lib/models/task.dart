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
  DateTime? finishedAt;
  final Character subject;
  final Action action;
  final List<Character> targets;
  TaskStatus status;
  double progress = 0;

  Task({
    required this.uuid,
    required this.startedAt,
    this.finishedAt,
    required this.subject,
    required this.action,
    required this.targets,
    required this.status,
    required this.progress,
  });

  double progressPercentage(VermelhaContext context) {
    if (status == TaskStatus.finished) {
      return 100;
    }
    if (status == TaskStatus.canceled) {
      return 0;
    }
    final now = DateTime.now();
    final duration = now.difference(startedAt);
    final totalDuration = action.computeDuration(
      action.baseDurationSeconds,
      context,
      subject,
      targets,
    );
    return (duration.inMilliseconds / totalDuration * 1000) / 100.0;
  }
}
