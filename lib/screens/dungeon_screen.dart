import 'package:flutter/material.dart';

class DungeonScreen extends StatelessWidget {
  const DungeonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dungeon')),
      body: const Center(
        child: Text('Dungeon'),
      ),
    );
  }
}
