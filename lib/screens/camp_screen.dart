import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';

class CampScreen extends StatelessWidget {
  const CampScreen({Key? key}) : super(key: key);

  static const routeName = '/camp';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.campTitle),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () async {
                await Provider.of<CharactersProvider>(context, listen: false)
                    .healPartyMembers();
                Provider.of<TasksProvider>(context, listen: false)
                    .resetBattle();
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              },
              child: Text(l10n.campHealButton),
            ),
          ),
        ),
      ),
    );
  }
}
