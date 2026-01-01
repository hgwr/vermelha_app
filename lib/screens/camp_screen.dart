import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/models/log_entry.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/screens/character_screen.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';

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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Consumer<CharactersProvider>(
                builder: (context, charactersProvider, _) {
                  final members = charactersProvider.partyMembers;
                  if (members.isEmpty) {
                    return Center(
                      child: Text(l10n.partyIncomplete),
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: members.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final member = members[index];
                      return ListTile(
                        leading: getImageByJob(member.job!),
                        title: Text(member.name),
                        subtitle: Text(
                          member.job == null
                              ? ''
                              : jobLabel(l10n, member.job!),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            CharacterScreen.routeName,
                            arguments: member,
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 16),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    await Provider.of<CharactersProvider>(context, listen: false)
                        .healPartyMembers();
                    final tasksProvider =
                        Provider.of<TasksProvider>(context, listen: false);
                    tasksProvider.addLog(LogType.system, LogMessageId.campHeal);
                    tasksProvider.resetBattle();
                    tasksProvider.startEngine();
                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: Text(l10n.campHealButton),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
