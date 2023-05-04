import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/screens/character_screen.dart';
import 'package:vermelha_app/screens/edit_battle_rules_screen.dart';
import 'package:vermelha_app/screens/edit_priority_parameters_screen.dart';
import 'package:vermelha_app/screens/select_action_screen.dart';
import 'package:vermelha_app/screens/select_condition_screen.dart';
import 'package:vermelha_app/screens/select_player_characters_screen.dart';

import './db/db_migration.dart';
import './providers/screen_provider.dart';
import './providers/characters_provider.dart';
import './screens/dungeon_screen.dart';
import './screens/party_screen.dart';
import './screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget getHome(int screenIndex) {
    if (screenIndex == ScreenProvider.dungeonScreenIndex) {
      return const DungeonScreen();
    } else if (screenIndex == ScreenProvider.partyScreenIndex) {
      return const PartyScreen();
    } else if (screenIndex == ScreenProvider.settingsScreenIndex) {
      return const SettingsScreen();
    } else {
      return const DungeonScreen();
    }
  }

  final CharactersProvider charactersProvider = CharactersProvider();
  final TasksProvider tasksProvider = TasksProvider();

  @override
  void initState() {
    super.initState();
    migrateDatabase();
    charactersProvider.loadCharacters();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ScreenProvider(),
        ),
        ChangeNotifierProvider.value(
          value: charactersProvider,
        ),
      ],
      child: Consumer<ScreenProvider>(
        builder: (ctx, screenProvider, _) => MaterialApp(
          title: 'Vermelha',
          theme: ThemeData(
            appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
              iconTheme: IconThemeData(color: Colors.black),
            ),
          ),
          home: getHome(screenProvider.currentScreenIndex),
          routes: {
            DungeonScreen.routeName: (ctx) => const DungeonScreen(),
            PartyScreen.routeName: (ctx) => const PartyScreen(),
            SettingsScreen.routeName: (ctx) => const SettingsScreen(),
            CharacterScreen.routeName: (ctx) => CharacterScreen(),
            EditPriorityParametersScreen.routeName: (ctx) =>
                const EditPriorityParametersScreen(),
            EditBattleRulesScreen.routeName: (ctx) =>
                const EditBattleRulesScreen(),
            SelectConditionScreen.routeName: (ctx) =>
                const SelectConditionScreen(),
            SelectActionScreen.routeName: (ctx) => const SelectActionScreen(),
            SelectPlayerCharactersScreen.routeName: (ctx) =>
                const SelectPlayerCharactersScreen(),
          },
        ),
      ),
    );
  }
}
