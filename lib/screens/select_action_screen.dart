import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/characters_provider.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/battle_rule.dart';

class SelectActionScreen extends StatefulWidget {
  static const routeName = '/select-action';

  const SelectActionScreen({super.key});

  @override
  State<SelectActionScreen> createState() => _SelectActionScreenState();
}

class _SelectActionScreenState extends State<SelectActionScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
