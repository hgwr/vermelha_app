import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/l10n/model_localizations.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/item_catalog.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/providers/characters_provider.dart';
import 'package:vermelha_app/providers/game_state_provider.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  static const routeName = '/shop';

  @override
  State<ShopScreen> createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen>
    with SingleTickerProviderStateMixin {
  PlayerCharacter? _selectedSeller;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Consumer2<CharactersProvider, GameStateProvider>(
      builder: (context, charactersProvider, gameStateProvider, _) {
        if (_selectedSeller == null &&
            charactersProvider.characters.isNotEmpty) {
          _selectedSeller = charactersProvider.characters.first;
        }
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              title: Text(l10n.shopTitle),
              bottom: TabBar(
                tabs: [
                  Tab(text: l10n.shopBuyTab),
                  Tab(text: l10n.shopSellTab),
                ],
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Row(
                    children: [
                      Text(l10n.goldLabel),
                      const SizedBox(width: 8),
                      Text(gameStateProvider.gold.toString()),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      _buildBuyTab(
                        context,
                        charactersProvider,
                        gameStateProvider,
                      ),
                      _buildSellTab(
                        context,
                        charactersProvider,
                        gameStateProvider,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildBuyTab(
    BuildContext context,
    CharactersProvider charactersProvider,
    GameStateProvider gameStateProvider,
  ) {
    final l10n = AppLocalizations.of(context)!;
    return ListView.separated(
      itemCount: itemCatalog.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = itemCatalog[index];
        return ListTile(
          title: Text(itemLabel(l10n, item)),
          subtitle: Text(_itemTypeLabel(l10n, item.type)),
          trailing: Text(l10n.priceLabel(item.price)),
          onTap: () => _handleBuy(
            context,
            item,
            charactersProvider,
            gameStateProvider,
          ),
        );
      },
    );
  }

  Widget _buildSellTab(
    BuildContext context,
    CharactersProvider charactersProvider,
    GameStateProvider gameStateProvider,
  ) {
    final l10n = AppLocalizations.of(context)!;
    if (charactersProvider.characters.isEmpty) {
      return Center(
        child: Text(l10n.noCharacters),
      );
    }

    final currentSeller = _selectedSeller ??
        charactersProvider.characters.firstWhere(
          (c) => c.id == _selectedSeller?.id,
          orElse: () => charactersProvider.characters.first,
        );
    final members = charactersProvider.characters;
    final listHeight = min(56.0 * members.length + 8.0, 200.0);

    final inventory = currentSeller.inventory;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(l10n.shopSelectCharacter),
          ),
        ),
        SizedBox(
          height: listHeight,
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            itemCount: members.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final character = members[index];
              final isSelected = character.id == currentSeller.id;
              return ListTile(
                dense: true,
                selected: isSelected,
                title: Text(character.name),
                subtitle: Text(
                  l10n.inventoryCapacityLabel(
                    character.inventory.length,
                    character.inventoryCapacity,
                  ),
                ),
                trailing: isSelected ? const Icon(Icons.check) : null,
                onTap: () {
                  setState(() {
                    _selectedSeller = character;
                  });
                },
              );
            },
          ),
        ),
        Expanded(
          child: inventory.isEmpty
              ? Center(child: Text(l10n.inventoryEmpty))
              : ListView.separated(
                  itemCount: inventory.length,
                  separatorBuilder: (_, __) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final item = inventory[index];
                    final sellPrice = item.price ~/ 2;
                    return ListTile(
                      title: Text(itemLabel(l10n, item)),
                      subtitle: Text(_itemTypeLabel(l10n, item.type)),
                      trailing: Text(l10n.sellPriceLabel(sellPrice)),
                      onTap: () async {
                        final latest = _findCharacter(
                          charactersProvider,
                          currentSeller.id,
                        );
                        if (latest == null) {
                          return;
                        }
                        await charactersProvider.removeItemFromInventory(
                          latest,
                          item,
                        );
                        await gameStateProvider.addGold(sellPrice);
                        setState(() {
                          _selectedSeller = _findCharacter(
                            charactersProvider,
                            currentSeller.id,
                          );
                        });
                      },
                    );
                  },
                ),
        ),
      ],
    );
  }

  Future<void> _handleBuy(
    BuildContext context,
    Item item,
    CharactersProvider charactersProvider,
    GameStateProvider gameStateProvider,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    if (charactersProvider.characters.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.noCharacters)),
      );
      return;
    }
    if (gameStateProvider.gold < item.price) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.notEnoughGold)),
      );
      return;
    }

    final selected = await _selectCharacter(context, charactersProvider);
    if (selected == null) {
      return;
    }

    var current = _findCharacter(charactersProvider, selected.id);
    if (current == null) {
      return;
    }

    if (charactersProvider.isInventoryFull(current)) {
      final discardOption = await _selectDiscardItem(context, current, item);
      if (discardOption == null) {
        return;
      }
      if (!discardOption.isNew) {
        await charactersProvider.removeItemFromInventory(
          current,
          discardOption.item,
        );
        current = _findCharacter(charactersProvider, current.id);
        if (current == null) {
          return;
        }
      } else {
        return;
      }
    }

    final spent = await gameStateProvider.spendGold(item.price);
    if (!spent) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.notEnoughGold)),
      );
      return;
    }
    await charactersProvider.addItemToInventory(current, item);
  }

  Future<PlayerCharacter?> _selectCharacter(
    BuildContext context,
    CharactersProvider charactersProvider,
  ) async {
    final l10n = AppLocalizations.of(context)!;
    return showModalBottomSheet<PlayerCharacter>(
      context: context,
      builder: (context) {
        return SafeArea(
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(l10n.shopSelectCharacter),
              ),
              for (final character in charactersProvider.characters)
                ListTile(
                  title: Text(character.name),
                  subtitle: Text(
                    l10n.inventoryCapacityLabel(
                      character.inventory.length,
                      character.inventoryCapacity,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(character);
                  },
                ),
            ],
          ),
        );
      },
    );
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

  String _itemTypeLabel(AppLocalizations l10n, ItemType type) {
    switch (type) {
      case ItemType.weapon:
        return l10n.itemTypeWeapon;
      case ItemType.armor:
        return l10n.itemTypeArmor;
      case ItemType.consumable:
        return l10n.itemTypeConsumable;
    }
  }
}

class _DiscardOption {
  final Item item;
  final bool isNew;

  const _DiscardOption({
    required this.item,
    required this.isNew,
  });
}
