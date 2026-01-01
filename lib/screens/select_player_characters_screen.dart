import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import '../providers/characters_provider.dart';
import 'package:vermelha_app/models/player_character.dart';

class SelectPlayerCharactersScreen extends StatefulWidget {
  static const routeName = '/select-player-characters';

  const SelectPlayerCharactersScreen({super.key});

  @override
  State<SelectPlayerCharactersScreen> createState() =>
      _SelectPlayerCharactersScreenState();
}

class _SelectPlayerCharactersScreenState
    extends State<SelectPlayerCharactersScreen> {
  List<PlayerCharacter> _playerCharacters = [];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _playerCharacters =
          ModalRoute.of(context)!.settings.arguments as List<PlayerCharacter>;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectPlayerCharactersTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: createListView(),
            ),
          ),
        ],
      ),
    );
  }

  Widget createListView() {
    if (Provider.of<CharactersProvider>(context).characters.isEmpty) {
      final l10n = AppLocalizations.of(context)!;
      return Center(
        child: Text(l10n.noCharactersFound),
      );
    }
    return ListView(
      children: [
        for (var character
            in Provider.of<CharactersProvider>(context).characters)
          ListTile(
            key: ValueKey(character.id),
            leading:
                _playerCharacters.where((c) => c.id == character.id).isNotEmpty
                    ? const Icon(Icons.check)
                    : null,
            title: Text(character.name),
            onTap: () {
              if (_playerCharacters
                  .where((c) => c.id == character.id)
                  .isNotEmpty) {
                _playerCharacters.removeWhere((c) => c.id == character.id);
              } else {
                _playerCharacters.add(character);
              }
              setState(() {});
            },
          ),
      ],
    );
  }
}
