import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class DungeonScreen extends StatelessWidget {
  const DungeonScreen({Key? key}) : super(key: key);

  static const routeName = '/dungeon';

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
