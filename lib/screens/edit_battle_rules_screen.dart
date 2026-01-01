import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/screens/select_action_screen.dart';
import 'package:vermelha_app/screens/select_condition_screen.dart';
import 'package:vermelha_app/screens/select_target_screen.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import '../providers/characters_provider.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/target.dart';

class EditBattleRulesScreen extends StatefulWidget {
  static const routeName = '/edit-battle-rules';

  const EditBattleRulesScreen({super.key});

  @override
  State<EditBattleRulesScreen> createState() => _EditBattleRulesScreenState();
}

class _EditBattleRulesScreenState extends State<EditBattleRulesScreen> {
  static const int _maxRules = 16;
  final GlobalKey<FormState> _formKey = GlobalKey();
  PlayerCharacter character = getInitializedCharacterByJob(Job.fighter);
  bool _isOrdering = false;

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

  void _showConfirmDeleteRuleDialog(BattleRule rule) {
    final l10n = AppLocalizations.of(context)!;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.deleteRuleTitle),
        content: Text(l10n.deleteRuleBody),
        actions: [
          TextButton(
            child: Text(l10n.noLabel),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          ),
          TextButton(
            child: Text(l10n.yesLabel),
            onPressed: () {
              Navigator.of(ctx).pop();
              setState(() {
                character.battleRules.remove(rule);
              });
              saveCharacter();
            },
          ),
        ],
      ),
    );
  }

  BattleRule createNewBattleRule() {
    final defaultCondition = getConditionList().first;
    return BattleRule(
      owner: character,
      priority: character.battleRules.map((e) => e.priority).fold<int>(0,
              (acc, element) {
            return max(acc, element);
          }) +
          1,
      name: "",
      condition: defaultCondition,
      target: getTargetListByCategory(defaultCondition.targetCategory).first,
      action: getActionList().first,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      character = ModalRoute.of(context)!.settings.arguments as PlayerCharacter;
    }

    return Scaffold(
      appBar: character.id != null
          ? AppBar(
              title: Text(l10n.battleRulesTitleWithName(character.name)),
              actions: [
                IconButton(
                  icon: _isOrdering
                      ? const Icon(Icons.swap_vert_circle)
                      : const Icon(Icons.swap_vert),
                  onPressed: () {
                    setState(() {
                      _isOrdering = !_isOrdering;
                    });
                  },
                )
              ],
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: _isOrdering
                    ? createReorderableListView()
                    : createListView(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  ListView createListView() {
    final l10n = AppLocalizations.of(context)!;
    final isAtLimit = character.battleRules.length >= _maxRules;
    return ListView(
      children: [
        ...character.battleRules.map((battleRule) {
          return Card(
            key: ValueKey(battleRule.priority),
            child: ListTile(
              leading: Text(battleRule.priority.toString()),
              title: GestureDetector(
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(
                        SelectConditionScreen.routeName,
                        arguments: battleRule,
                      )
                      .then((value) {
                    setState(() {});
                    saveCharacter();
                  });
                },
                child: Row(
                  children: [
                    Text(battleRule.condition.name),
                    const Icon(
                      Icons.arrow_forward_ios,
                      size: 18,
                    )
                  ],
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                            SelectTargetScreen.routeName,
                            arguments: battleRule,
                          )
                          .then((value) {
                        setState(() {});
                        saveCharacter();
                      });
                    },
                    child: Row(
                      children: [
                        Text(battleRule.target.name),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context)
                          .pushNamed(
                            SelectActionScreen.routeName,
                            arguments: battleRule,
                          )
                          .then((value) {
                        setState(() {});
                        saveCharacter();
                      });
                    },
                    child: Row(
                      children: [
                        Text(battleRule.action.name),
                        const Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showConfirmDeleteRuleDialog(battleRule);
                },
              ),
            ),
          );
        }).toList(),
        Card(
          key: const ValueKey("f4ed9d86-2c2b-4b52-b620-5c8f390b0f41"),
          child: ListTile(
            title: Text(l10n.addBattleRule),
            subtitle: isAtLimit ? Text(l10n.battleRuleLimitReached) : null,
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: isAtLimit
                  ? null
                  : () {
                      setState(() {
                        character.battleRules.add(createNewBattleRule());
                      });
                      saveCharacter();
                    },
            ),
          ),
        ),
      ],
    );
  }

  ReorderableListView createReorderableListView() {
    return ReorderableListView(
      onReorder: (int start, int current) {
        if (start < current) {
          int end = current - 1;
          BattleRule startItem = character.battleRules[start];
          int i = 0;
          int local = start;
          do {
            character.battleRules[local] = character.battleRules[++local];
            i++;
          } while (i < end - start);
          character.battleRules[end] = startItem;
        } else if (start > current) {
          BattleRule startItem = character.battleRules[start];
          for (int i = start; i > current; i--) {
            character.battleRules[i] = character.battleRules[i - 1];
          }
          character.battleRules[current] = startItem;
        }
        for (int i = 1; i <= character.battleRules.length; i++) {
          character.battleRules[i - 1] =
              character.battleRules[i - 1].copyWith(priority: i);
        }
        setState(() {});
        saveCharacter();
      },
      children: [
        ...character.battleRules.map((battleRule) {
          return Card(
            key: ValueKey(battleRule.priority),
            child: ListTile(
                leading: Text(battleRule.priority.toString()),
                title: Text(battleRule.condition.name),
                subtitle: Text(
                  "${battleRule.target.name} / ${battleRule.action.name}",
                ),
                trailing: const Icon(Icons.drag_handle)),
          );
        }).toList(),
      ],
    );
  }
}
