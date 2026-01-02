import 'package:flutter/material.dart';
import 'package:vermelha_app/models/equipment_slot.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/party_position.dart';
import 'package:vermelha_app/repository/character_repository.dart';

class CharactersProvider extends ChangeNotifier {
  List<PlayerCharacter> _characters = [];

  final CharacterRepository _characterRepository = CharacterRepository();

  List<PlayerCharacter> get characters => _characters;

  List<PlayerCharacter> get partyMembers {
    final members =
        _characters.where((c) => c.partyPosition != null).toList();
    members.sort(
      (a, b) => a.partyPosition!.index.compareTo(b.partyPosition!.index),
    );
    return members;
  }

  bool get isPartyComplete {
    return PartyPosition.values
        .every((position) => memberAt(position) != null);
  }

  bool isInventoryFull(PlayerCharacter character) {
    return character.inventory.length >= character.inventoryCapacity;
  }

  Future<void> addItemToInventory(PlayerCharacter character, Item item) async {
    final inventory = List<Item>.from(character.inventory)..add(item);
    await updateCharacter(character.copyWith(inventory: inventory));
  }

  Future<void> removeItemFromInventory(
    PlayerCharacter character,
    Item item,
  ) async {
    final inventory = List<Item>.from(character.inventory);
    final index = inventory.indexWhere((element) => element.id == item.id);
    if (index >= 0) {
      inventory.removeAt(index);
      await updateCharacter(character.copyWith(inventory: inventory));
    }
  }

  Future<bool> equipItem(
    PlayerCharacter character,
    Item item,
  ) async {
    final slot = item.equipmentSlot;
    if (slot == null) {
      return false;
    }
    final inventory = List<Item>.from(character.inventory);
    final inventoryIndex =
        inventory.indexWhere((element) => element.id == item.id);
    if (inventoryIndex >= 0) {
      inventory.removeAt(inventoryIndex);
    }
    final equipment = Map<EquipmentSlot, Item?>.from(character.equipment);
    final previous = equipment[slot];
    if (previous != null) {
      if (inventory.length >= character.inventoryCapacity) {
        return false;
      }
      inventory.add(previous);
    }
    equipment[slot] = item;
    await updateCharacter(
      character.copyWith(inventory: inventory, equipment: equipment),
    );
    return true;
  }

  Future<bool> unequipItem(
    PlayerCharacter character,
    EquipmentSlot slot,
  ) async {
    final equipment = Map<EquipmentSlot, Item?>.from(character.equipment);
    final item = equipment[slot];
    if (item == null) {
      return false;
    }
    if (character.inventory.length >= character.inventoryCapacity) {
      return false;
    }
    equipment[slot] = null;
    final inventory = List<Item>.from(character.inventory)..add(item);
    await updateCharacter(
      character.copyWith(inventory: inventory, equipment: equipment),
    );
    return true;
  }

  PlayerCharacter? memberAt(PartyPosition position) {
    for (final character in _characters) {
      if (character.partyPosition == position) {
        return character;
      }
    }
    return null;
  }

  Future<void> loadCharacters() async {
    _characters = await _characterRepository.findAll();
    notifyListeners();
  }

  Future<PlayerCharacter> addCharacter(PlayerCharacter character) async {
    final c = await _characterRepository.save(character);
    _characters.add(c);
    notifyListeners();
    return c;
  }

  Future<void> removeCharacter(PlayerCharacter character) async {
    debugPrint("removing character ${character.name}");
    _characters.remove(character);
    int count = await _characterRepository.delete(character);
    debugPrint("removed $count character");
    notifyListeners();
  }

  Future<PlayerCharacter> updateCharacter(PlayerCharacter character) async {
    final index = _characters.indexWhere((c) => c.id == character.id);
    _characters[index] = character;
    final c = await _characterRepository.update(character);
    notifyListeners();
    return c;
  }

  Future<void> persistBattleChanges(
    Map<int, BattleStatSnapshot> snapshots,
  ) async {
    if (snapshots.isEmpty) {
      return;
    }
    final List<PlayerCharacter> changed = [];
    for (final entry in snapshots.entries) {
      final id = entry.key;
      final index = _characters.indexWhere((c) => c.id == id);
      if (index < 0) {
        continue;
      }
      final character = _characters[index];
      final snapshot = entry.value;
      if (character.hp == snapshot.hp && character.mp == snapshot.mp) {
        continue;
      }
      changed.add(character);
    }
    if (changed.isEmpty) {
      return;
    }
    final updated = await _characterRepository.updateVitalsBatch(changed);
    if (updated) {
      notifyListeners();
    }
  }

  Future<void> assignPartyMember(
    PartyPosition position,
    PlayerCharacter? character,
  ) async {
    final current = memberAt(position);
    if (current != null && (character == null || current.id != character.id)) {
      await updateCharacter(current.copyWith(partyPosition: null));
    }

    if (character == null) {
      return;
    }

    await updateCharacter(character.copyWith(partyPosition: position));
  }

  Future<void> healPartyMembers() async {
    bool updated = false;
    for (int i = 0; i < _characters.length; i++) {
      final character = _characters[i];
      if (character.partyPosition == null) {
        continue;
      }
      if (character.hp == character.maxHp && character.mp == character.maxMp) {
        continue;
      }
      final healed = character.copyWith(
        hp: character.maxHp,
        mp: character.maxMp,
      );
      _characters[i] = healed;
      await _characterRepository.update(healed);
      updated = true;
    }
    if (updated) {
      notifyListeners();
    }
  }
}

class BattleStatSnapshot {
  final int hp;
  final int mp;

  const BattleStatSnapshot({
    required this.hp,
    required this.mp,
  });
}
