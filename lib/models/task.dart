import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/player_character.dart';

enum TaskStatus {
  running,
  finished,
  canceled,
}

class Task {
  final String uuid;
  final DateTime startedAt;
  DateTime? finishedAt;
  final PlayerCharacter subject;
  final Action action;
  final List<PlayerCharacter> targets;
  TaskStatus status;

  Task({
    required this.uuid,
    required this.startedAt,
    this.finishedAt,
    required this.subject,
    required this.action,
    required this.targets,
    required this.status,
  });
}
