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
  static const Uuid _uuid = Uuid();
  static final List<_EnemyProfile> _enemyProfiles = [
    const _EnemyProfile(
      id: 'goblin',
      type: EnemyType.regular,
      hp: _EnemyStatScale(base: 90, perFloor: 18, variance: 8),
      mp: _EnemyStatScale(base: 20, perFloor: 4, variance: 3),
      attack: _EnemyStatScale(base: 10, perFloor: 3, variance: 2),
      defense: _EnemyStatScale(base: 7, perFloor: 2, variance: 2),
      magicPower: _EnemyStatScale(base: 5, perFloor: 1, variance: 1),
      speed: _EnemyStatScale(base: 9, perFloor: 1, variance: 1),
    ),
    const _EnemyProfile(
      id: 'skeleton',
      type: EnemyType.regular,
      hp: _EnemyStatScale(base: 100, perFloor: 20, variance: 8),
      mp: _EnemyStatScale(base: 20, perFloor: 4, variance: 3),
      attack: _EnemyStatScale(base: 11, perFloor: 3, variance: 2),
      defense: _EnemyStatScale(base: 9, perFloor: 3, variance: 2),
      magicPower: _EnemyStatScale(base: 5, perFloor: 1, variance: 1),
      speed: _EnemyStatScale(base: 8, perFloor: 1, variance: 1),
    ),
    const _EnemyProfile(
      id: 'orc',
      type: EnemyType.regular,
      hp: _EnemyStatScale(base: 120, perFloor: 22, variance: 9),
      mp: _EnemyStatScale(base: 20, perFloor: 3, variance: 3),
      attack: _EnemyStatScale(base: 13, perFloor: 4, variance: 2),
      defense: _EnemyStatScale(base: 10, perFloor: 3, variance: 2),
      magicPower: _EnemyStatScale(base: 4, perFloor: 1, variance: 1),
      speed: _EnemyStatScale(base: 7, perFloor: 1, variance: 1),
    ),
    const _EnemyProfile(
      id: 'slime',
      type: EnemyType.irregular,
      hp: _EnemyStatScale(base: 80, perFloor: 16, variance: 7),
      mp: _EnemyStatScale(base: 40, perFloor: 6, variance: 4),
      attack: _EnemyStatScale(base: 8, perFloor: 2, variance: 2),
      defense: _EnemyStatScale(base: 6, perFloor: 2, variance: 2),
      magicPower: _EnemyStatScale(base: 10, perFloor: 4, variance: 2),
      speed: _EnemyStatScale(base: 9, perFloor: 1, variance: 1),
    ),
    const _EnemyProfile(
      id: 'wisp',
      type: EnemyType.irregular,
      hp: _EnemyStatScale(base: 70, perFloor: 14, variance: 6),
      mp: _EnemyStatScale(base: 60, perFloor: 8, variance: 4),
      attack: _EnemyStatScale(base: 7, perFloor: 2, variance: 2),
      defense: _EnemyStatScale(base: 5, perFloor: 1, variance: 1),
      magicPower: _EnemyStatScale(base: 13, perFloor: 5, variance: 3),
      speed: _EnemyStatScale(base: 11, perFloor: 2, variance: 1),
    ),
    const _EnemyProfile(
      id: 'ghost',
      type: EnemyType.irregular,
      hp: _EnemyStatScale(base: 90, perFloor: 18, variance: 7),
      mp: _EnemyStatScale(base: 50, perFloor: 7, variance: 4),
      attack: _EnemyStatScale(base: 9, perFloor: 3, variance: 2),
      defense: _EnemyStatScale(base: 7, perFloor: 2, variance: 2),
      magicPower: _EnemyStatScale(base: 12, perFloor: 4, variance: 2),
      speed: _EnemyStatScale(base: 10, perFloor: 1, variance: 1),
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
    _syncTaskTimers();
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

  void _syncTaskTimers() {
    if (_tasks.isEmpty) {
      return;
    }
    final now = DateTime.now();
    for (final task in _tasks) {
      if (task.status != TaskStatus.running) {
        continue;
      }
      task.lastUpdatedAt = now;
    }
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
    List<Character> targets, {
    List<_TargetEffect>? effects,
  }) {
    final serializedTargets =
        targets.map((target) => _serializeActor(target)).toList();
    final data = {
      'subject': jsonEncode(_serializeActor(subject)),
      'action_uuid': action.uuid,
      'targets': jsonEncode(serializedTargets),
    };
    if (effects != null) {
      data['effects'] =
          jsonEncode(effects.map((effect) => effect.toJson()).toList());
    }
    addLog(
      LogType.battle,
      LogMessageId.battleAction,
      data: data,
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
    const range = _exploreMaxDelayMs - _exploreMinDelayMs;
    final offset = range <= 0 ? 0 : vermelhaContext.random.nextInt(range + 1);
    _nextExploreAt = DateTime.now().add(
      Duration(milliseconds: _exploreMinDelayMs + offset),
    );
  }

  void _startBattle() {
    fillEnemies();
    _isInBattle = true;
    _nextExploreAt = null;
    _tasks.clear();
    _turnOrder = [];
    _vermelhaContext.lastAttackers.clear();
    _vermelhaContext.defending.clear();
    addLog(LogType.battle, LogMessageId.battleEncounter);
    _buildTurnOrder();
  }

  void _handleBattleTick() {
    final now = DateTime.now();
    if (_isPartyDefeated()) {
      unawaited(_handlePartyDefeat());
      return;
    }
    if (_isEnemyDefeated()) {
      _finishBattle();
      return;
    }
    final progressed = _advanceRunningTasks(now);
    final resolved = _resolveCompletedTasks(now);
    if (_isPartyDefeated()) {
      unawaited(_handlePartyDefeat());
      return;
    }
    if (_isEnemyDefeated()) {
      _finishBattle();
      return;
    }
    final started = _startIdleActors(now);
    if (progressed || resolved || started) {
      notifyListeners();
    }
  }

  bool _isPartyDefeated() {
    return vermelhaContext.allies.isEmpty ||
        vermelhaContext.allies.every((ally) => ally.hp <= 0);
  }

  bool _isEnemyDefeated() {
    return vermelhaContext.enemies.isEmpty ||
        vermelhaContext.enemies.every((enemy) => enemy.hp <= 0);
  }

  bool _startIdleActors(DateTime now) {
    if (_turnOrder.isEmpty) {
      _buildTurnOrder();
    }
    final runningSubjects = _tasks
        .where((task) => task.status == TaskStatus.running)
        .map((task) => task.subject)
        .toSet();
    bool started = false;
    for (final actor in _turnOrder) {
      if (actor.hp <= 0) {
        continue;
      }
      if (runningSubjects.contains(actor)) {
        continue;
      }
      final decision = _decideAction(actor);
      final action = decision.action;
      final targets = decision.targets;
      if (targets.isEmpty) {
        continue;
      }
      _startActionTask(actor, action, targets, now);
      runningSubjects.add(actor);
      started = true;
    }
    return started;
  }

  void _startActionTask(
    Character actor,
    Action action,
    List<Character> targets,
    DateTime now,
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
      startedAt: now,
      lastUpdatedAt: now,
      subject: actor,
      action: action,
      targets: targets,
      status: TaskStatus.running,
      progress: 0,
      durationMs: durationMs,
      elapsedMs: 0,
      wasTelegraphing: actor is Enemy && actor.isTelegraphing,
    );
    _tasks.add(task);
  }

  bool _advanceRunningTasks(DateTime now) {
    if (_tasks.isEmpty) {
      return false;
    }
    bool updated = false;
    for (final task in _tasks) {
      if (task.status != TaskStatus.running) {
        continue;
      }
      final deltaMs = now.difference(task.lastUpdatedAt).inMilliseconds;
      if (deltaMs <= 0) {
        continue;
      }
      task.elapsedMs += deltaMs;
      task.lastUpdatedAt = now;
      final progress = (task.elapsedMs / task.durationMs) * 100;
      final clamped = progress.clamp(0, 100).toDouble();
      if (clamped != task.progress) {
        updated = true;
      }
      task.progress = clamped;
    }
    return updated;
  }

  bool _resolveCompletedTasks(DateTime now) {
    final completed = _tasks
        .where(
          (task) =>
              task.status == TaskStatus.running && task.progress >= 100.0,
        )
        .toList();
    if (completed.isEmpty) {
      return false;
    }
    completed.sort((a, b) {
      final speedCompare = b.subject.speed.compareTo(a.subject.speed);
      if (speedCompare != 0) {
        return speedCompare;
      }
      final startedCompare = a.startedAt.compareTo(b.startedAt);
      if (startedCompare != 0) {
        return startedCompare;
      }
      return a.uuid.compareTo(b.uuid);
    });
    bool resolved = false;
    for (final task in completed) {
      if (!_tasks.contains(task)) {
        continue;
      }
      if (task.subject.hp <= 0) {
        _cancelTask(task, now);
        resolved = true;
        continue;
      }
      _resolveTask(task, now);
      resolved = true;
    }
    return resolved;
  }

  void _cancelTask(Task task, DateTime now) {
    task.status = TaskStatus.canceled;
    task.progress = 0;
    task.finishedAt = now;
    _tasks.remove(task);
  }

  void _resolveTask(Task task, DateTime now) {
    final actor = task.subject;
    final action = task.action;
    final targets = task.targets;
    final battleSnapshots = _snapshotPlayerStats([actor, ...targets]);
    final targetSnapshots = targets
        .map((target) => _TargetSnapshot(target, target.hp, target.mp))
        .toList();
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
          return actor;
        }),
      );
    }
    _persistBattleChanges(battleSnapshots);
    final effects = targetSnapshots.map((snapshot) {
      final hpDelta = snapshot.target.hp - snapshot.hp;
      final mpDelta = snapshot.target.mp - snapshot.mp;
      return _TargetEffect(
        _serializeActor(snapshot.target),
        hpDelta,
        mpDelta,
      );
    }).toList();
    addActionLog(actor, action, targets, effects: effects);
    task.status = TaskStatus.finished;
    task.progress = 100;
    task.elapsedMs = task.durationMs;
    task.finishedAt = now;
    _tasks.remove(task);
    _maybeTriggerTelegraphing(actor, task.wasTelegraphing);
    if (scrollDownFunc != null) {
      scrollDownFunc!();
    }
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
    _tasks.clear();
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

  int _scaleStat(_EnemyStatScale scale, int floor) {
    final scaled = scale.base + (floor - 1) * scale.perFloor;
    if (scale.variance <= 0) {
      return max(1, scaled);
    }
    final spread = scale.variance * 2 + 1;
    final offset = vermelhaContext.random.nextInt(spread) - scale.variance;
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
      final maxHp = _scaleStat(profile.hp, floor);
      final maxMp = _scaleStat(profile.mp, floor);
      final enemy = Enemy(
        type: profile.type,
        isTelegraphing: false,
        uuid: _uuid.v4(),
        name: profile.id,
        level: floor,
        maxHp: maxHp,
        hp: maxHp,
        maxMp: maxMp,
        mp: maxMp,
        attack: _scaleStat(profile.attack, floor),
        defense: _scaleStat(profile.defense, floor),
        magicPower: _scaleStat(profile.magicPower, floor),
        speed: _scaleStat(profile.speed, floor),
        priorityParameters: <StatusParameter>[],
        battleRules: <BattleRule>[],
      );
      enemy.battleRules = [
        BattleRule(
          owner: enemy,
          priority: 1,
          name: "Enemy Rule",
          target: getTargetByUuid(targetRandomAllyId),
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
    return rule.target.targetCategory == TargetCategory.ally
        ? vermelhaContext.allies
        : vermelhaContext.enemies;
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

class _TargetSnapshot {
  final Character target;
  final int hp;
  final int mp;

  const _TargetSnapshot(this.target, this.hp, this.mp);
}

class _TargetEffect {
  final Map<String, String> actor;
  final int hpDelta;
  final int mpDelta;

  const _TargetEffect(this.actor, this.hpDelta, this.mpDelta);

  Map<String, Object> toJson() {
    return {
      'actor': actor,
      'hp_delta': hpDelta,
      'mp_delta': mpDelta,
    };
  }
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
  final _EnemyStatScale hp;
  final _EnemyStatScale mp;
  final _EnemyStatScale attack;
  final _EnemyStatScale defense;
  final _EnemyStatScale magicPower;
  final _EnemyStatScale speed;

  const _EnemyProfile({
    required this.id,
    required this.type,
    required this.hp,
    required this.mp,
    required this.attack,
    required this.defense,
    required this.magicPower,
    required this.speed,
  });
}

class _EnemyStatScale {
  final int base;
  final int perFloor;
  final int variance;

  const _EnemyStatScale({
    required this.base,
    required this.perFloor,
    required this.variance,
  });
}
