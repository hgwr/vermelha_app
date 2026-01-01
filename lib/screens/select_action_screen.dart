import 'package:flutter/material.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';

import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/action.dart';

class SelectActionScreen extends StatefulWidget {
  static const routeName = '/select-action';

  const SelectActionScreen({super.key});

  @override
  State<SelectActionScreen> createState() => _SelectActionScreenState();
}

class _SelectActionScreenState extends State<SelectActionScreen> {
  BattleRule? _battleRule;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _battleRule = ModalRoute.of(context)!.settings.arguments as BattleRule;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectActionTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  for (var action in getActionList())
                    ListTile(
                      key: ValueKey(action.uuid),
                      leading: _battleRule!.action.uuid == action.uuid
                          ? const Icon(Icons.check)
                          : null,
                      title: Text(action.name),
                      onTap: () {
                        _battleRule!.action = action;
                        Navigator.of(context).pop();
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
