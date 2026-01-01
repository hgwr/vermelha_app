import 'package:flutter/material.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: Center(
        child: Text(l10n.settingsBody),
      ),
      bottomNavigationBar: const BottomBarWidget(
        currentScreenIndex: ScreenProvider.settingsScreenIndex,
      ),
    );
  }
}
