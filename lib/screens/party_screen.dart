import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class PartyScreen extends StatefulWidget {
  const PartyScreen({Key? key}) : super(key: key);

  static const routeName = '/party';

  @override
  State<PartyScreen> createState() => _PartyScreenState();
}

class _PartyScreenState extends State<PartyScreen> {
  bool _isDeleting = false;

  void _showConfirmDeleteDialog(PlayerCharacter character) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.deleteCharacterTitle),
          content: Text(l10n.deleteCharacterBody),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isDeleting = false;
                });
                Navigator.of(context).pop();
              },
              child: Text(l10n.cancel),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _isDeleting = false;
                });
                Provider.of<CharactersProvider>(context, listen: false)
                    .removeCharacter(character);
                Navigator.of(context).pop();
              },
              child: Text(l10n.delete),
            ),
          ],
        );
      },
    );
  }

  Widget createListView(
      BuildContext context, List<PlayerCharacter> characters) {
    final l10n = AppLocalizations.of(context)!;
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        itemCount: characters.isEmpty ? 1 : characters.length,
        itemBuilder: (BuildContext context, int index) {
          if (characters.isEmpty) {
            return Center(
              child: Text(l10n.noCharacters),
            );
          }
          PlayerCharacter character = characters[index];
          return GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                '/character',
                arguments: character,
              );
            },
            child: ListTile(
              leading: _isDeleting
                  ? IconButton(
                      onPressed: () {
                        _showConfirmDeleteDialog(character);
                      },
                      icon: const Icon(Icons.delete),
                    )
                  : getImageByJob(character.job!),
              title: Row(
                children: [
                  character.isActive
                      ? const Icon(Icons.person)
                      : const Icon(Icons.person_off_outlined),
                  Text(
                    character.name,
                  ),
                ],
              ),
              subtitle: Text(
                "${character.job!.name} "
                "${l10n.levelShort}${character.level} ",
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<CharactersProvider>(
      builder: (ctx, charactersProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.partyTitle),
            actions: [
              IconButton(
                onPressed: () {
                  setState(() {
                    _isDeleting = !_isDeleting;
                  });
                },
                icon: Icon(
                  _isDeleting ? Icons.delete : Icons.delete_outline,
                ),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: createListView(
                  ctx,
                  charactersProvider.characters,
                ),
              ),
            ],
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed('/character');
            },
            child: const Icon(Icons.add),
          ),
          bottomNavigationBar: const BottomBarWidget(
            currentScreenIndex: ScreenProvider.partyScreenIndex,
          ),
        );
      },
    );
  }
}
