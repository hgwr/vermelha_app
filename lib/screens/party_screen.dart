import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/providers/characters_provider.dart';

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
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('キャラクターを削除しますか？'),
          content: const Text('削除すると元に戻せません。'),
          actions: [
            TextButton(
              onPressed: () {
                setState(() {
                  _isDeleting = false;
                });
                Navigator.of(context).pop();
              },
              child: const Text('キャンセル'),
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
              child: const Text('削除'),
            ),
          ],
        );
      },
    );
  }

  Widget createListView(
      BuildContext context, List<PlayerCharacter> characters) {
    return RefreshIndicator(
      onRefresh: () async {},
      child: ListView.builder(
        itemCount: characters.length,
        itemBuilder: (BuildContext context, int index) {
          if (characters.isEmpty) {
            return const Center(
              child: Text('No characters'),
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
            child: Row(
              children: [
                if (_isDeleting)
                  IconButton(
                    onPressed: () {
                      _showConfirmDeleteDialog(character);
                    },
                    icon: const Icon(Icons.delete),
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: 50,
                    child: getImageByJob(character.job!),
                  ),
                ),
                Expanded(
                  child: Text(character.name),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CharactersProvider>(
      builder: (ctx, charactersProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Party'),
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
