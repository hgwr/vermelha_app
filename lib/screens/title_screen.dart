import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/screens/city_menu_screen.dart';
import 'package:vermelha_app/screens/dungeon_screen.dart';
import 'package:vermelha_app/providers/game_state_provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({Key? key}) : super(key: key);

  static const routeName = '/title';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  l10n.appTitle,
                  style: textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      await Provider.of<GameStateProvider>(context,
                              listen: false)
                          .startNewGame();
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.of(context).pushReplacementNamed(
                        CityMenuScreen.routeName,
                      );
                    },
                    child: Text(l10n.newGame),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () async {
                      await Provider.of<GameStateProvider>(context,
                              listen: false)
                          .loadGame();
                      Provider.of<TasksProvider>(context, listen: false)
                          .resetBattle();
                      final hasActiveDungeon =
                          Provider.of<GameStateProvider>(context, listen: false)
                              .hasActiveDungeon;
                      final destination = hasActiveDungeon
                          ? DungeonScreen.routeName
                          : CityMenuScreen.routeName;
                      if (!context.mounted) {
                        return;
                      }
                      Navigator.of(context).pushReplacementNamed(destination);
                    },
                    child: Text(l10n.loadGame),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
