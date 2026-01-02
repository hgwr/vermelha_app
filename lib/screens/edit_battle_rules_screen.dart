import 'dart:math';

import 'package:flutter/material.dart' hide Action;
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';

import '../providers/characters_provider.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/player_character.dart';
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
    return BattleRule(
      owner: character,
      priority: character.battleRules.map((e) => e.priority).fold<int>(0,
              (acc, element) {
            return max(acc, element);
          }) +
          1,
      name: "",
      target: getTargetByUuid(targetFirstEnemyId),
      action: getActionList().first,
    );
  }

  Future<T?> _showPicker<T>({
    required Iterable<T> options,
    required T selected,
    required String Function(T) label,
    required Object Function(T) key,
  }) {
    final selectedKey = key(selected);
    return showModalBottomSheet<T>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView(
            children: [
              for (final option in options)
                ListTile(
                  key: ValueKey(key(option)),
                  leading: key(option) == selectedKey
                      ? const Icon(Icons.check)
                      : null,
                  title: Text(label(option)),
                  onTap: () => Navigator.of(context).pop(option),
                ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _selectTarget(BattleRule battleRule) async {
    final l10n = AppLocalizations.of(context)!;
    final selected = await _showPicker<Target>(
      options: getSelectableTargetList(),
      selected: battleRule.target,
      label: (target) => targetLabel(l10n, target),
      key: (target) => target.uuid,
    );
    if (!mounted || selected == null) {
      return;
    }
    setState(() {
      battleRule.target = selected;
    });
    saveCharacter();
  }

  Future<void> _selectAction(BattleRule battleRule) async {
    final l10n = AppLocalizations.of(context)!;
    final selected = await _showPicker<Action>(
      options: getActionList(),
      selected: battleRule.action,
      label: (action) => actionLabel(l10n, action),
      key: (action) => action.uuid,
    );
    if (!mounted || selected == null) {
      return;
    }
    setState(() {
      battleRule.action = selected;
    });
    saveCharacter();
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
                  _selectTarget(battleRule);
                },
                child: Row(
                  children: [
                    Text(targetLabel(l10n, battleRule.target)),
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
                      _selectAction(battleRule);
                    },
                    child: Row(
                      children: [
                        Text(actionLabel(l10n, battleRule.action)),
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
    final l10n = AppLocalizations.of(context)!;
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
                title: Text(targetLabel(l10n, battleRule.target)),
                subtitle: Text(actionLabel(l10n, battleRule.action)),
                trailing: const Icon(Icons.drag_handle)),
          );
        }).toList(),
      ],
    );
  }
}
