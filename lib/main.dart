import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/screen_provider.dart';

import '../screens/dungeon_screen.dart';
import '../screens/party_screen.dart';
import '../screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: ScreenProvider(),
        ),
      ],
      child: Consumer<ScreenProvider>(
        builder: (ctx, screenProvider, _) => MaterialApp(
          title: 'Vermelha',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: getHome(screenProvider.currentScreenIndex),
          routes: {
            DungeonScreen.routeName: (ctx) => const DungeonScreen(),
            PartyScreen.routeName: (ctx) => const PartyScreen(),
            SettingsScreen.routeName: (ctx) => const SettingsScreen(),
          },
        ),
      ),
    );
  }
}
