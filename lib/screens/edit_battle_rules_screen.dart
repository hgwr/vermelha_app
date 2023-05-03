import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters_provider.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/battle_rule.dart';

class EditBattleRulesScreen extends StatefulWidget {
  static const routeName = '/edit-battle-rules';

  const EditBattleRulesScreen({super.key});

  @override
  State<EditBattleRulesScreen> createState() => _EditBattleRulesScreenState();
}

class _EditBattleRulesScreenState extends State<EditBattleRulesScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  Character character = getInitializedCharacterByJob(Job.fighter);

  void saveCharacter() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (character.id != null) {
        character =
            await Provider.of<CharactersProvider>(context, listen: false)
                .updateCharacter(character);
      }
    }
  }

  BattleRule createNewBattleRule() {
    return BattleRule(
      owner: character,
      priority: character.battleRules.map((e) => e.priority).fold<int>(0,
              (acc, element) {
            return max(acc, element);
          }) +
          1,
      name: "",
      condition: getConditionList().first,
      action: getActionList().first,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      character = ModalRoute.of(context)!.settings.arguments as Character;
    }

    return Scaffold(
      appBar: character.id != null
          ? AppBar(
              title: Text("戦闘ルール：${character.name}"),
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: createListView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView createListView() {
    return ListView(
      children: [
        ...character.battleRules.map((battleRule) {
          return Card(
            child: ListTile(
              leading: Text(battleRule.priority.toString()),
              title: Text(battleRule.condition.name),
              subtitle: Text(battleRule.action.name),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  setState(() {
                    character.battleRules.remove(battleRule);
                  });
                },
              ),
            ),
          );
        }).toList(),
        Card(
          child: ListTile(
            title: Text("新しい戦闘ルールを追加する"),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  character.battleRules.add(createNewBattleRule());
                });
              },
            ),
          ),
        ),
      ],
    );
  }
}
