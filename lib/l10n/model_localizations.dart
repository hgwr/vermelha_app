import 'package:vermelha_app/l10n/app_localizations.dart';
import 'package:vermelha_app/models/action.dart';
import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/enemy.dart';
import 'package:vermelha_app/models/item.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/status_parameter.dart';
import 'package:vermelha_app/models/target.dart';

String jobLabel(AppLocalizations l10n, Job job) {
  switch (job) {
    case Job.fighter:
      return l10n.jobFighter;
    case Job.paladin:
      return l10n.jobPaladin;
    case Job.ranger:
      return l10n.jobRanger;
    case Job.wizard:
      return l10n.jobWizard;
    case Job.shaman:
      return l10n.jobShaman;
    case Job.priest:
      return l10n.jobPriest;
  }
}

String enemyLabel(AppLocalizations l10n, EnemyType type) {
  switch (type) {
    case EnemyType.regular:
      return l10n.enemyRegular;
    case EnemyType.irregular:
      return l10n.enemyIrregular;
  }
}

String enemyNameLabel(AppLocalizations l10n, String name) {
  final labels = <String, String>{
    'goblin': l10n.enemyNameGoblin,
    'skeleton': l10n.enemyNameSkeleton,
    'orc': l10n.enemyNameOrc,
    'slime': l10n.enemyNameSlime,
    'wisp': l10n.enemyNameWisp,
    'ghost': l10n.enemyNameGhost,
  };
  return labels[name] ?? name;
}

String characterLabel(AppLocalizations l10n, Character character) {
  if (character is Enemy) {
    if (character.name.isNotEmpty) {
      return enemyNameLabel(l10n, character.name);
    }
    return enemyLabel(l10n, character.type);
  }
  return character.name;
}

String actionLabel(AppLocalizations l10n, Action action) {
  return actionLabelByUuid(l10n, action.uuid);
}

String actionLabelByUuid(AppLocalizations l10n, String uuid) {
  switch (uuid) {
    case actionPhysicalAttackId:
      return l10n.actionPhysicalAttack;
    case actionAttackMagicId:
      return l10n.actionAttackMagic;
    case actionBigHealId:
      return l10n.actionBigHeal;
    case actionSmallHealId:
      return l10n.actionSmallHeal;
    case actionBigCureId:
      return l10n.actionBigCure;
    case actionSmallCureId:
      return l10n.actionSmallCure;
    case actionDefendId:
      return l10n.actionDefend;
    case actionUsePotionId:
      return l10n.actionUsePotion;
    case actionUseEtherId:
      return l10n.actionUseEther;
  }
  return l10n.unknownLabel;
}

String conditionLabel(AppLocalizations l10n, Condition condition) {
  return conditionLabelByUuid(l10n, condition.uuid);
}

String conditionLabelByUuid(AppLocalizations l10n, String uuid) {
  switch (uuid) {
    case conditionLowestHpEnemyId:
      return l10n.conditionLowestHpEnemy;
    case conditionHighestHpEnemyId:
      return l10n.conditionHighestHpEnemy;
    case conditionRandomEnemyId:
      return l10n.conditionRandomEnemy;
    case conditionRandomAllyId:
      return l10n.conditionRandomAlly;
    case conditionAllEnemiesId:
      return l10n.conditionAllEnemies;
    case conditionAllAlliesId:
      return l10n.conditionAllAllies;
    case conditionEnemyTelegraphId:
      return l10n.conditionEnemyTelegraph;
    case conditionEnemyIrregularExistsId:
      return l10n.conditionEnemyIrregularExists;
    case conditionEnemyRegularExistsId:
      return l10n.conditionEnemyRegularExists;
    case conditionAllyHpBelow75Id:
      return l10n.conditionAllyHpBelow75;
    case conditionAllyHpBelow50Id:
      return l10n.conditionAllyHpBelow50;
    case conditionAllyHpBelow25Id:
      return l10n.conditionAllyHpBelow25;
    case conditionLowestMpEnemyId:
      return l10n.conditionLowestMpEnemy;
    case conditionHighestMpEnemyId:
      return l10n.conditionHighestMpEnemy;
    case conditionLowestAttackEnemyId:
      return l10n.conditionLowestAttackEnemy;
    case conditionHighestAttackEnemyId:
      return l10n.conditionHighestAttackEnemy;
    case conditionLowestDefenseEnemyId:
      return l10n.conditionLowestDefenseEnemy;
    case conditionHighestDefenseEnemyId:
      return l10n.conditionHighestDefenseEnemy;
    case conditionLowestSpeedEnemyId:
      return l10n.conditionLowestSpeedEnemy;
    case conditionHighestSpeedEnemyId:
      return l10n.conditionHighestSpeedEnemy;
    case conditionLowestHpAllyId:
      return l10n.conditionLowestHpAlly;
    case conditionHighestHpAllyId:
      return l10n.conditionHighestHpAlly;
    case conditionLowestMpAllyId:
      return l10n.conditionLowestMpAlly;
    case conditionHighestMpAllyId:
      return l10n.conditionHighestMpAlly;
    case conditionLowestAttackAllyId:
      return l10n.conditionLowestAttackAlly;
    case conditionHighestAttackAllyId:
      return l10n.conditionHighestAttackAlly;
    case conditionLowestDefenseAllyId:
      return l10n.conditionLowestDefenseAlly;
    case conditionHighestDefenseAllyId:
      return l10n.conditionHighestDefenseAlly;
    case conditionLowestSpeedAllyId:
      return l10n.conditionLowestSpeedAlly;
    case conditionHighestSpeedAllyId:
      return l10n.conditionHighestSpeedAlly;
    case conditionAlwaysId:
      return l10n.conditionAlways;
  }
  return l10n.unknownLabel;
}

String targetLabel(AppLocalizations l10n, Target target) {
  return targetLabelByUuid(l10n, target.uuid);
}

String targetLabelByUuid(AppLocalizations l10n, String uuid) {
  switch (uuid) {
    case targetMatchingAllyId:
      return l10n.targetMatchingAlly;
    case targetMatchingEnemyId:
      return l10n.targetMatchingEnemy;
    case targetSelfId:
      return l10n.targetSelf;
    case targetAllyHpBelow75Id:
      return l10n.conditionAllyHpBelow75;
    case targetAllyHpBelow50Id:
      return l10n.conditionAllyHpBelow50;
    case targetAllyHpBelow25Id:
      return l10n.conditionAllyHpBelow25;
    case targetRandomAllyId:
      return l10n.targetRandomAlly;
    case targetRandomEnemyId:
      return l10n.targetRandomEnemy;
    case targetAllAlliesId:
      return l10n.targetAllAllies;
    case targetAllEnemiesId:
      return l10n.targetAllEnemies;
    case targetLowestHpAllyId:
      return l10n.targetLowestHpAlly;
    case targetLowestHpEnemyId:
      return l10n.targetLowestHpEnemy;
    case targetHighestHpAllyId:
      return l10n.targetHighestHpAlly;
    case targetHighestHpEnemyId:
      return l10n.targetHighestHpEnemy;
    case targetLowestMpAllyId:
      return l10n.targetLowestMpAlly;
    case targetLowestMpEnemyId:
      return l10n.targetLowestMpEnemy;
    case targetHighestMpAllyId:
      return l10n.targetHighestMpAlly;
    case targetHighestMpEnemyId:
      return l10n.targetHighestMpEnemy;
    case targetLowestAttackAllyId:
      return l10n.targetLowestAttackAlly;
    case targetLowestAttackEnemyId:
      return l10n.targetLowestAttackEnemy;
    case targetHighestAttackAllyId:
      return l10n.targetHighestAttackAlly;
    case targetHighestAttackEnemyId:
      return l10n.targetHighestAttackEnemy;
    case targetLowestDefenseAllyId:
      return l10n.targetLowestDefenseAlly;
    case targetLowestDefenseEnemyId:
      return l10n.targetLowestDefenseEnemy;
    case targetHighestDefenseAllyId:
      return l10n.targetHighestDefenseAlly;
    case targetHighestDefenseEnemyId:
      return l10n.targetHighestDefenseEnemy;
    case targetLowestSpeedAllyId:
      return l10n.targetLowestSpeedAlly;
    case targetLowestSpeedEnemyId:
      return l10n.targetLowestSpeedEnemy;
    case targetHighestSpeedAllyId:
      return l10n.targetHighestSpeedAlly;
    case targetHighestSpeedEnemyId:
      return l10n.targetHighestSpeedEnemy;
    case targetFirstEnemyId:
      return l10n.targetFirstEnemy;
    case targetAttackingEnemyId:
      return l10n.targetAttackingEnemy;
    case targetEnemyTelegraphId:
      return l10n.conditionEnemyTelegraph;
    case targetEnemyIrregularId:
      return l10n.conditionEnemyIrregularExists;
    case targetEnemyRegularId:
      return l10n.conditionEnemyRegularExists;
  }
  return l10n.unknownLabel;
}

String itemLabel(AppLocalizations l10n, Item item) {
  switch (item.id) {
    case 'weapon_short_sword':
      return l10n.itemWeaponShortSword;
    case 'weapon_battle_axe':
      return l10n.itemWeaponBattleAxe;
    case 'weapon_long_bow':
      return l10n.itemWeaponLongBow;
    case 'armor_leather':
      return l10n.itemArmorLeather;
    case 'armor_chain':
      return l10n.itemArmorChain;
    case 'consumable_potion':
      return l10n.itemConsumablePotion;
    case 'consumable_ether':
      return l10n.itemConsumableEther;
  }
  return item.name;
}

String statusParameterLabel(
  AppLocalizations l10n,
  StatusParameter parameter,
) {
  switch (parameter) {
    case StatusParameter.hp:
      return l10n.statusParameterHp;
    case StatusParameter.mp:
      return l10n.statusParameterMp;
    case StatusParameter.attack:
      return l10n.statusParameterAttack;
    case StatusParameter.defense:
      return l10n.statusParameterDefense;
    case StatusParameter.magicPower:
      return l10n.statusParameterMagicPower;
    case StatusParameter.speed:
      return l10n.statusParameterSpeed;
  }
}
