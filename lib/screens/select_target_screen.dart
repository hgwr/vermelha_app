import 'package:flutter/material.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/target.dart';

class SelectTargetScreen extends StatefulWidget {
  static const routeName = '/select-target';

  const SelectTargetScreen({super.key});

  @override
  State<SelectTargetScreen> createState() => _SelectTargetScreenState();
}

class _SelectTargetScreenState extends State<SelectTargetScreen> {
  BattleRule? _battleRule;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _battleRule = ModalRoute.of(context)!.settings.arguments as BattleRule;
    }

    final targets = _battleRule!.condition.targetCategory == TargetCategory.any
        ? getTargetList()
        : getTargetListByCategory(_battleRule!.condition.targetCategory);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.selectTargetTitle),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  for (var target in targets)
                    ListTile(
                      key: ValueKey(target.uuid),
                      leading: _battleRule!.target.uuid == target.uuid
                          ? const Icon(Icons.check)
                          : null,
                      title: Text(targetLabel(l10n, target)),
                      onTap: () {
                        _battleRule!.target = target;
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
