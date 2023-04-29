import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/providers/characters_provider.dart';

import '../providers/screen_provider.dart';
import '../widgets/bottom_bar_widget.dart';

class PartyScreen extends StatelessWidget {
  const PartyScreen({Key? key}) : super(key: key);

  static const routeName = '/party';

  Widget createListView(BuildContext context, List<Character> characters) {
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
          Character character = characters[index];
          return Row(
            children: [
              Text(character.name),
            ],
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
          appBar: AppBar(title: const Text('Party')),
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
