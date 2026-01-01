import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/dungeon_provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/screens/dungeon_screen.dart';

class DungeonSelectScreen extends StatelessWidget {
  const DungeonSelectScreen({Key? key}) : super(key: key);

  static const routeName = '/dungeon-select';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer2<DungeonProvider, CharactersProvider>(
      builder: (context, dungeonProvider, charactersProvider, _) {
        final canStart = charactersProvider.isPartyComplete;
        final floors = List.generate(
          dungeonProvider.maxReachedFloor,
          (index) => index + 1,
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.dungeonSelectTitle),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.dungeonSelectReachedOnly),
                    const SizedBox(height: 4),
                    Text(
                      l10n.unlockNextFloorProgress(
                        dungeonProvider.battleCountOnFloor,
                        dungeonProvider.battlesToUnlockNextFloor,
                      ),
                    ),
                    if (!canStart) ...[
                      const SizedBox(height: 4),
                      Text(l10n.partyIncomplete),
                    ],
                  ],
                ),
              ),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: floors.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final floor = floors[index];
                    return ListTile(
                      title: Text(l10n.floorLabel(floor)),
                      enabled: canStart,
                      trailing:
                          canStart ? null : const Icon(Icons.lock_outline),
                      onTap: canStart
                          ? () {
                              dungeonProvider.startExploration(floor);
                              final tasksProvider = Provider.of<TasksProvider>(
                                context,
                                listen: false,
                              );
                              tasksProvider.resetBattle(clearLog: true);
                              tasksProvider.startEngine();
                              Navigator.of(context)
                                  .pushNamed(DungeonScreen.routeName);
                            }
                          : null,
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
