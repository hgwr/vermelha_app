import 'package:flutter/material.dart';
import 'package:vermelha_app/models/vermelha_context.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class DungeonScreen extends StatefulWidget {
  const DungeonScreen({Key? key}) : super(key: key);

  static const routeName = '/dungeon';

  @override
  State<DungeonScreen> createState() => _DungeonScreenState();
}

class _DungeonScreenState extends State<DungeonScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dungeon')),
      body: const Center(
        child: Text('Dungeon'),
      ),
      bottomNavigationBar: const BottomBarWidget(
        currentScreenIndex: ScreenProvider.dungeonScreenIndex,
      ),
    );
  }
}
