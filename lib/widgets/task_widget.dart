import 'package:flutter/material.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import '../models/task.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.task,
  });

  final Task task;

  String taskStatus(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    switch (task.status) {
      case TaskStatus.running:
        return l10n.progressPercent(task.progress.toStringAsFixed(0));
      case TaskStatus.finished:
        return l10n.taskStatusComplete;
      case TaskStatus.canceled:
        return l10n.taskStatusCanceled;
    }
  }

  Widget leadingWidget(BuildContext context) {
    Widget icon;
    if (task.subject is PlayerCharacter) {
      final playerCharacter = task.subject as PlayerCharacter;
      icon = getImageByJob(playerCharacter.job!);
    } else {
      icon = const Icon(Icons.help);
    }
    final character = task.subject;
    final l10n = AppLocalizations.of(context)!;
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
              Text(
                l10n.hpShort,
                style: const TextStyle(fontSize: 8),
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
              Text(
                l10n.mpShort,
                style: const TextStyle(fontSize: 8),
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
    final subtitle = taskStatus(context);
    final leading = leadingWidget(context);
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
