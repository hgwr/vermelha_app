import 'package:flutter/material.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';

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
    final hpValue = character.maxHp <= 0 ? 0.0 : character.hp / character.maxHp;
    final mpValue = character.maxMp <= 0 ? 0.0 : character.mp / character.maxMp;
    return SizedBox(
      width: 46,
      child: LayoutBuilder(
        builder: (context, constraints) {
          return FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.topCenter,
            child: SizedBox(
              width: constraints.maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                    height: 28,
                    child: icon,
                  ),
                  Row(
                    children: [
                      Text(
                        l10n.hpShort,
                        style: const TextStyle(fontSize: 8),
                      ),
                      const SizedBox(width: 2),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: hpValue.clamp(0, 1),
                          backgroundColor: Colors.red.shade100,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.red),
                          minHeight: 4,
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
                      const SizedBox(width: 2),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: mpValue.clamp(0, 1),
                          backgroundColor: Colors.blue.shade100,
                          valueColor:
                              const AlwaysStoppedAnimation<Color>(Colors.blue),
                          minHeight: 4,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final contextL10n = AppLocalizations.of(context)!;
    final subtitle = taskStatus(context);
    final leading = leadingWidget(context);
    if (task.subject is PlayerCharacter) {
      final character = task.subject as PlayerCharacter;
      return ListTile(
        leading: leading,
        dense: true,
        visualDensity: VisualDensity.compact,
        title: Text(
          "${characterLabel(contextL10n, character)}: "
          "${actionLabel(contextL10n, task.action)} → "
          "${task.targets.map((t) => characterLabel(contextL10n, t)).join(', ')}",
        ),
        subtitle: Text(subtitle),
      );
    } else {
      final character = task.subject;
      return ListTile(
        leading: leading,
        dense: true,
        visualDensity: VisualDensity.compact,
        title: Text(
          "${characterLabel(contextL10n, character)}: "
          "${actionLabel(contextL10n, task.action)} → "
          "${task.targets.map((t) => characterLabel(contextL10n, t)).join(', ')}",
        ),
        subtitle: Text(subtitle),
      );
    }
  }
}
