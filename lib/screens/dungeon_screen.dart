import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/dungeon_provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/widgets/task_widget.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/screens/camp_screen.dart';
import 'package:vermelha_app/screens/city_menu_screen.dart';
import 'package:vermelha_app/models/log_entry.dart';

class DungeonScreen extends StatefulWidget {
  const DungeonScreen({Key? key}) : super(key: key);

  static const routeName = '/dungeon';

  @override
  State<DungeonScreen> createState() => _DungeonScreenState();
}

class _DungeonScreenState extends State<DungeonScreen> {
  final ScrollController _scrollController = ScrollController();

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  String _logTypeLabel(AppLocalizations l10n, LogType type) {
    switch (type) {
      case LogType.explore:
        return l10n.logTypeExplore;
      case LogType.battle:
        return l10n.logTypeBattle;
      case LogType.loot:
        return l10n.logTypeLoot;
      case LogType.system:
        return l10n.logTypeSystem;
    }
  }

  String _logMessage(AppLocalizations l10n, LogEntry entry) {
    switch (entry.messageId) {
      case LogMessageId.explorationStart:
        return l10n.logExplorationStart;
      case LogMessageId.battleEncounter:
        return l10n.logBattleEncounter;
      case LogMessageId.battleAction:
        final subject = entry.data?['subject'] ?? '';
        final action = entry.data?['action'] ?? '';
        final targets = entry.data?['targets'] ?? '';
        return l10n.logBattleAction(subject, action, targets);
      case LogMessageId.battleVictory:
        return l10n.logBattleVictory;
      case LogMessageId.lootNone:
        return l10n.logLootNone;
      case LogMessageId.campHeal:
        return l10n.logCampHeal;
      case LogMessageId.returnToCity:
        return l10n.logReturnToCity;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final dungeonProvider = Provider.of<DungeonProvider>(context);
    final activeFloor = dungeonProvider.activeFloor ?? 1;
    final battleCount = dungeonProvider.battleCountOnFloor;
    final battlesToUnlock = dungeonProvider.battlesToUnlockNextFloor;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dungeonTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.floorLabel(activeFloor)),
                const SizedBox(height: 4),
                Text(l10n.battleCountProgress(battleCount, battlesToUnlock)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Consumer<TasksProvider>(
                builder: (context, taskProvider, _) {
                  final logs = taskProvider.logEntries;
                  return Card(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return Text(
                          "[${_logTypeLabel(l10n, log.type)}] "
                          "${_logMessage(l10n, log)}",
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TasksProvider>(
                builder: (ctx, taskProvider, child) {
                  taskProvider.scrollDownFunc = scrollDown;

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (ctx, index) {
                      final task = taskProvider.tasks[index];
                      return TaskWidget(
                        key: ValueKey(task.uuid.toString()),
                        task: task,
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final charactersProvider =
              Provider.of<CharactersProvider>(context, listen: false);
          if (!charactersProvider.isPartyComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.partyIncomplete),
              ),
            );
            return;
          }
          Provider.of<TasksProvider>(context, listen: false).engineStatus ==
                  EngineStatus.running
              ? Provider.of<TasksProvider>(context, listen: false).pauseEngine()
              : Provider.of<TasksProvider>(context, listen: false)
                  .startEngine();
        },
        child: Provider.of<TasksProvider>(context).engineStatus ==
                EngineStatus.running
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Provider.of<TasksProvider>(context, listen: false)
                        .pauseEngine();
                    Navigator.of(context).pushNamed(CampScreen.routeName);
                  },
                  child: Text(l10n.campButton),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Provider.of<TasksProvider>(context, listen: false)
                        .addLog(LogType.system, LogMessageId.returnToCity);
                    Provider.of<TasksProvider>(context, listen: false)
                        .resetBattle();
                    Provider.of<DungeonProvider>(context, listen: false)
                        .returnToCity();
                    Navigator.of(context).popUntil(
                      (route) => route.settings.name == CityMenuScreen.routeName,
                    );
                  },
                  child: Text(l10n.returnToCity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
