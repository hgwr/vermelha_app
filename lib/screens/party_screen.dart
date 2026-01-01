import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';
import 'package:vermelha_app/models/party_position.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/providers/characters_provider.dart';

class PartyScreen extends StatelessWidget {
  const PartyScreen({Key? key}) : super(key: key);

  static const routeName = '/party';

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
    return '$jobName ${member.name}';
  }

  void _showMemberPicker(
    BuildContext context,
    PartyPosition position,
    CharactersProvider charactersProvider,
  ) {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      builder: (context) {
        final members = charactersProvider.characters;
        if (members.isEmpty) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Center(
                child: Text(l10n.noCharacters),
              ),
            ),
          );
        }
        return SafeArea(
          child: ListView.separated(
            itemCount: members.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final member = members[index];
              final isSelected = member.partyPosition == position;
              final currentPositionLabel = member.partyPosition == null
                  ? l10n.partySlotEmpty
                  : _positionLabel(l10n, member.partyPosition!);
              return ListTile(
                leading: isSelected ? const Icon(Icons.check) : null,
                title: Text(_memberLabel(l10n, member)),
                subtitle: Text(currentPositionLabel),
                onTap: () async {
                  await charactersProvider.assignPartyMember(position, member);
                  if (context.mounted) {
                    Navigator.of(context).pop();
                  }
                },
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer<CharactersProvider>(
      builder: (ctx, charactersProvider, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.partyFormationTitle),
          ),
          body: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: PartyPosition.values.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final position = PartyPosition.values[index];
              final member = charactersProvider.memberAt(position);
              return ListTile(
                title: Text(_positionLabel(l10n, position)),
                subtitle: Text(
                  member == null
                      ? l10n.partySlotEmpty
                      : _memberLabel(l10n, member),
                ),
                trailing: member == null
                    ? null
                    : IconButton(
                        icon: const Icon(Icons.clear),
                        tooltip: l10n.partyClearSlot,
                        onPressed: () async {
                          await charactersProvider.assignPartyMember(
                            position,
                            null,
                          );
                        },
                      ),
                onTap: () => _showMemberPicker(
                  context,
                  position,
                  charactersProvider,
                ),
              );
            },
          ),
        );
      },
    );
  }
}
