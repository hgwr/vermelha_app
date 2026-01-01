import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';
import 'package:vermelha_app/models/enemy.dart';
import 'package:vermelha_app/models/item.dart';
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

class DungeonScreen extends StatefulWidget {
  const DungeonScreen({Key? key}) : super(key: key);

  static const routeName = '/dungeon';

  @override
  State<DungeonScreen> createState() => _DungeonScreenState();
}

class _DungeonScreenState extends State<DungeonScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isLootDialogOpen = false;
  String? _lastLootId;

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
    } catch (_) {
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
    } catch (_) {
      return [];
    }
  }

  _LogActor? _decodeActorMap(Map<String, dynamic> map) {
    final kind = map['kind'] as String?;
    if (kind == 'enemy') {
      return _LogActor(
        kind: 'enemy',
        enemyType: _enemyTypeFromString(map['enemy_type'] as String?),
      );
    }
    return _LogActor(
      kind: kind ?? 'player',
      name: map['name'] as String?,
    );
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
    if (actor.kind == 'enemy' && actor.enemyType != null) {
      return enemyLabel(l10n, actor.enemyType!);
    }
    return actor.name ?? l10n.unknownLabel;
  }

  void scrollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 100),
      curve: Curves.easeOut,
    );
  }

  String _logTypeLabel(AppLocalizations l10n, LogType type) {
    switch (type) {
      case LogType.explore:
        return l10n.logTypeExplore;
      case LogType.battle:
        return l10n.logTypeBattle;
      case LogType.loot:
        return l10n.logTypeLoot;
      case LogType.system:
        return l10n.logTypeSystem;
    }
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
        final subjectLabel = _actorLabel(l10n, subject);
        final actionLabel = actionLabelByUuid(l10n, actionUuid);
        final targetsLabel = targets.map((target) {
          return _actorLabel(l10n, target);
        }).join(', ');
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
      case LogMessageId.returnToCity:
        return l10n.logReturnToCity;
    }
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.floorLabel(activeFloor)),
                const SizedBox(height: 4),
                Text(l10n.battleCountProgress(battleCount, battlesToUnlock)),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Consumer<TasksProvider>(
                builder: (context, taskProvider, _) {
                  final logs = taskProvider.logEntries;
                  return Card(
                    child: ListView.builder(
                      padding: const EdgeInsets.all(8),
                      itemCount: logs.length,
                      itemBuilder: (context, index) {
                        final log = logs[index];
                        return Text(
                          "[${_logTypeLabel(l10n, log.type)}] "
                          "${_logMessage(l10n, log)}",
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Consumer<TasksProvider>(
                builder: (ctx, taskProvider, child) {
                  taskProvider.scrollDownFunc = scrollDown;

                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: taskProvider.tasks.length,
                    itemBuilder: (ctx, index) {
                      final task = taskProvider.tasks[index];
                      return TaskWidget(
                        key: ValueKey(task.uuid.toString()),
                        task: task,
                      );
                    },
                  );
                },
              ),
            ),
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
                  onPressed: () {
                    Provider.of<TasksProvider>(context, listen: false)
                        .pauseEngine();
                    Navigator.of(context).pushNamed(CampScreen.routeName);
                  },
                  child: Text(l10n.campButton),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Provider.of<TasksProvider>(context, listen: false)
                        .addLog(LogType.system, LogMessageId.returnToCity);
                    Provider.of<TasksProvider>(context, listen: false)
                        .resetBattle();
                    Provider.of<DungeonProvider>(context, listen: false)
                        .returnToCity();
                    Navigator.of(context).popUntil(
                      (route) => route.settings.name == CityMenuScreen.routeName,
                    );
                  },
                  child: Text(l10n.returnToCity),
                ),
              ),
            ],
          ),
        ),
      ),
    );
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

class _DiscardOption {
  final Item item;
  final bool isNew;

  const _DiscardOption({
    required this.item,
    required this.isNew,
  });
}
