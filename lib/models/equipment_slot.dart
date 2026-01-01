enum EquipmentSlot {
  rightHand,
  armor,
  accessory,
}

String equipmentSlotToDb(EquipmentSlot slot) {
  return slot.name;
}

EquipmentSlot? equipmentSlotFromDb(Object? value) {
  if (value == null) {
    return null;
  }
  final raw = value.toString();
  for (final slot in EquipmentSlot.values) {
    if (slot.name == raw) {
      return slot;
    }
  }
  return null;
}
