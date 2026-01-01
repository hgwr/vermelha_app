import 'dart:async';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/status_parameter.dart';
import 'package:vermelha_app/models/target.dart';

import 'package:vermelha_app/models/task.dart';
import 'package:vermelha_app/models/vermelha_context.dart';
import 'package:vermelha_app/models/log_entry.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/dungeon_provider.dart';

enum EngineStatus {
  running,
  paused,
}

typedef ScrollDownFunc = void Function();

class TasksProvider extends ChangeNotifier {
  CharactersProvider charactersProvider;
  DungeonProvider? dungeonProvider;
  final List<Task> _tasks = [];
  final List<LogEntry> _logEntries = [];
  EngineStatus _engineStatus = EngineStatus.paused;
  VermelhaContext _vermelhaContext = VermelhaContext(allies: [], enemies: []);
  Timer? _timer;
  ScrollDownFunc? scrollDownFunc;
  bool _hasSpawnedEnemies = false;

  TasksProvider(this.charactersProvider, [this.dungeonProvider]);

  List<Task> get tasks => _tasks;
  List<LogEntry> get logEntries => _logEntries;
  EngineStatus get engineStatus => _engineStatus;
  VermelhaContext get vermelhaContext => _vermelhaContext;

  void startEngine() {
    if (_timer != null) {
      _timer!.cancel();
    }
    _engineStatus = EngineStatus.running;
    if (_logEntries.isEmpty) {
      addLog(LogType.explore, LogMessageId.explorationStart);
    }
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

  void resetBattle({bool clearLog = false}) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = null;
    _engineStatus = EngineStatus.paused;
    _tasks.clear();
    _vermelhaContext = VermelhaContext(allies: [], enemies: []);
    _hasSpawnedEnemies = false;
    if (clearLog) {
      _logEntries.clear();
    }
    notifyListeners();
  }

  void addLog(LogType type, LogMessageId messageId) {
    _logEntries.add(
      LogEntry(
        timestamp: DateTime.now(),
        type: type,
        messageId: messageId,
      ),
    );
    notifyListeners();
  }

  void calculation() {
    debugPrint("calculating");

    if (vermelhaContext.allies.isEmpty) {
      fillAllies();
    }
    if (vermelhaContext.enemies.isEmpty ||
        vermelhaContext.enemies.every((enemy) => enemy.hp <= 0)) {
      if (_hasSpawnedEnemies) {
        addLog(LogType.battle, LogMessageId.battleVictory);
        addLog(LogType.loot, LogMessageId.lootNone);
        dungeonProvider?.registerBattle();
      }
      fillEnemies();
      _hasSpawnedEnemies = true;
      addLog(LogType.battle, LogMessageId.battleEncounter);
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
        debugPrint("progressPercentage: $progressPercentage");
        runningTask.progress = progressPercentage;
        if (progressPercentage >= 100) {
          runningTask.status = TaskStatus.finished;
          runningTask.finishedAt = DateTime.now();
          runningTask.action.applyEffect(
            vermelhaContext,
            runningTask.subject,
            runningTask.targets,
          );
          continue;
        }
        if (progressPercentage > 50) {
          continue;
        }
      }

      final List<BattleRule> rules = character.battleRules;
      rules.sort((a, b) => a.priority.compareTo(b.priority));
      for (var rule in rules) {
        List<Character> candidates = rule.condition.getTargets(vermelhaContext);
        if (candidates.isEmpty) {
          continue;
        }
        final targets = rule.target.selectTargets(
          vermelhaContext,
          character,
          candidates,
        );
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
        debugPrint("newTask: $newTask");
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
      allies: charactersProvider.partyMembers,
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
        target: getTargetListByCategory(TargetCategory.enemy).first,
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
