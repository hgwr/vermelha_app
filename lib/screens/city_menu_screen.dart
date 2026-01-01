import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';
import 'package:vermelha_app/models/party_position.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/game_state_provider.dart';
import 'package:vermelha_app/screens/dungeon_select_screen.dart';
import 'package:vermelha_app/screens/party_screen.dart';
import 'package:vermelha_app/screens/shop_screen.dart';
import 'package:vermelha_app/screens/tavern_screen.dart';

class CityMenuScreen extends StatelessWidget {
  const CityMenuScreen({Key? key}) : super(key: key);

  static const routeName = '/city';

  String _positionLabel(AppLocalizations l10n, PartyPosition position) {
    switch (position) {
      case PartyPosition.forward:
        return l10n.partyPositionForward;
      case PartyPosition.middle:
        return l10n.partyPositionMiddle;
      case PartyPosition.rear:
        return l10n.partyPositionRear;
    }
  }

  String _memberLabel(AppLocalizations l10n, PlayerCharacter member) {
    final job = member.job;
    final jobName = job == null ? '' : jobLabel(l10n, job);
    return jobName.isEmpty ? member.name : '$jobName ${member.name}';
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
        onTap: () => Navigator.of(context).pushNamed(ShopScreen.routeName),
      ),
      _CityMenuItem(
        label: l10n.dungeonTitle,
        onTap: () =>
            Navigator.of(context).pushNamed(DungeonSelectScreen.routeName),
      ),
      _CityMenuItem(
        label: l10n.saveTitle,
        onTap: () async {
          await Provider.of<GameStateProvider>(context, listen: false)
              .saveGame();
          if (!context.mounted) {
            return;
          }
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.saveSuccess)),
          );
        },
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l10n.cityTitle)),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              child: Consumer2<CharactersProvider, GameStateProvider>(
                builder: (context, charactersProvider, gameStateProvider, _) {
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(l10n.goldLabel),
                          trailing: Text(gameStateProvider.gold.toString()),
                        ),
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(l10n.partyTitle),
                          ),
                        ),
                        ...PartyPosition.values.expand((position) {
                          final member = charactersProvider.memberAt(position);
                          return [
                            ListTile(
                              dense: true,
                              title: Text(_positionLabel(l10n, position)),
                              subtitle: Text(
                                member == null
                                    ? l10n.partySlotEmpty
                                    : _memberLabel(l10n, member),
                              ),
                            ),
                            if (position != PartyPosition.values.last)
                              const Divider(height: 1),
                          ];
                        }),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
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
          ],
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
