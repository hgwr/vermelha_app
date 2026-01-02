import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';
import 'package:vermelha_app/models/enemy.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/dungeon_provider.dart';
import 'package:vermelha_app/providers/game_state_provider.dart';
import 'package:vermelha_app/providers/tasks_provider.dart';
import 'package:vermelha_app/widgets/task_widget.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/screens/camp_screen.dart';
import 'package:vermelha_app/screens/city_menu_screen.dart';
import 'package:vermelha_app/models/log_entry.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/party_position.dart';
import 'package:vermelha_app/models/task.dart';

class DungeonScreen extends StatefulWidget {
  const DungeonScreen({Key? key}) : super(key: key);

  static const routeName = '/dungeon';

  @override
  State<DungeonScreen> createState() => _DungeonScreenState();
}

class _DungeonScreenState extends State<DungeonScreen> {
  static const double _timelineAutoScrollThreshold = 60;
  final ScrollController _timelineScrollController = ScrollController();
  late final TasksProvider _taskProvider;
  int _lastLogCount = 0;
  int _lastRunningTaskCount = 0;
  bool _isTimelineScrollControllerDisposed = false;
  bool _isLootDialogOpen = false;
  String? _lastLootId;
  bool _isTimelineAutoScrollEnabled = true;

  _LogActor? _decodeActor(String? raw) {
    if (raw == null || raw.isEmpty) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! Map) {
        return null;
      }
      return _decodeActorMap(Map<String, dynamic>.from(decoded));
    } on FormatException {
      return null;
    }
  }

  List<_LogActor> _decodeActors(String? raw) {
    if (raw == null || raw.isEmpty) {
      return [];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return [];
      }
      return decoded
          .whereType<Map>()
          .map((entry) => _decodeActorMap(Map<String, dynamic>.from(entry)))
          .whereType<_LogActor>()
          .toList();
    } on FormatException {
      return [];
    }
  }

  List<_LogActorEffect> _decodeActorEffects(String? raw) {
    if (raw == null || raw.isEmpty) {
      return [];
    }
    try {
      final decoded = jsonDecode(raw);
      if (decoded is! List) {
        return [];
      }
      return decoded
          .whereType<Map>()
          .map((entry) => _decodeActorEffectMap(Map<String, dynamic>.from(entry)))
          .whereType<_LogActorEffect>()
          .toList();
    } on FormatException {
      return [];
    }
  }

  _LogActor? _decodeActorMap(Map<String, dynamic> map) {
    final kind = map['kind'] as String?;
    if (kind == 'enemy') {
      return _LogActor(
        kind: 'enemy',
        enemyType: _enemyTypeFromString(map['enemy_type'] as String?),
        name: map['name'] as String?,
      );
    }
    return _LogActor(
      kind: kind ?? 'player',
      name: map['name'] as String?,
    );
  }

  _LogActorEffect? _decodeActorEffectMap(Map<String, dynamic> map) {
    final actorRaw = map['actor'];
    if (actorRaw is! Map) {
      return null;
    }
    final actor = _decodeActorMap(Map<String, dynamic>.from(actorRaw));
    if (actor == null) {
      return null;
    }
    return _LogActorEffect(
      actor: actor,
      hpDelta: _readDelta(map['hp_delta']),
      mpDelta: _readDelta(map['mp_delta']),
    );
  }

  int _readDelta(Object? value) {
    if (value is num) {
      return value.round();
    }
    if (value is String) {
      return int.tryParse(value) ?? 0;
    }
    return 0;
  }

  EnemyType? _enemyTypeFromString(String? value) {
    if (value == null) {
      return null;
    }
    for (final type in EnemyType.values) {
      if (type.name == value) {
        return type;
      }
    }
    return null;
  }

  String _actorLabel(AppLocalizations l10n, _LogActor? actor) {
    if (actor == null) {
      return l10n.unknownLabel;
    }
    if (actor.kind == 'enemy') {
      if (actor.name != null && actor.name!.isNotEmpty) {
        return enemyNameLabel(l10n, actor.name!);
      }
      if (actor.enemyType != null) {
        return enemyLabel(l10n, actor.enemyType!);
      }
    }
    return actor.name ?? l10n.unknownLabel;
  }

  void scrollDown() {
    if (_isTimelineScrollControllerDisposed) {
      return;
    }
    if (!_timelineScrollController.hasClients) {
      return;
    }
    _timelineScrollController.animateTo(
      _timelineScrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  void _handleTimelineScroll() {
    if (_isTimelineScrollControllerDisposed ||
        !_timelineScrollController.hasClients) {
      return;
    }
    final position = _timelineScrollController.position;
    final isNearBottom = position.pixels >=
        position.maxScrollExtent - _timelineAutoScrollThreshold;
    _isTimelineAutoScrollEnabled = isNearBottom;
  }

  Widget _buildTimelineView(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Consumer2<TasksProvider, CharactersProvider>(
        builder: (context, taskProvider, charactersProvider, _) {
          taskProvider.scrollDownFunc = scrollDown;
          final partyMembersByName = {
            for (final member in charactersProvider.partyMembers)
              member.name: member,
          };
          final logs = taskProvider.logEntries;
          final runningTasks = taskProvider.tasks
              .where((task) => task.status == TaskStatus.running)
              .toList();
          if (logs.length != _lastLogCount ||
              runningTasks.length != _lastRunningTaskCount) {
            final shouldAutoScroll = _isTimelineAutoScrollEnabled;
            _lastLogCount = logs.length;
            _lastRunningTaskCount = runningTasks.length;
            if (shouldAutoScroll) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (!mounted || _isTimelineScrollControllerDisposed) {
                  return;
                }
                scrollDown();
              });
            }
          }
          final items = [
            ...logs.map(_TimelineItem.log),
            ...runningTasks.map(_TimelineItem.task),
          ];
          items.sort((a, b) => a.timestamp.compareTo(b.timestamp));
          return Card(
            child: ListView.builder(
              controller: _timelineScrollController,
              padding: const EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final log = item.log;
                if (log != null) {
                  return _buildTimelineLogTile(
                    l10n,
                    log,
                    partyMembersByName,
                  );
                }
                final task = item.task!;
                return TaskWidget(
                  key: ValueKey(task.uuid.toString()),
                  task: task,
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildTimelineLogTile(
    AppLocalizations l10n,
    LogEntry log,
    Map<String, PlayerCharacter> partyMembersByName,
  ) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: _buildLogLeading(l10n, log, partyMembersByName),
      title: Text(_logMessage(l10n, log)),
    );
  }

  Widget _buildLogLeading(
    AppLocalizations l10n,
    LogEntry log,
    Map<String, PlayerCharacter> partyMembersByName,
  ) {
    if (log.messageId == LogMessageId.battleAction) {
      final subject = _decodeActor(log.data?['subject']);
      final member = partyMembersByName[subject?.name];
      if (member != null) {
        return _buildStatusGauge(l10n, member);
      }
    }
    return Icon(_logTypeIcon(log.type));
  }

  IconData _logTypeIcon(LogType type) {
    switch (type) {
      case LogType.explore:
        return Icons.map;
      case LogType.battle:
        return Icons.flash_on;
      case LogType.loot:
        return Icons.card_giftcard;
      case LogType.system:
        return Icons.info_outline;
    }
  }

  Widget _buildStatusGauge(
    AppLocalizations l10n,
    PlayerCharacter? member,
  ) {
    final icon = member?.job == null
        ? const Icon(Icons.person_outline, size: 24)
        : getImageByJob(member!.job!);
    final hpValue =
        member == null || member.maxHp <= 0 ? 0.0 : member.hp / member.maxHp;
    final mpValue =
        member == null || member.maxMp <= 0 ? 0.0 : member.mp / member.maxMp;
    final hpColor = member == null ? Colors.grey : Colors.red;
    final mpColor = member == null ? Colors.grey : Colors.blue;
    return SizedBox(
      width: 46,
      child: Column(
        children: [
          SizedBox(
            height: 28,
            child: icon,
          ),
          Row(
            children: [
              Text(
                l10n.hpShort,
                style: const TextStyle(fontSize: 8),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: hpValue.clamp(0, 1),
                  backgroundColor: hpColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(hpColor),
                  minHeight: 4,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                l10n.mpShort,
                style: const TextStyle(fontSize: 8),
              ),
              Expanded(
                child: LinearProgressIndicator(
                  value: mpValue.clamp(0, 1),
                  backgroundColor: mpColor.withOpacity(0.2),
                  valueColor: AlwaysStoppedAnimation<Color>(mpColor),
                  minHeight: 4,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPartyOverview(AppLocalizations l10n) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Consumer<CharactersProvider>(
        builder: (context, charactersProvider, _) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  for (final position in PartyPosition.values) ...[
                    Expanded(
                      child: _buildPartySlot(
                        l10n,
                        position,
                        charactersProvider.memberAt(position),
                      ),
                    ),
                    if (position != PartyPosition.values.last)
                      const SizedBox(width: 8),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPartySlot(
    AppLocalizations l10n,
    PartyPosition position,
    PlayerCharacter? member,
  ) {
    final name =
        member == null ? l10n.partySlotEmpty : _memberLabel(l10n, member);
    final nameStyle = TextStyle(
      fontSize: 11,
      color: member == null ? Colors.grey : null,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          _positionLabel(l10n, position),
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        _buildStatusGauge(l10n, member),
        const SizedBox(height: 4),
        Text(
          name,
          style: nameStyle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _logMessage(AppLocalizations l10n, LogEntry entry) {
    switch (entry.messageId) {
      case LogMessageId.explorationStart:
        return l10n.logExplorationStart;
      case LogMessageId.explorationMove:
        return l10n.logExplorationMove;
      case LogMessageId.explorationTreasure:
        return l10n.logExplorationTreasure;
      case LogMessageId.explorationTrap:
        return l10n.logExplorationTrap;
      case LogMessageId.battleEncounter:
        return l10n.logBattleEncounter;
      case LogMessageId.battleAction:
        final data = entry.data ?? {};
        final actionUuid = data['action_uuid'];
        if (actionUuid == null) {
          final subject = data['subject'] ?? '';
          final action = data['action'] ?? '';
          final targets = data['targets'] ?? '';
          return l10n.logBattleAction(subject, action, targets);
        }
        final subject = _decodeActor(data['subject']);
        final targets = _decodeActors(data['targets']);
        final effects = _decodeActorEffects(data['effects']);
        final subjectLabel = _actorLabel(l10n, subject);
        final actionLabel = actionLabelByUuid(l10n, actionUuid);
        final targetsLabel = effects.isNotEmpty
            ? effects
                .map((effect) => _formatEffectLabel(l10n, effect))
                .join(', ')
            : targets
                .map((target) => _actorLabel(l10n, target))
                .join(', ');
        return l10n.logBattleAction(subjectLabel, actionLabel, targetsLabel);
      case LogMessageId.battleVictory:
        return l10n.logBattleVictory;
      case LogMessageId.lootNone:
        return l10n.logLootNone;
      case LogMessageId.lootGold:
        final amount = entry.data?['amount'] ?? '';
        return l10n.logLootGold(amount);
      case LogMessageId.lootItem:
        final item = entry.data?['item'] ?? l10n.unknownLabel;
        return l10n.logLootItem(item);
      case LogMessageId.campHeal:
        return l10n.logCampHeal;
      case LogMessageId.partyDefeatedReturn:
        return l10n.logPartyDefeatedReturn;
      case LogMessageId.returnToCity:
        return l10n.logReturnToCity;
    }
  }

  String _formatEffectLabel(
    AppLocalizations l10n,
    _LogActorEffect effect,
  ) {
    final actorLabel = _actorLabel(l10n, effect.actor);
    final parts = <String>[];
    if (effect.hpDelta != 0) {
      parts.add('${l10n.hpShort} ${_formatDelta(effect.hpDelta)}');
    }
    if (effect.mpDelta != 0) {
      parts.add('${l10n.mpShort} ${_formatDelta(effect.mpDelta)}');
    }
    if (parts.isEmpty) {
      return actorLabel;
    }
    return '$actorLabel (${parts.join(', ')})';
  }

  String _formatDelta(int value) {
    if (value > 0) {
      return '+$value';
    }
    return value.toString();
  }

  String _positionLabel(AppLocalizations l10n, PartyPosition position) {
    switch (position) {
      case PartyPosition.forward:
        return l10n.partyPositionForward;
      case PartyPosition.middle:
        return l10n.partyPositionMiddle;
      case PartyPosition.rear:
        return l10n.partyPositionRear;
    }
  }

  String _memberLabel(AppLocalizations l10n, PlayerCharacter member) {
    final job = member.job;
    final jobName = job == null ? '' : jobLabel(l10n, job);
    return '$jobName ${member.name}';
  }

  Future<bool> _showConfirmDialog({
    required String title,
    required String body,
  }) async {
    return await showDialog<bool>(
          context: context,
          builder: (context) {
            final l10n = AppLocalizations.of(context)!;
            return AlertDialog(
              title: Text(title),
              content: Text(body),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text(l10n.confirm),
                ),
              ],
            );
          },
        ) ??
        false;
  }

  Future<void> _handleCampPressed() async {
    final l10n = AppLocalizations.of(context)!;
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final wasRunning = tasksProvider.engineStatus == EngineStatus.running;
    if (wasRunning) {
      tasksProvider.pauseEngine();
    }
    final confirmed = await _showConfirmDialog(
      title: l10n.campConfirmTitle,
      body: l10n.campConfirmBody,
    );
    if (!mounted) {
      return;
    }
    if (!confirmed) {
      if (wasRunning) {
        tasksProvider.startEngine();
      }
      return;
    }
    Navigator.of(context).pushNamed(CampScreen.routeName);
  }

  Future<void> _handleReturnToCityPressed() async {
    final l10n = AppLocalizations.of(context)!;
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final wasRunning = tasksProvider.engineStatus == EngineStatus.running;
    if (wasRunning) {
      tasksProvider.pauseEngine();
    }
    final confirmed = await _showConfirmDialog(
      title: l10n.returnToCityConfirmTitle,
      body: l10n.returnToCityConfirmBody,
    );
    if (!mounted) {
      return;
    }
    if (!confirmed) {
      if (wasRunning) {
        tasksProvider.startEngine();
      }
      return;
    }
    tasksProvider.addLog(LogType.system, LogMessageId.returnToCity);
    tasksProvider.resetBattle();
    Provider.of<DungeonProvider>(context, listen: false).returnToCity();
    Navigator.of(context).popUntil(
      (route) => route.settings.name == CityMenuScreen.routeName,
    );
  }

  void _maybeHandleLoot(TasksProvider tasksProvider) {
    final pending = tasksProvider.pendingLoot;
    if (pending == null ||
        _isLootDialogOpen ||
        _lastLootId == pending.id) {
      return;
    }
    _lastLootId = pending.id;
    _isLootDialogOpen = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!mounted) {
        return;
      }
      await _handlePendingLoot(pending);
      _isLootDialogOpen = false;
    });
  }

  Future<void> _handlePendingLoot(PendingLoot loot) async {
    if (!mounted) {
      return;
    }
    final tasksProvider = Provider.of<TasksProvider>(context, listen: false);
    final charactersProvider =
        Provider.of<CharactersProvider>(context, listen: false);
    final gameStateProvider =
        Provider.of<GameStateProvider>(context, listen: false);

    if (loot.type == LootType.gold) {
      await gameStateProvider.addGold(loot.gold);
      if (!mounted) {
        tasksProvider.resolvePendingLoot();
        return;
      }
      tasksProvider.addLog(
        LogType.loot,
        LogMessageId.lootGold,
        data: {
          'amount': loot.gold.toString(),
        },
      );
      tasksProvider.resolvePendingLoot();
      return;
    }

    final item = loot.item;
    if (item == null) {
      tasksProvider.resolvePendingLoot();
      return;
    }

    var owner = _findCharacter(charactersProvider, loot.ownerId) ??
        (charactersProvider.partyMembers.isEmpty
            ? null
            : charactersProvider.partyMembers.first);
    if (owner == null) {
      tasksProvider.resolvePendingLoot();
      return;
    }

    if (charactersProvider.isInventoryFull(owner)) {
      final discard = await _selectDiscardItem(context, owner, item);
      if (!mounted) {
        tasksProvider.resolvePendingLoot();
        return;
      }
      if (discard == null || discard.isNew) {
        tasksProvider.addLog(LogType.loot, LogMessageId.lootNone);
        tasksProvider.resolvePendingLoot();
        return;
      }
      await charactersProvider.removeItemFromInventory(owner, discard.item);
      if (!mounted) {
        tasksProvider.resolvePendingLoot();
        return;
      }
      owner = _findCharacter(charactersProvider, owner.id) ?? owner;
    }

    await charactersProvider.addItemToInventory(owner, item);
    if (!mounted) {
      tasksProvider.resolvePendingLoot();
      return;
    }
    final l10n = AppLocalizations.of(context)!;
    tasksProvider.addLog(
      LogType.loot,
      LogMessageId.lootItem,
      data: {
        'item': itemLabel(l10n, item),
      },
    );
    tasksProvider.resolvePendingLoot();
  }

  Future<_DiscardOption?> _selectDiscardItem(
    BuildContext context,
    PlayerCharacter character,
    Item newItem,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    final choices = [
      ...character.inventory
          .map((item) => _DiscardOption(item: item, isNew: false)),
      _DiscardOption(item: newItem, isNew: true),
    ];
    return showDialog<_DiscardOption>(
      context: context,
      builder: (context) {
        _DiscardOption? selected;
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text(l10n.inventoryFullTitle),
              content: SizedBox(
                width: double.maxFinite,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(l10n.inventoryFullBody),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 240,
                      child: ListView.builder(
                        itemCount: choices.length,
                        itemBuilder: (context, index) {
                          final option = choices[index];
                          final item = option.item;
                          final label = option.isNew
                              ? l10n.inventoryDiscardNewItem(
                                  itemLabel(l10n, item),
                                )
                              : itemLabel(l10n, item);
                          return RadioListTile<_DiscardOption>(
                            value: option,
                            groupValue: selected,
                            title: Text(label),
                            onChanged: (value) {
                              setState(() {
                                selected = value;
                              });
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(null),
                  child: Text(l10n.cancel),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(selected),
                  child: Text(l10n.confirm),
                ),
              ],
            );
          },
        );
      },
    );
  }

  PlayerCharacter? _findCharacter(
    CharactersProvider provider,
    int? id,
  ) {
    if (id == null) {
      return null;
    }
    for (final character in provider.characters) {
      if (character.id == id) {
        return character;
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final tasksProvider = Provider.of<TasksProvider>(context);
    final dungeonProvider = Provider.of<DungeonProvider>(context);
    _maybeHandleLoot(tasksProvider);
    if (!dungeonProvider.isExploring) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) {
          return;
        }
        Navigator.of(context).popUntil(
          (route) => route.settings.name == CityMenuScreen.routeName,
        );
      });
    }
    final activeFloor = dungeonProvider.activeFloor ?? 1;
    final battleCount = dungeonProvider.battleCountOnFloor;
    final battlesToUnlock = dungeonProvider.battlesToUnlockNextFloor;
    return Scaffold(
      appBar: AppBar(title: Text(l10n.dungeonTitle)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Text(
              '${l10n.floorLabel(activeFloor)} / '
              '${l10n.battleCountProgress(battleCount, battlesToUnlock)}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildPartyOverview(l10n),
          Expanded(
            child: _buildTimelineView(l10n),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final charactersProvider =
              Provider.of<CharactersProvider>(context, listen: false);
          if (!charactersProvider.isPartyComplete) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(l10n.partyIncomplete),
              ),
            );
            return;
          }
          Provider.of<TasksProvider>(context, listen: false).engineStatus ==
                  EngineStatus.running
              ? Provider.of<TasksProvider>(context, listen: false).pauseEngine()
              : Provider.of<TasksProvider>(context, listen: false)
                  .startEngine();
        },
        child: Provider.of<TasksProvider>(context).engineStatus ==
                EngineStatus.running
            ? const Icon(Icons.pause)
            : const Icon(Icons.play_arrow),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: _handleCampPressed,
                  child: Text(l10n.campButton),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: _handleReturnToCityPressed,
                  child: Text(l10n.returnToCity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _taskProvider = Provider.of<TasksProvider>(context, listen: false);
    _timelineScrollController.addListener(_handleTimelineScroll);
  }

  @override
  void dispose() {
    if (_taskProvider.scrollDownFunc == scrollDown) {
      _taskProvider.scrollDownFunc = null;
    }
    _timelineScrollController.removeListener(_handleTimelineScroll);
    _timelineScrollController.dispose();
    _isTimelineScrollControllerDisposed = true;
    super.dispose();
  }
}

class _LogActor {
  final String kind;
  final String? name;
  final EnemyType? enemyType;

  const _LogActor({
    required this.kind,
    this.name,
    this.enemyType,
  });
}

class _TimelineItem {
  final DateTime timestamp;
  final LogEntry? log;
  final Task? task;

  _TimelineItem.log(LogEntry log)
      : log = log,
        task = null,
        timestamp = log.timestamp;

  _TimelineItem.task(Task task)
      : task = task,
        log = null,
        timestamp = task.startedAt;
}

class _LogActorEffect {
  final _LogActor actor;
  final int hpDelta;
  final int mpDelta;

  const _LogActorEffect({
    required this.actor,
    required this.hpDelta,
    required this.mpDelta,
  });
}

class _DiscardOption {
  final Item item;
  final bool isNew;

  const _DiscardOption({
    required this.item,
    required this.isNew,
  });
}
