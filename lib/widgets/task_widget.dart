import 'package:flutter/material.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/player_character.dart';

import '../models/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  String taskStatus() {
    switch (task.status) {
      case TaskStatus.running:
        return "${task.progress}%";
      case TaskStatus.finished:
        return "完了";
      case TaskStatus.canceled:
        return "キャンセル";
    }
  }

  Widget leadingWidget() {
    var icon;
    if (task.subject is PlayerCharacter) {
      final playerCharacter = task.subject as PlayerCharacter;
      icon = getImageByJob(playerCharacter.job!);
    } else {
      icon = const Icon(Icons.help);
    }
    final character = task.subject;
    return SizedBox(
      width: 48,
      child: Column(
        children: [
          SizedBox(
            height: 32,
            child: icon,
          ),
          Row(
            children: [
              const Text(
                "HP",
                style: TextStyle(fontSize: 8),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: character.hp / character.maxHp,
                  backgroundColor: Colors.red.shade100,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const Text(
                "MP",
                style: TextStyle(fontSize: 8),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: character.mp / character.maxMp,
                  backgroundColor: Colors.blue.shade100,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final subtitle = taskStatus();
    final leading = leadingWidget();
    if (task.subject is PlayerCharacter) {
      final character = task.subject as PlayerCharacter;
      return ListTile(
        leading: leading,
        title: Text(
          "${character.name}: "
          "${task.action.name} → "
          "${task.targets.map((t) => t.name).join(', ')}",
        ),
        subtitle: Text(subtitle),
      );
    } else {
      final character = task.subject;
      return ListTile(
        leading: leading,
        title: Text(
          "${character.name}: "
          "${task.action.name} → "
          "${task.targets.map((t) => t.name).join(', ')}",
        ),
        subtitle: Text(subtitle),
      );
    }
  }
}
