import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/screens/edit_battle_rules_screen.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import 'package:vermelha_app/screens/edit_priority_parameters_screen.dart';
import '../providers/characters_provider.dart';
import '../models/player_character.dart';
import '../models/job.dart';

class CharacterScreen extends StatefulWidget {
  static const routeName = '/character';

  const CharacterScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  PlayerCharacter character = getInitializedCharacterByJob(Job.fighter);
  final TextEditingController _characterNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _characterNameController.text = character.name;
  }

  Future<void> saveCharacter() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (character.id != null) {
        character =
            await Provider.of<CharactersProvider>(context, listen: false)
                .updateCharacter(character);
      } else {
        character =
            await Provider.of<CharactersProvider>(context, listen: false)
                .addCharacter(character);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      character = ModalRoute.of(context)!.settings.arguments as PlayerCharacter;
      _characterNameController.text = character.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: character.id != null
            ? Text(character.name)
            : Text(l10n.newCharacterTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: createListView(context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView createListView(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    double nameFieldWidth = MediaQuery.of(context).size.width - 180;

    return ListView(
      shrinkWrap: true,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 100,
              width: 100,
              child: getImageByJob(character.job!),
            ),
            SizedBox(
              height: 100,
              width: nameFieldWidth,
              child: Column(
                children: [
                  Expanded(
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        if (!hasFocus) {
                          character.name = _characterNameController.text;
                          saveCharacter();
                        }
                      },
                      child: TextField(
                        decoration: InputDecoration(labelText: l10n.nameLabel),
                        controller: _characterNameController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text('${l10n.jobLabel}: '),
                        Expanded(
                          child: DropdownButton<Job>(
                            value: character.job,
                            onChanged: character.id == null
                                ? (Job? newValue) {
                                    setState(() {
                                      character.job = newValue!;
                                      character = getInitializedCharacterByJob(
                                          character.job!);
                                    });
                                    saveCharacter();
                                  }
                                : null,
                            items: Job.values.map((Job job) {
                              return DropdownMenuItem<Job>(
                                value: job,
                                child: Text(job.name),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        characterPropertyItem(
          '${l10n.levelLabel}: ',
          character.level.toString(),
        ),
        characterPropertyItem(
          '${l10n.expLabel}: ',
          character.exp.toString(),
        ),
        characterPropertyItem(
          '${l10n.hpLabel}: ',
          "${character.hp} / ${character.maxHp}",
        ),
        characterPropertyItem(
          '${l10n.mpLabel}: ',
          "${character.mp} / ${character.maxMp}",
        ),
        characterPropertyItem(
          '${l10n.attackLabel}: ',
          character.attack.toString(),
        ),
        characterPropertyItem(
          '${l10n.defenseLabel}: ',
          character.defense.toString(),
        ),
        characterPropertyItem(
          '${l10n.magicPowerLabel}: ',
          character.magicPower.toString(),
        ),
        characterPropertyItem(
          '${l10n.speedLabel}: ',
          character.speed.toString(),
        ),
        GestureDetector(
          onTap: () async {
            final editedCharacter = await Navigator.of(context).pushNamed(
              EditPriorityParametersScreen.routeName,
              arguments: character,
            );
            if (editedCharacter != null) {
              setState(() {
                character = editedCharacter as PlayerCharacter;
              });
              saveCharacter();
            }
          },
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Text('${l10n.priorityParametersLabel}: '),
                Expanded(
                  child: Text(
                    character.priorityParameters
                        .map((e) => e.name)
                        .toList()
                        .join(', '),
                  ),
                ),
                const Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () async {
            if (character.id == null) {
              await saveCharacter();
            }
            Navigator.of(context).pushNamed(
              EditBattleRulesScreen.routeName,
              arguments: character,
            );
          },
          child: SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Text(l10n.battleRulesLabel),
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            ),
          ),
        ),
      ],
    );
  }

  SizedBox characterPropertyItem(String label, String value) {
    return SizedBox(
      height: 32,
      child: Row(
        children: [
          Text(label),
          Expanded(
            child: Text(
              value,
            ),
          ),
        ],
      ),
    );
  }
}
