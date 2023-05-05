import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/status_parameter.dart';

import 'package:vermelha_app/models/task.dart';
import 'package:vermelha_app/models/vermelha_context.dart';
import 'package:vermelha_app/providers/characters_provider.dart';

enum EngineStatus {
  running,
  paused,
}

typedef ScrollDownFunc = void Function();

class TasksProvider extends ChangeNotifier {
  CharactersProvider charactersProvider;
  final List<Task> _tasks = [];
  EngineStatus _engineStatus = EngineStatus.paused;
  VermelhaContext _vermelhaContext = VermelhaContext(allies: [], enemies: []);
  Timer? _timer;
  ScrollDownFunc? scrollDownFunc;

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

    final List<Character> characters = [
      ...vermelhaContext.allies,
      ...vermelhaContext.enemies
    ];
    characters.sort((a, b) => b.speed.compareTo(a.speed));
    for (var character in characters) {
      if (character.hp <= 0) {
        continue;
      }
      Task? maybeRunningTask = _tasks.firstWhereOrNull((t) {
        return t.subject.id == character.id && t.status == TaskStatus.running;
      });
      if (maybeRunningTask != null) {
        Task runningTask = maybeRunningTask;
        double progressPercentage =
            runningTask.progressPercentage(vermelhaContext);
        runningTask.progress = progressPercentage;
        if (progressPercentage >= 1) {
          runningTask.status = TaskStatus.finished;
          runningTask.finishedAt = DateTime.now();
          runningTask.action.applyEffect(
            vermelhaContext,
            runningTask.subject,
            runningTask.targets,
          );
          continue;
        }
        if (progressPercentage > 0.5) {
          continue;
        }
      }

      final List<BattleRule> rules = character.battleRules;
      rules.sort((a, b) => a.priority.compareTo(b.priority));
      for (var rule in rules) {
        List<Character> targets = rule.condition.getTargets(vermelhaContext);
        if (targets.isEmpty) {
          continue;
        }
        if (maybeRunningTask != null &&
            maybeRunningTask.action.uuid == rule.action.uuid) {
          continue;
        }
        if (maybeRunningTask != null &&
            maybeRunningTask.action.uuid != rule.action.uuid) {
          maybeRunningTask.status = TaskStatus.canceled;
        }
        Task newTask = Task(
          uuid: const Uuid().toString(),
          startedAt: DateTime.now(),
          subject: character,
          action: rule.action,
          targets: targets,
          status: TaskStatus.running,
          progress: 0,
        );
        debugPrint(newTask.toString());
        _tasks.add(newTask);
        if (scrollDownFunc != null) {
          scrollDownFunc!();
        }
        break;
      }
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
    Character tmpEnemy = Character(
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
      battleRules: <BattleRule>[],
    );
    final List<BattleRule> enemyBattleRules = [
      BattleRule(
        owner: tmpEnemy,
        priority: 1,
        name: "Enemy Rule",
        condition: getConditionList().firstWhere((c) => c.name == "ランダムな敵"),
        action: getActionList().firstWhere((a) => a.name == "物理攻撃"),
      )
    ];
    tmpEnemy = tmpEnemy.copyWith(battleRules: enemyBattleRules);

    _vermelhaContext = _vermelhaContext.copyWith(
      allies: _vermelhaContext.allies,
      enemies: [tmpEnemy],
    );
  }
}
