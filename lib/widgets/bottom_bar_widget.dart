import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/screen_provider.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.currentScreenIndex,
  }) : super(key: key);

  final int currentScreenIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentScreenIndex,
      onTap: (index) {
        Provider.of<ScreenProvider>(context, listen: false).changeScreen(index);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports),
          label: 'Dungeon',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Party',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
        ),
      ],
    );
  }
}
