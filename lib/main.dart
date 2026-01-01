import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/providers/dungeon_provider.dart';
import 'package:vermelha_app/screens/character_screen.dart';
import 'package:vermelha_app/screens/camp_screen.dart';
import 'package:vermelha_app/screens/city_menu_screen.dart';
import 'package:vermelha_app/screens/dungeon_select_screen.dart';
import 'package:vermelha_app/screens/edit_battle_rules_screen.dart';
import 'package:vermelha_app/screens/edit_priority_parameters_screen.dart';
import 'package:vermelha_app/screens/select_action_screen.dart';
import 'package:vermelha_app/screens/select_condition_screen.dart';
import 'package:vermelha_app/screens/select_player_characters_screen.dart';
import 'package:vermelha_app/screens/select_target_screen.dart';
import 'package:vermelha_app/screens/tavern_screen.dart';
import 'package:vermelha_app/screens/title_screen.dart';

import './db/db_migration.dart';
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
  final CharactersProvider charactersProvider = CharactersProvider();

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
          value: charactersProvider,
        ),
        ChangeNotifierProvider.value(
          value: DungeonProvider(),
        ),
        ChangeNotifierProxyProvider2<CharactersProvider, DungeonProvider,
            TasksProvider>(
          create: (_) => TasksProvider(charactersProvider),
          update: (_, charactersProvider, dungeonProvider, tasksProvider) {
            tasksProvider!.charactersProvider = charactersProvider;
            tasksProvider.dungeonProvider = dungeonProvider;
            return tasksProvider;
          },
        ),
      ],
      child: MaterialApp(
        onGenerateTitle: (titleContext) =>
            AppLocalizations.of(titleContext)!.appTitle,
        theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            iconTheme: IconThemeData(color: Colors.black),
          ),
        ),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('ja'),
        ],
        home: const TitleScreen(),
        routes: {
          TitleScreen.routeName: (ctx) => const TitleScreen(),
          CityMenuScreen.routeName: (ctx) => const CityMenuScreen(),
          TavernScreen.routeName: (ctx) => const TavernScreen(),
          DungeonSelectScreen.routeName: (ctx) => const DungeonSelectScreen(),
          DungeonScreen.routeName: (ctx) => const DungeonScreen(),
          CampScreen.routeName: (ctx) => const CampScreen(),
          PartyScreen.routeName: (ctx) => const PartyScreen(),
          SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          CharacterScreen.routeName: (ctx) => const CharacterScreen(),
          EditPriorityParametersScreen.routeName: (ctx) =>
              const EditPriorityParametersScreen(),
          EditBattleRulesScreen.routeName: (ctx) =>
              const EditBattleRulesScreen(),
          SelectConditionScreen.routeName: (ctx) =>
              const SelectConditionScreen(),
          SelectActionScreen.routeName: (ctx) => const SelectActionScreen(),
          SelectTargetScreen.routeName: (ctx) => const SelectTargetScreen(),
          SelectPlayerCharactersScreen.routeName: (ctx) =>
              const SelectPlayerCharactersScreen(),
        },
      ),
    );
  }
}
