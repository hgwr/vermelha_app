import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/task.dart';
import 'package:vermelha_app/models/vermelha_context.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/widgets/task_widget.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

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
      bottomNavigationBar: const BottomBarWidget(
        currentScreenIndex: ScreenProvider.dungeonScreenIndex,
      ),
    );
  }
}
