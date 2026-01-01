import 'package:vermelha_app/models/equipment_slot.dart';
import 'package:vermelha_app/models/item.dart';

const List<Item> itemCatalog = [
  Item(
    id: 'weapon_short_sword',
    name: 'ショートソード',
    type: ItemType.weapon,
    price: 120,
    effects: {'attack': 2},
    equipmentSlot: EquipmentSlot.rightHand,
  ),
  Item(
    id: 'weapon_battle_axe',
    name: 'バトルアックス',
    type: ItemType.weapon,
    price: 180,
    effects: {'attack': 3},
    equipmentSlot: EquipmentSlot.rightHand,
  ),
  Item(
    id: 'weapon_long_bow',
    name: 'ロングボウ',
    type: ItemType.weapon,
    price: 160,
    effects: {'attack': 2},
    equipmentSlot: EquipmentSlot.rightHand,
  ),
  Item(
    id: 'armor_leather',
    name: 'レザーアーマー',
    type: ItemType.armor,
    price: 140,
    effects: {'defense': 2},
    equipmentSlot: EquipmentSlot.armor,
  ),
  Item(
    id: 'armor_chain',
    name: 'チェインメイル',
    type: ItemType.armor,
    price: 200,
    effects: {'defense': 3},
    equipmentSlot: EquipmentSlot.armor,
  ),
  Item(
    id: 'consumable_potion',
    name: '回復薬',
    type: ItemType.consumable,
    price: 60,
    effects: {'hp': 50},
  ),
  Item(
    id: 'consumable_ether',
    name: '魔力水',
    type: ItemType.consumable,
    price: 80,
    effects: {'mp': 30},
  ),
];

Item? findItemById(String id) {
  for (final item in itemCatalog) {
    if (item.id == id) {
      return item;
    }
  }
  return null;
}
