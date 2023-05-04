import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/models/vermelha_context.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';

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
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TasksProvider>(
                builder: (context, value, child) {
                  return ListView(
                    children: [
                      for (var task in value.tasks)
                        ListTile(
                          key: ValueKey(task.uuid),
                          title: Text(task.uuid),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<TasksProvider>(context, listen: false)
                      .startEngine();
                },
                child: const Text('Start'),
              ),
              ElevatedButton(
                onPressed: () {
                  Provider.of<TasksProvider>(context, listen: false)
                      .pauseEngine();
                },
                child: const Text('Pause'),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: const BottomBarWidget(
        currentScreenIndex: ScreenProvider.dungeonScreenIndex,
      ),
    );
  }
}
