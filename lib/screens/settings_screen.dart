import 'package:flutter/material.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: const Center(
        child: Text('Settings'),
      ),
      bottomNavigationBar: const BottomBarWidget(
        currentScreenIndex: ScreenProvider.settingsScreenIndex,
      ),
    );
  }
}
