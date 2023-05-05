import 'dart:async';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/status_parameter.dart';

import 'package:vermelha_app/models/task.dart';
import 'package:vermelha_app/models/vermelha_context.dart';
import 'package:vermelha_app/providers/characters_provider.dart';

enum EngineStatus {
  running,
  paused,
}

class TasksProvider extends ChangeNotifier {
  CharactersProvider charactersProvider;
  List<Task> _tasks = [];
  EngineStatus _engineStatus = EngineStatus.paused;
  VermelhaContext _vermelhaContext = VermelhaContext(allies: [], enemies: []);
  Timer? _timer;

  TasksProvider(this.charactersProvider);

  List<Task> get tasks => _tasks;
  EngineStatus get engineStatus => _engineStatus;
  VermelhaContext get vermelhaContext => _vermelhaContext;

  void startEngine() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _engineStatus = EngineStatus.running;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      calculation();
    });
    notifyListeners();
  }

  void pauseEngine() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = null;
    _engineStatus = EngineStatus.paused;
    notifyListeners();
  }

  void calculation() {
    debugPrint("calculating");

    if (vermelhaContext.allies.isEmpty) {
      fillAllies();
    }
    if (vermelhaContext.enemies.isEmpty ||
        vermelhaContext.enemies.every((enemy) => enemy.hp <= 0)) {
      fillEnemies();
    }

    notifyListeners();
  }

  void fillAllies() {
    _vermelhaContext = _vermelhaContext.copyWith(
      allies: charactersProvider.characters.where((c) => c.isActive).toList(),
      enemies: _vermelhaContext.enemies,
    );
  }

  void fillEnemies() {
    final List<BattleRule> enemyBattleRules = [];
    final Character tmpEnemy = Character(
      uuid: const Uuid().toString(),
      id: vermelhaContext.random.nextInt(999999),
      name: "Enemy",
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 100,
      mp: 100,
      attack: 10,
      defense: 10,
      magicPower: 10,
      speed: 10,
      priorityParameters: <StatusParameter>[],
      battleRules: enemyBattleRules,
    );

    _vermelhaContext = _vermelhaContext.copyWith(
      allies: _vermelhaContext.allies,
      enemies: [tmpEnemy],
    );
  }
}
