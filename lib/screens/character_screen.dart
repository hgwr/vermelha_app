import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/screens/edit_battle_rules_screen.dart';

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
    if (ModalRoute.of(context)!.settings.arguments != null) {
      character = ModalRoute.of(context)!.settings.arguments as PlayerCharacter;
      _characterNameController.text = character.name;
    }

    return Scaffold(
      appBar: AppBar(
        title: character.id != null ? Text(character.name) : const Text('New'),
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
                        decoration: const InputDecoration(labelText: '名前'),
                        controller: _characterNameController,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        const Text('ジョブ: '),
                        Expanded(
                          child: DropdownButton<Job>(
                            value: character.job,
                            onChanged: (Job? newValue) {
                              setState(() {
                                character.job = newValue!;
                                if (character.id == null) {
                                  character = getInitializedCharacterByJob(
                                      character.job!);
                                }
                              });
                              saveCharacter();
                            },
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
        Row(
          children: [
            const Text('パーティ参加: '),
            Switch(
              value: character.isActive,
              onChanged: (value) {
                setState(() {
                  character.isActive = value;
                });
                saveCharacter();
              },
            ),
          ],
        ),
        characterPropertyItem(
          'レベル: ',
          character.level.toString(),
        ),
        characterPropertyItem(
          '経験値: ',
          character.exp.toString(),
        ),
        characterPropertyItem(
          'HP: ',
          "${character.hp} / ${character.maxHp}",
        ),
        characterPropertyItem(
          'MP: ',
          "${character.mp} / ${character.maxMp}",
        ),
        characterPropertyItem('攻撃力: ', character.attack.toString()),
        characterPropertyItem('防御力: ', character.defense.toString()),
        characterPropertyItem('魔法力: ', character.magicPower.toString()),
        characterPropertyItem('素早さ: ', character.speed.toString()),
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
                const Text('優先パラメータ: '),
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
          child: const SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: Text('戦闘ルール'),
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
