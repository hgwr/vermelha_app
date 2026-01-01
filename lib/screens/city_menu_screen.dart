import 'package:flutter/material.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/screens/dungeon_screen.dart';
import 'package:vermelha_app/screens/party_screen.dart';
import 'package:vermelha_app/screens/placeholder_screen.dart';
import 'package:vermelha_app/screens/tavern_screen.dart';

class CityMenuScreen extends StatelessWidget {
  const CityMenuScreen({Key? key}) : super(key: key);

  static const routeName = '/city';

  void _openPlaceholder(BuildContext context, String title) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PlaceholderScreen(title: title),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final items = [
      _CityMenuItem(
        label: l10n.tavernTitle,
        onTap: () => Navigator.of(context).pushNamed(TavernScreen.routeName),
      ),
      _CityMenuItem(
        label: l10n.partyTitle,
        onTap: () => Navigator.of(context).pushNamed(PartyScreen.routeName),
      ),
      _CityMenuItem(
        label: l10n.shopTitle,
        onTap: () => _openPlaceholder(context, l10n.shopTitle),
      ),
      _CityMenuItem(
        label: l10n.dungeonTitle,
        onTap: () => Navigator.of(context).pushNamed(DungeonScreen.routeName),
      ),
      _CityMenuItem(
        label: l10n.saveTitle,
        onTap: () => _openPlaceholder(context, l10n.saveTitle),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cityTitle)),
      body: SafeArea(
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: items.length,
          separatorBuilder: (_, __) => const Divider(height: 1),
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.label),
              onTap: item.onTap,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
            );
          },
        ),
      ),
    );
  }
}

class _CityMenuItem {
  const _CityMenuItem({
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;
}
