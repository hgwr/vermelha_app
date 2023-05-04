import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters_provider.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/battle_rule.dart';

class SelectConditionScreen extends StatefulWidget {
  static const routeName = '/select-condition';

  const SelectConditionScreen({super.key});

  @override
  State<SelectConditionScreen> createState() => _SelectConditionScreenState();
}

class _SelectConditionScreenState extends State<SelectConditionScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  BattleRule? _battleRule;

  @override
  Widget build(BuildContext context) {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      _battleRule = ModalRoute.of(context)!.settings.arguments as BattleRule;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Condition'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: [
                    for (var condition in getConditionList())
                      ListTile(
                        key: ValueKey(condition.uuid),
                        leading: _battleRule!.condition.uuid == condition.uuid
                            ? const Icon(Icons.check)
                            : null,
                        title: Text(condition.name),
                        onTap: () {
                          _battleRule!.condition = condition;
                          Navigator.of(context).pop();
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
