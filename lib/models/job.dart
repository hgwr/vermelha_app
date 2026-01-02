import 'package:flutter/material.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/battle_rule.dart';
import 'package:vermelha_app/models/equipment_slot.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/item_catalog.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/status_parameter.dart';
import 'package:vermelha_app/models/target.dart';

enum Job {
  fighter(id: 1, name: '戦士'),
  paladin(id: 2, name: '神殿騎士'),
  ranger(id: 3, name: 'レンジャー'),
  wizard(id: 4, name: '魔法使い'),
  shaman(id: 5, name: 'シャーマン'),
  priest(id: 6, name: '僧侶');

  final int id;
  final String name;

  const Job({
    required this.id,
    required this.name,
  });
}

const String _shortSwordId = 'weapon_short_sword';
const String _battleAxeId = 'weapon_battle_axe';
const String _longBowId = 'weapon_long_bow';
const String _leatherArmorId = 'armor_leather';
const String _chainArmorId = 'armor_chain';

Job getJobById(int id) {
  switch (id) {
    case 1:
      return Job.fighter;
    case 2:
      return Job.paladin;
    case 3:
      return Job.ranger;
    case 4:
      return Job.wizard;
    case 5:
      return Job.shaman;
    case 6:
      return Job.priest;
    default:
      return Job.fighter;
  }
}

Image getImageByJob(Job job) {
  switch (job) {
    case Job.fighter:
      return Image.asset('assets/images/1_fighter.png');
    case Job.paladin:
      return Image.asset('assets/images/2_paladin.png');
    case Job.ranger:
      return Image.asset('assets/images/3_ranger.png');
    case Job.wizard:
      return Image.asset('assets/images/4_wizard.png');
    case Job.shaman:
      return Image.asset('assets/images/5_shaman.png');
    case Job.priest:
      return Image.asset('assets/images/6_priest.png');
  }
}

PlayerCharacter getInitializedCharacterByJob(Job job) {
  final character = {
    Job.fighter: PlayerCharacter(
      job: Job.fighter,
      name: '戦士',
      level: 1,
      maxHp: 110,
      hp: 110,
      maxMp: 90,
      mp: 90,
      attack: 12,
      defense: 11,
      magicPower: 8,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.attack,
        StatusParameter.defense,
      ],
      equipment: _initialEquipment(
        weaponId: _shortSwordId,
        armorId: _leatherArmorId,
      ),
      battleRules: <BattleRule>[],
    ),
    Job.paladin: PlayerCharacter(
      job: Job.paladin,
      name: '神殿騎士',
      level: 1,
      maxHp: 115,
      hp: 115,
      maxMp: 95,
      mp: 95,
      attack: 10,
      defense: 12,
      magicPower: 9,
      speed: 9,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.defense,
        StatusParameter.mp,
      ],
      equipment: _initialEquipment(
        weaponId: _battleAxeId,
        armorId: _chainArmorId,
      ),
      battleRules: <BattleRule>[],
    ),
    Job.ranger: PlayerCharacter(
      job: Job.ranger,
      name: 'レンジャー',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 90,
      mp: 90,
      attack: 11,
      defense: 9,
      magicPower: 9,
      speed: 12,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.attack,
        StatusParameter.speed,
      ],
      equipment: _initialEquipment(
        weaponId: _longBowId,
        armorId: _leatherArmorId,
      ),
      battleRules: <BattleRule>[],
    ),
    Job.wizard: PlayerCharacter(
      job: Job.wizard,
      name: '魔法使い',
      level: 1,
      maxHp: 90,
      hp: 90,
      maxMp: 115,
      mp: 115,
      attack: 8,
      defense: 8,
      magicPower: 13,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      equipment: _initialEquipment(
        weaponId: _shortSwordId,
        armorId: _leatherArmorId,
      ),
      battleRules: <BattleRule>[],
    ),
    Job.shaman: PlayerCharacter(
      job: Job.shaman,
      name: 'シャーマン',
      level: 1,
      maxHp: 95,
      hp: 95,
      maxMp: 110,
      mp: 110,
      attack: 9,
      defense: 9,
      magicPower: 12,
      speed: 10,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      equipment: _initialEquipment(
        weaponId: _shortSwordId,
        armorId: _leatherArmorId,
      ),
      battleRules: <BattleRule>[],
    ),
    Job.priest: PlayerCharacter(
      job: Job.priest,
      name: '僧侶',
      level: 1,
      maxHp: 100,
      hp: 100,
      maxMp: 110,
      mp: 110,
      attack: 8,
      defense: 10,
      magicPower: 11,
      speed: 9,
      priorityParameters: [
        StatusParameter.hp,
        StatusParameter.magicPower,
        StatusParameter.mp,
      ],
      equipment: _initialEquipment(
        weaponId: _shortSwordId,
        armorId: _leatherArmorId,
      ),
      battleRules: <BattleRule>[],
    ),
  }[job]!;
  character.battleRules = _defaultBattleRulesFor(character);
  return character;
}

Map<EquipmentSlot, Item?> _initialEquipment({
  String? weaponId,
  String? armorId,
}) {
  final Map<EquipmentSlot, Item?> equipment = {};
  if (weaponId != null) {
    final weapon = findItemById(weaponId);
    assert(weapon != null, 'Weapon with id "$weaponId" not found.');
    if (weapon != null) {
      assert(weapon.type == ItemType.weapon, 'Item "$weaponId" is not a weapon.');
      assert(
        weapon.equipmentSlot == EquipmentSlot.rightHand,
        'Item "$weaponId" cannot be equipped in the right hand.',
      );
      equipment[EquipmentSlot.rightHand] = weapon;
    }
  }
  if (armorId != null) {
    final armor = findItemById(armorId);
    assert(armor != null, 'Armor with id "$armorId" not found.');
    if (armor != null) {
      assert(armor.type == ItemType.armor, 'Item "$armorId" is not an armor.');
      assert(
        armor.equipmentSlot == EquipmentSlot.armor,
        'Item "$armorId" cannot be equipped as armor.',
      );
      equipment[EquipmentSlot.armor] = armor;
    }
  }
  return equipment;
}

BattleRule _buildRule({
  required PlayerCharacter owner,
  required int priority,
  required String targetId,
  required String actionId,
}) {
  return BattleRule(
    owner: owner,
    priority: priority,
    name: '',
    target: getTargetByUuid(targetId),
    action: getActionByUuid(actionId),
  );
}

List<BattleRule> _defaultBattleRulesFor(PlayerCharacter owner) {
  switch (owner.job) {
    case Job.fighter:
      return [
        _buildRule(
          owner: owner,
          priority: 1,
          targetId: targetAllyHpBelow25Id,
          actionId: actionUsePotionId,
        ),
        _buildRule(
          owner: owner,
          priority: 2,
          targetId: targetLowestHpEnemyId,
          actionId: actionPhysicalAttackId,
        ),
      ];
    case Job.paladin:
      return [
        _buildRule(
          owner: owner,
          priority: 1,
          targetId: targetAllyHpBelow25Id,
          actionId: actionUsePotionId,
        ),
        _buildRule(
          owner: owner,
          priority: 2,
          targetId: targetAttackingEnemyId,
          actionId: actionPhysicalAttackId,
        ),
        _buildRule(
          owner: owner,
          priority: 3,
          targetId: targetLowestHpEnemyId,
          actionId: actionPhysicalAttackId,
        ),
      ];
    case Job.ranger:
      return [
        _buildRule(
          owner: owner,
          priority: 1,
          targetId: targetAllyHpBelow25Id,
          actionId: actionUsePotionId,
        ),
        _buildRule(
          owner: owner,
          priority: 2,
          targetId: targetHighestAttackEnemyId,
          actionId: actionPhysicalAttackId,
        ),
        _buildRule(
          owner: owner,
          priority: 3,
          targetId: targetLowestHpEnemyId,
          actionId: actionPhysicalAttackId,
        ),
      ];
    case Job.wizard:
      return [
        _buildRule(
          owner: owner,
          priority: 1,
          targetId: targetEnemyTelegraphId,
          actionId: actionAttackMagicId,
        ),
        _buildRule(
          owner: owner,
          priority: 2,
          targetId: targetLowestHpEnemyId,
          actionId: actionAttackMagicId,
        ),
      ];
    case Job.shaman:
      return [
        _buildRule(
          owner: owner,
          priority: 1,
          targetId: targetAllyHpBelow25Id,
          actionId: actionBigCureId,
        ),
        _buildRule(
          owner: owner,
          priority: 2,
          targetId: targetAllyHpBelow75Id,
          actionId: actionSmallCureId,
        ),
        _buildRule(
          owner: owner,
          priority: 3,
          targetId: targetLowestHpEnemyId,
          actionId: actionAttackMagicId,
        ),
      ];
    case Job.priest:
      return [
        _buildRule(
          owner: owner,
          priority: 1,
          targetId: targetAllyHpBelow25Id,
          actionId: actionBigHealId,
        ),
        _buildRule(
          owner: owner,
          priority: 2,
          targetId: targetAllyHpBelow75Id,
          actionId: actionSmallHealId,
        ),
        _buildRule(
          owner: owner,
          priority: 3,
          targetId: targetLowestHpEnemyId,
          actionId: actionPhysicalAttackId,
        ),
      ];
    default:
      return [];
  }
}
