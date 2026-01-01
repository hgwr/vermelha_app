import 'package:vermelha_app/models/equipment_slot.dart';

enum ItemType {
  weapon,
  armor,
  consumable,
}

class Item {
  final String id;
  final String name;
  final ItemType type;
  final int price;
  final Map<String, int> effects;
  final EquipmentSlot? equipmentSlot;

  const Item({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    this.effects = const {},
    this.equipmentSlot,
  });

  bool get isEquipable => equipmentSlot != null;
}
