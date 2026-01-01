import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/player_character.dart';
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
  List<Character> _turnOrder = [];
  int _turnIndex = 0;

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
    _turnOrder = [];
    _turnIndex = 0;
    if (clearLog) {
      _logEntries.clear();
    }
    notifyListeners();
  }

  void addLog(
    LogType type,
    LogMessageId messageId, {
    Map<String, String>? data,
  }) {
    _logEntries.add(
      LogEntry(
        timestamp: DateTime.now(),
        type: type,
        messageId: messageId,
        data: data,
      ),
    );
    notifyListeners();
  }

  void addActionLog(
    Character subject,
    Action action,
    List<Character> targets,
  ) {
    addLog(
      LogType.battle,
      LogMessageId.battleAction,
      data: {
        'subject': subject.name,
        'action': action.name,
        'targets': targets.map((t) => t.name).join(', '),
      },
    );
  }

  void calculation() {
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
      _buildTurnOrder();
    }

    if (_turnOrder.isEmpty) {
      _buildTurnOrder();
    }
    final actor = _nextActor();
    if (actor == null) {
      return;
    }
    if (actor.hp <= 0) {
      return;
    }
    final decision = _decideAction(actor);
    final action = decision.action;
    final targets = decision.targets;
    if (targets.isEmpty) {
      return;
    }
    action.applyEffect(
      vermelhaContext,
      actor,
      targets,
    );
    addActionLog(actor, action, targets);
    _tasks.add(
      Task(
        uuid: const Uuid().toString(),
        startedAt: DateTime.now(),
        finishedAt: DateTime.now(),
        subject: actor,
        action: action,
        targets: targets,
        status: TaskStatus.finished,
        progress: 100,
      ),
    );
    if (scrollDownFunc != null) {
      scrollDownFunc!();
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

  void _buildTurnOrder() {
    final List<Character> characters = [
      ...vermelhaContext.allies,
      ...vermelhaContext.enemies,
    ];
    characters.sort((a, b) => b.speed.compareTo(a.speed));
    _turnOrder = characters;
    _turnIndex = 0;
  }

  Character? _nextActor() {
    if (_turnOrder.isEmpty) {
      return null;
    }
    int attempts = 0;
    while (attempts < _turnOrder.length) {
      final actor = _turnOrder[_turnIndex];
      _turnIndex = (_turnIndex + 1) % _turnOrder.length;
      if (actor.hp > 0) {
        return actor;
      }
      attempts += 1;
    }
    return null;
  }

  _ActionDecision _decideAction(Character actor) {
    final List<BattleRule> rules = actor.battleRules;
    rules.sort((a, b) => a.priority.compareTo(b.priority));
    for (var rule in rules) {
      List<Character> candidates = rule.condition.getTargets(vermelhaContext);
      if (candidates.isEmpty) {
        continue;
      }
      final targets = rule.target.selectTargets(
        vermelhaContext,
        actor,
        candidates,
      );
      if (targets.isEmpty) {
        continue;
      }
      return _ActionDecision(rule.action, targets);
    }
    final defaultAction =
        getActionList().firstWhere((a) => a.name == "物理攻撃");
    final defaultTargets = _fallbackTargets(actor);
    return _ActionDecision(defaultAction, defaultTargets);
  }

  List<Character> _fallbackTargets(Character actor) {
    final candidates = actor is PlayerCharacter
        ? vermelhaContext.enemies
        : vermelhaContext.allies;
    for (final target in candidates) {
      if (target.hp > 0) {
        return [target];
      }
    }
    return [];
  }
}

class _ActionDecision {
  final Action action;
  final List<Character> targets;

  _ActionDecision(this.action, this.targets);
}
