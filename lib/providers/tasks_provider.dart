import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/dungeon_state.dart';
import 'package:vermelha_app/models/enemy.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/item_catalog.dart';
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
  bool _isInBattle = false;
  DateTime? _nextExploreAt;
  List<Character> _turnOrder = [];
  int _turnIndex = 0;
  PendingLoot? _pendingLoot;
  bool _resumeAfterLoot = false;

  static const int _exploreMinDelayMs = 1200;
  static const int _exploreMaxDelayMs = 2800;

  TasksProvider(this.charactersProvider, [this.dungeonProvider]);

  List<Task> get tasks => _tasks;
  List<LogEntry> get logEntries => _logEntries;
  EngineStatus get engineStatus => _engineStatus;
  VermelhaContext get vermelhaContext => _vermelhaContext;
  PendingLoot? get pendingLoot => _pendingLoot;

  void startEngine() {
    if (_pendingLoot != null) {
      return;
    }
    if (_timer != null) {
      _timer!.cancel();
    }
    _engineStatus = EngineStatus.running;
    dungeonProvider?.setPaused(false);
    if (_logEntries.isEmpty) {
      addLog(LogType.explore, LogMessageId.explorationStart);
    }
    _scheduleNextExploreIfNeeded();
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
    dungeonProvider?.setPaused(true);
    notifyListeners();
  }

  void resetBattle({bool clearLog = false}) {
    if (_timer != null) {
      _timer!.cancel();
    }
    _timer = null;
    _engineStatus = EngineStatus.paused;
    dungeonProvider?.setPaused(true);
    _tasks.clear();
    _vermelhaContext = VermelhaContext(allies: [], enemies: []);
    _isInBattle = false;
    _nextExploreAt = null;
    _turnOrder = [];
    _turnIndex = 0;
    _pendingLoot = null;
    _resumeAfterLoot = false;
    if (clearLog) {
      _logEntries.clear();
      dungeonProvider?.syncEventLog(_logEntries);
    }
    notifyListeners();
  }

  void applyDungeonState(DungeonState? state) {
    resetBattle(clearLog: true);
    if (state == null) {
      return;
    }
    _logEntries
      ..clear()
      ..addAll(state.eventLog);
    dungeonProvider?.syncEventLog(_logEntries);
    if (state.isPaused) {
      pauseEngine();
    } else {
      startEngine();
    }
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
    dungeonProvider?.syncEventLog(_logEntries);
    notifyListeners();
  }

  void addActionLog(
    Character subject,
    Action action,
    List<Character> targets,
  ) {
    final serializedTargets =
        targets.map((target) => _serializeActor(target)).toList();
    addLog(
      LogType.battle,
      LogMessageId.battleAction,
      data: {
        'subject': jsonEncode(_serializeActor(subject)),
        'action_uuid': action.uuid,
        'targets': jsonEncode(serializedTargets),
      },
    );
  }

  void calculation() {
    if (vermelhaContext.allies.isEmpty) {
      fillAllies();
    }
    if (!_isInBattle) {
      _handleExplorationTick();
      return;
    }

    _handleBattleTick();
  }

  void _handleExplorationTick() {
    _scheduleNextExploreIfNeeded();
    if (_nextExploreAt == null) {
      return;
    }
    if (DateTime.now().isBefore(_nextExploreAt!)) {
      return;
    }
    _runExploreEvent();
    if (!_isInBattle && _pendingLoot == null) {
      _scheduleNextExplore();
    }
  }

  void _runExploreEvent() {
    final roll = vermelhaContext.random.nextDouble();
    if (roll < 0.15) {
      addLog(LogType.loot, LogMessageId.explorationTreasure);
      _queueLoot(LootSource.treasure);
      return;
    }
    if (roll < 0.25) {
      addLog(LogType.explore, LogMessageId.explorationTrap);
      return;
    }
    if (roll < 0.55) {
      _startBattle();
      return;
    }
    addLog(LogType.explore, LogMessageId.explorationMove);
  }

  void _scheduleNextExploreIfNeeded() {
    if (_nextExploreAt != null) {
      return;
    }
    _scheduleNextExplore();
  }

  void _scheduleNextExplore() {
    final range = _exploreMaxDelayMs - _exploreMinDelayMs;
    final offset = range <= 0 ? 0 : vermelhaContext.random.nextInt(range + 1);
    _nextExploreAt = DateTime.now().add(
      Duration(milliseconds: _exploreMinDelayMs + offset),
    );
  }

  void _startBattle() {
    fillEnemies();
    _isInBattle = true;
    _nextExploreAt = null;
    _turnOrder = [];
    _turnIndex = 0;
    addLog(LogType.battle, LogMessageId.battleEncounter);
    _buildTurnOrder();
  }

  void _handleBattleTick() {
    if (vermelhaContext.allies.isEmpty ||
        vermelhaContext.allies.every((ally) => ally.hp <= 0)) {
      _handlePartyDefeat();
      return;
    }
    if (vermelhaContext.enemies.isEmpty ||
        vermelhaContext.enemies.every((enemy) => enemy.hp <= 0)) {
      _finishBattle();
      return;
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
    final wasTelegraphing = actor is Enemy && actor.isTelegraphing;
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
    _maybeTriggerTelegraphing(actor, wasTelegraphing);
    if (scrollDownFunc != null) {
      scrollDownFunc!();
    }
    notifyListeners();
  }

  void _maybeTriggerTelegraphing(Character actor, bool wasTelegraphing) {
    if (actor is! Enemy) {
      return;
    }
    if (actor.hp <= 0) {
      return;
    }
    if (wasTelegraphing || actor.isTelegraphing) {
      return;
    }
    if (vermelhaContext.random.nextDouble() < 0.2) {
      actor.isTelegraphing = true;
    }
  }

  void _finishBattle() {
    addLog(LogType.battle, LogMessageId.battleVictory);
    dungeonProvider?.registerBattle();
    _vermelhaContext = _vermelhaContext.copyWith(enemies: []);
    _isInBattle = false;
    _turnOrder = [];
    _turnIndex = 0;
    _queueLoot(LootSource.battle);
  }

  void _handlePartyDefeat() {
    addLog(LogType.system, LogMessageId.returnToCity);
    resetBattle();
    dungeonProvider?.returnToCity();
  }

  void resolvePendingLoot() {
    if (_pendingLoot == null) {
      return;
    }
    _pendingLoot = null;
    final resume = _resumeAfterLoot;
    _resumeAfterLoot = false;
    if (resume && (dungeonProvider?.isExploring ?? false)) {
      startEngine();
    } else {
      notifyListeners();
    }
  }

  void _queueLoot(LootSource source) {
    if (_pendingLoot != null) {
      return;
    }
    final loot = _generateLoot(source);
    if (loot == null) {
      return;
    }
    _resumeAfterLoot = _engineStatus == EngineStatus.running;
    _pendingLoot = loot;
    _nextExploreAt = null;
    pauseEngine();
  }

  PendingLoot? _generateLoot(LootSource source) {
    if (charactersProvider.partyMembers.isEmpty) {
      return null;
    }
    final roll = vermelhaContext.random.nextDouble();
    final goldChance = source == LootSource.treasure ? 0.4 : 0.6;
    if (roll < goldChance) {
      final amount = 20 + vermelhaContext.random.nextInt(41);
      return PendingLoot.gold(
        id: const Uuid().v4(),
        amount: amount,
        source: source,
      );
    }
    final item = itemCatalog[vermelhaContext.random.nextInt(itemCatalog.length)];
    return PendingLoot.item(
      id: const Uuid().v4(),
      item: item,
      source: source,
      ownerId: charactersProvider.partyMembers.first.id,
    );
  }

  void fillAllies() {
    _vermelhaContext = _vermelhaContext.copyWith(
      allies: charactersProvider.partyMembers,
      enemies: _vermelhaContext.enemies,
    );
  }

  void fillEnemies() {
    final count = 2 + vermelhaContext.random.nextInt(2);
    final List<Character> enemies = [];
    for (var i = 0; i < count; i += 1) {
      final enemyType = vermelhaContext.random.nextBool()
          ? EnemyType.regular
          : EnemyType.irregular;
      final enemy = Enemy(
        type: enemyType,
        isTelegraphing: false,
        uuid: const Uuid().v4(),
        name: 'Enemy ${i + 1}',
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
      enemy.battleRules = [
        BattleRule(
          owner: enemy,
          priority: 1,
          name: "Enemy Rule",
          condition: getConditionByUuid(conditionRandomAllyId),
          target: getTargetListByCategory(TargetCategory.ally).first,
          action: getActionByUuid(actionPhysicalAttackId),
        )
      ];
      enemies.add(enemy);
    }

    _vermelhaContext = _vermelhaContext.copyWith(
      allies: _vermelhaContext.allies,
      enemies: enemies,
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
      List<Character> candidates =
          _aliveTargets(rule.condition.getTargets(vermelhaContext));
      if (candidates.isEmpty) {
        continue;
      }
      final targets = _aliveTargets(rule.target.selectTargets(
        vermelhaContext,
        actor,
        candidates,
      ));
      if (targets.isEmpty) {
        continue;
      }
      return _ActionDecision(rule.action, targets);
    }
    final defaultAction = getActionByUuid(actionPhysicalAttackId);
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

  List<Character> _aliveTargets(List<Character> candidates) {
    return candidates.where((candidate) => candidate.hp > 0).toList();
  }

  Map<String, String> _serializeActor(Character actor) {
    if (actor is Enemy) {
      return {
        'kind': 'enemy',
        'enemy_type': actor.type.name,
      };
    }
    return {
      'kind': 'player',
      'name': actor.name,
    };
  }
}

class _ActionDecision {
  final Action action;
  final List<Character> targets;

  _ActionDecision(this.action, this.targets);
}

enum LootType {
  gold,
  item,
}

enum LootSource {
  treasure,
  battle,
}

class PendingLoot {
  final String id;
  final LootType type;
  final LootSource source;
  final int gold;
  final Item? item;
  final int? ownerId;

  const PendingLoot._({
    required this.id,
    required this.type,
    required this.source,
    required this.gold,
    required this.item,
    required this.ownerId,
  });

  factory PendingLoot.gold({
    required String id,
    required int amount,
    required LootSource source,
  }) {
    return PendingLoot._(
      id: id,
      type: LootType.gold,
      source: source,
      gold: amount,
      item: null,
      ownerId: null,
    );
  }

  factory PendingLoot.item({
    required String id,
    required Item item,
    required LootSource source,
    required int? ownerId,
  }) {
    return PendingLoot._(
      id: id,
      type: LootType.item,
      source: source,
      gold: 0,
      item: item,
      ownerId: ownerId,
    );
  }
}
