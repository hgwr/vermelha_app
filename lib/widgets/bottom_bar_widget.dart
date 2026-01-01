import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import '../providers/screen_provider.dart';

class BottomBarWidget extends StatelessWidget {
  const BottomBarWidget({
    Key? key,
    required this.currentScreenIndex,
  }) : super(key: key);

  final int currentScreenIndex;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BottomNavigationBar(
      currentIndex: currentScreenIndex,
      onTap: (index) {
        Provider.of<ScreenProvider>(context, listen: false).changeScreen(index);
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.sports_esports),
          label: l10n.dungeonTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: l10n.partyTitle,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: l10n.settingsTitle,
        ),
      ],
    );
  }
}
