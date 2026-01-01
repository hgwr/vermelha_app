import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/providers/dungeon_provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/screens/dungeon_screen.dart';

class DungeonSelectScreen extends StatelessWidget {
  const DungeonSelectScreen({Key? key}) : super(key: key);

  static const routeName = '/dungeon-select';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<DungeonProvider>(
      builder: (context, dungeonProvider, _) {
        final floors = List.generate(
          dungeonProvider.maxReachedFloor,
          (index) => index + 1,
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.dungeonSelectTitle),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: floors.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final floor = floors[index];
              return ListTile(
                title: Text(l10n.floorLabel(floor)),
                onTap: () {
                  dungeonProvider.startExploration(floor);
                  Provider.of<TasksProvider>(context, listen: false)
                      .resetBattle();
                  Navigator.of(context).pushNamed(DungeonScreen.routeName);
                },
              );
            },
          ),
        );
      },
    );
  }
}
