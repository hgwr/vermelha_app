import 'dart:async';
import 'dart:convert';
import 'dart:math';

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
  static final Uuid _uuid = Uuid();
  static final List<_EnemyProfile> _enemyProfiles = [
    _EnemyProfile(
      id: 'goblin',
      type: EnemyType.regular,
      baseHp: 90,
      baseMp: 20,
      baseAttack: 10,
      baseDefense: 7,
      baseMagicPower: 5,
      baseSpeed: 9,
    ),
    _EnemyProfile(
      id: 'skeleton',
      type: EnemyType.regular,
      baseHp: 100,
      baseMp: 20,
      baseAttack: 11,
      baseDefense: 9,
      baseMagicPower: 5,
      baseSpeed: 8,
    ),
    _EnemyProfile(
      id: 'orc',
      type: EnemyType.regular,
      baseHp: 120,
      baseMp: 20,
      baseAttack: 13,
      baseDefense: 10,
      baseMagicPower: 4,
      baseSpeed: 7,
    ),
    _EnemyProfile(
      id: 'slime',
      type: EnemyType.irregular,
      baseHp: 80,
      baseMp: 40,
      baseAttack: 8,
      baseDefense: 6,
      baseMagicPower: 10,
      baseSpeed: 9,
    ),
    _EnemyProfile(
      id: 'wisp',
      type: EnemyType.irregular,
      baseHp: 70,
      baseMp: 60,
      baseAttack: 7,
      baseDefense: 5,
      baseMagicPower: 13,
      baseSpeed: 11,
    ),
    _EnemyProfile(
      id: 'ghost',
      type: EnemyType.irregular,
      baseHp: 90,
      baseMp: 50,
      baseAttack: 9,
      baseDefense: 7,
      baseMagicPower: 12,
      baseSpeed: 10,
    ),
  ];
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
  Task? _currentTask;
  int _currentTaskElapsedMs = 0;
  int _currentTaskDurationMs = 0;
  bool _currentTaskWasTelegraphing = false;
  DateTime? _lastBattleTickAt;
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
    _lastBattleTickAt = null;
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
    _lastBattleTickAt = null;
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
    _currentTask = null;
    _currentTaskElapsedMs = 0;
    _currentTaskDurationMs = 0;
    _currentTaskWasTelegraphing = false;
    _lastBattleTickAt = null;
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
    _currentTask = null;
    _currentTaskElapsedMs = 0;
    _currentTaskDurationMs = 0;
    _currentTaskWasTelegraphing = false;
    _lastBattleTickAt = null;
    _vermelhaContext.lastAttackers.clear();
    _vermelhaContext.defending.clear();
    addLog(LogType.battle, LogMessageId.battleEncounter);
    _buildTurnOrder();
  }

  void _handleBattleTick() {
    if (vermelhaContext.allies.isEmpty ||
        vermelhaContext.allies.every((ally) => ally.hp <= 0)) {
      unawaited(_handlePartyDefeat());
      return;
    }
    if (vermelhaContext.enemies.isEmpty ||
        vermelhaContext.enemies.every((enemy) => enemy.hp <= 0)) {
      _finishBattle();
      return;
    }

    if (_currentTask != null && _currentTask!.status == TaskStatus.running) {
      _advanceCurrentTask();
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
    _startActionTask(actor, action, targets, wasTelegraphing);
  }

  void _startActionTask(
    Character actor,
    Action action,
    List<Character> targets,
    bool wasTelegraphing,
  ) {
    final durationSeconds = action.computeDuration(
      action.baseDurationSeconds,
      vermelhaContext,
      actor,
      targets,
    );
    final durationMs = max(1, (durationSeconds * 1000).round());
    final task = Task(
      uuid: _uuid.v4(),
      startedAt: DateTime.now(),
      subject: actor,
      action: action,
      targets: targets,
      status: TaskStatus.running,
      progress: 0,
    );
    _currentTask = task;
    _currentTaskElapsedMs = 0;
    _currentTaskDurationMs = durationMs;
    _currentTaskWasTelegraphing = wasTelegraphing;
    _lastBattleTickAt = DateTime.now();
    _tasks.add(task);
    notifyListeners();
  }

  void _advanceCurrentTask() {
    final task = _currentTask;
    if (task == null) {
      return;
    }
    final now = DateTime.now();
    final lastTick = _lastBattleTickAt ?? now;
    final deltaMs = now.difference(lastTick).inMilliseconds;
    _lastBattleTickAt = now;
    if (deltaMs <= 0) {
      return;
    }
    _currentTaskElapsedMs += deltaMs;
    final progress = (_currentTaskElapsedMs / _currentTaskDurationMs) * 100;
    task.progress = progress.clamp(0, 100).toDouble();
    if (task.progress >= 100) {
      _resolveCurrentTask(task);
      return;
    }
    notifyListeners();
  }

  void _resolveCurrentTask(Task task) {
    final actor = task.subject;
    final action = task.action;
    final targets = task.targets;
    final battleSnapshots = _snapshotPlayerStats([actor, ...targets]);
    action.applyEffect(
      vermelhaContext,
      actor,
      targets,
    );
    _registerAttackers(actor, targets);
    final usedItem = _consumeActionCost(actor, action, targets);
    if (usedItem && actor is PlayerCharacter && actor.id != null) {
      battleSnapshots.remove(actor.id);
      unawaited(
        charactersProvider.updateCharacter(actor).catchError((e, s) {
          debugPrint(
            'Failed to update character ${actor.id} after item use: $e',
          );
          debugPrintStack(stackTrace: s);
        }),
      );
    }
    _persistBattleChanges(battleSnapshots);
    addActionLog(actor, action, targets);
    task.status = TaskStatus.finished;
    task.progress = 100;
    task.finishedAt = DateTime.now();
    _maybeTriggerTelegraphing(actor, _currentTaskWasTelegraphing);
    _currentTask = null;
    _currentTaskElapsedMs = 0;
    _currentTaskDurationMs = 0;
    _currentTaskWasTelegraphing = false;
    _lastBattleTickAt = null;
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

  Future<void> _handlePartyDefeat() async {
    try {
      await charactersProvider.healPartyMembers();
      addLog(LogType.system, LogMessageId.partyDefeatedReturn);
    } catch (e, s) {
      debugPrint('Failed to heal party on defeat: $e');
      debugPrintStack(stackTrace: s);
      addLog(LogType.system, LogMessageId.returnToCity);
    }
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
        id: _uuid.v4(),
        amount: amount,
        source: source,
      );
    }
    final item = itemCatalog[vermelhaContext.random.nextInt(itemCatalog.length)];
    return PendingLoot.item(
      id: _uuid.v4(),
      item: item,
      source: source,
      ownerId: charactersProvider.partyMembers.first.id,
    );
  }

  int _scaleStat(int base, int floor, int perFloor, int variance) {
    final scaled = base + (floor - 1) * perFloor;
    if (variance <= 0) {
      return max(1, scaled);
    }
    final spread = variance * 2 + 1;
    final offset = vermelhaContext.random.nextInt(spread) - variance;
    return max(1, scaled + offset);
  }

  void fillAllies() {
    _vermelhaContext = _vermelhaContext.copyWith(
      allies: charactersProvider.partyMembers,
      enemies: _vermelhaContext.enemies,
    );
  }

  void fillEnemies() {
    final count = 2 + vermelhaContext.random.nextInt(2);
    final floor = max(1, dungeonProvider?.activeFloor ?? 1);
    final List<Character> enemies = [];
    for (var i = 0; i < count; i += 1) {
      final profile =
          _enemyProfiles[vermelhaContext.random.nextInt(_enemyProfiles.length)];
      final enemy = Enemy(
        type: profile.type,
        isTelegraphing: false,
        uuid: _uuid.v4(),
        name: profile.id,
        level: floor,
        maxHp: _scaleStat(profile.baseHp, floor, 20, 8),
        hp: 0,
        maxMp: _scaleStat(profile.baseMp, floor, 6, 4),
        mp: 0,
        attack: _scaleStat(profile.baseAttack, floor, 3, 2),
        defense: _scaleStat(profile.baseDefense, floor, 2, 2),
        magicPower: _scaleStat(profile.baseMagicPower, floor, 3, 2),
        speed: _scaleStat(profile.baseSpeed, floor, 1, 1),
        priorityParameters: <StatusParameter>[],
        battleRules: <BattleRule>[],
      );
      enemy.hp = enemy.maxHp;
      enemy.mp = enemy.maxMp;
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
      if (!_canExecuteAction(actor, rule.action)) {
        continue;
      }
      List<Character> candidates = _aliveTargets(_candidatesForRule(rule));
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

  List<Character> _candidatesForRule(BattleRule rule) {
    if (rule.condition.targetCategory == TargetCategory.any) {
      return rule.target.targetCategory == TargetCategory.ally
          ? vermelhaContext.allies
          : vermelhaContext.enemies;
    }
    return rule.condition.getTargets(vermelhaContext);
  }

  bool _canExecuteAction(Character actor, Action action) {
    if (actor.mp < action.mpCost) {
      return false;
    }
    if (action.uuid == actionUsePotionId) {
      return _hasConsumable(actor, 'consumable_potion');
    }
    if (action.uuid == actionUseEtherId) {
      return _hasConsumable(actor, 'consumable_ether');
    }
    return true;
  }

  bool _hasConsumable(Character actor, String itemId) {
    if (actor is! PlayerCharacter) {
      return false;
    }
    return actor.inventory.any((item) => item.id == itemId);
  }

  bool _consumeActionCost(
    Character actor,
    Action action,
    List<Character> targets,
  ) {
    bool usedItem = false;
    if (action.mpCost > 0) {
      actor.mp = max(0, actor.mp - action.mpCost);
    }
    if (action.uuid == actionUsePotionId) {
      usedItem = _consumeItem(actor, 'consumable_potion', targets) || usedItem;
    }
    if (action.uuid == actionUseEtherId) {
      usedItem = _consumeItem(actor, 'consumable_ether', targets) || usedItem;
    }
    return usedItem;
  }

  bool _consumeItem(
    Character actor,
    String itemId,
    List<Character> targets,
  ) {
    if (actor is! PlayerCharacter || targets.isEmpty) {
      return false;
    }
    final index = actor.inventory.indexWhere((item) => item.id == itemId);
    if (index < 0) {
      return false;
    }
    final item = actor.inventory.removeAt(index);
    for (final target in targets) {
      _applyItemEffects(target, item);
    }
    return true;
  }

  void _applyItemEffects(Character target, Item item) {
    final hp = item.effects['hp'];
    if (hp != null) {
      target.hp = min(target.maxHp, target.hp + hp);
    }
    final mp = item.effects['mp'];
    if (mp != null) {
      target.mp = min(target.maxMp, target.mp + mp);
    }
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

  void _registerAttackers(Character actor, List<Character> targets) {
    if (actor is! Enemy) {
      return;
    }
    for (final target in targets) {
      vermelhaContext.lastAttackers[target] = actor;
    }
  }

  Map<int, BattleStatSnapshot> _snapshotPlayerStats(
    Iterable<Character> participants,
  ) {
    final Map<int, BattleStatSnapshot> snapshots = {};
    for (final participant in participants) {
      if (participant is! PlayerCharacter) {
        continue;
      }
      final id = participant.id;
      if (id == null) {
        continue;
      }
      snapshots[id] = BattleStatSnapshot(
        hp: participant.hp,
        mp: participant.mp,
      );
    }
    return snapshots;
  }

  void _persistBattleChanges(
    Map<int, BattleStatSnapshot> snapshots,
  ) {
    if (snapshots.isEmpty) {
      return;
    }
    unawaited(
      charactersProvider.persistBattleChanges(snapshots).catchError((e, s) {
        debugPrint('Failed to persist battle changes: $e');
        debugPrintStack(stackTrace: s);
      }),
    );
  }

  Map<String, String> _serializeActor(Character actor) {
    if (actor is Enemy) {
      return {
        'kind': 'enemy',
        'enemy_type': actor.type.name,
        'name': actor.name,
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

class _EnemyProfile {
  final String id;
  final EnemyType type;
  final int baseHp;
  final int baseMp;
  final int baseAttack;
  final int baseDefense;
  final int baseMagicPower;
  final int baseSpeed;

  const _EnemyProfile({
    required this.id,
    required this.type,
    required this.baseHp,
    required this.baseMp,
    required this.baseAttack,
    required this.baseDefense,
    required this.baseMagicPower,
    required this.baseSpeed,
  });
}
