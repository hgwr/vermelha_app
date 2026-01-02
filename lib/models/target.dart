import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/enemy.dart';
import 'package:vermelha_app/models/vermelha_context.dart';

typedef SelectTargets = List<Character> Function(
  VermelhaContext context,
  Character subject,
  List<Character> candidates,
);

const String targetMatchingAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b001';
const String targetMatchingEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b002';
const String targetSelfId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b003';
const String targetRandomAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b004';
const String targetRandomEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b005';
const String targetAllAlliesId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b006';
const String targetAllEnemiesId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b007';
const String targetLowestHpAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b008';
const String targetLowestHpEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b009';
const String targetHighestHpAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b010';
const String targetHighestHpEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b011';
const String targetLowestMpAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b012';
const String targetLowestMpEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b013';
const String targetHighestMpAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b014';
const String targetHighestMpEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b015';
const String targetLowestAttackAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b016';
const String targetLowestAttackEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b017';
const String targetHighestAttackAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b018';
const String targetHighestAttackEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b019';
const String targetLowestDefenseAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b020';
const String targetLowestDefenseEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b021';
const String targetHighestDefenseAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b022';
const String targetHighestDefenseEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b023';
const String targetLowestSpeedAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b024';
const String targetLowestSpeedEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b025';
const String targetHighestSpeedAllyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b026';
const String targetHighestSpeedEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b027';
const String targetFirstEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b028';
const String targetAttackingEnemyId = '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b029';
const String targetAllyHpBelow75Id = '43bdcfaa-3edf-4f46-89f8-434796afb930';
const String targetAllyHpBelow50Id = '6b8a75d8-7324-41b1-95ed-dfe00023f9c4';
const String targetAllyHpBelow25Id = '786f45ea-6221-4be7-8525-b8d74a1eaeef';
const String targetEnemyTelegraphId = 'de920639-8e2e-44ef-b133-d92d00dc1a58';
const String targetEnemyIrregularId = '03c67f83-f717-4fdf-83bf-d86fc5e85782';
const String targetEnemyRegularId = '3a202f71-e259-44d0-974c-b93ab0559fa6';

const Set<String> _legacyTargetIds = {
  targetMatchingAllyId,
  targetMatchingEnemyId,
};

class Target {
  final String uuid;
  final String name;
  final TargetCategory targetCategory;
  final SelectTargets selectTargets;

  Target({
    required this.uuid,
    required this.name,
    required this.targetCategory,
    required this.selectTargets,
  });
}

List<Character> _selectSingle(
  List<Character> candidates,
  bool Function(Character a, Character b) comparator,
) {
  if (candidates.isEmpty) {
    return [];
  }
  final target = candidates.reduce((a, b) => comparator(a, b) ? a : b);
  return [target];
}

List<Character> _selectRandom(
  VermelhaContext context,
  List<Character> candidates,
) {
  if (candidates.isEmpty) {
    return [];
  }
  final target = candidates[context.random.nextInt(candidates.length)];
  return [target];
}

List<Character> _selectFirstByHpThreshold(
  List<Character> candidates,
  double threshold,
) {
  if (candidates.isEmpty) {
    return [];
  }
  candidates.sort((a, b) => a.hp.compareTo(b.hp));
  for (final candidate in candidates) {
    if (candidate.hp <= candidate.maxHp * threshold) {
      return [candidate];
    }
  }
  return [];
}

List<Target> getTargetList() {
  return [
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b001',
      name: '条件に合う味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) => candidates,
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b002',
      name: '条件に合う敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) => candidates,
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b003',
      name: '自分自身',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, subject, candidates) {
        if (candidates.any((c) => c.id == subject.id)) {
          return [subject];
        }
        return [];
      },
    ),
    Target(
      uuid: targetAllyHpBelow75Id,
      name: 'HPが75%以下の味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectFirstByHpThreshold(candidates, 0.75),
    ),
    Target(
      uuid: targetAllyHpBelow50Id,
      name: 'HPが50%以下の味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectFirstByHpThreshold(candidates, 0.5),
    ),
    Target(
      uuid: targetAllyHpBelow25Id,
      name: 'HPが25%以下の味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectFirstByHpThreshold(candidates, 0.25),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b004',
      name: 'ランダムな味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (context, _, candidates) =>
          _selectRandom(context, candidates),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b005',
      name: 'ランダムな敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (context, _, candidates) =>
          _selectRandom(context, candidates),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b006',
      name: '味方全体',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) => candidates,
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b007',
      name: '敵全体',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) => candidates,
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b008',
      name: 'HPが最も低い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.hp < b.hp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b009',
      name: 'HPが最も低い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.hp < b.hp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b010',
      name: 'HPが最も高い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.hp > b.hp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b011',
      name: 'HPが最も高い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.hp > b.hp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b012',
      name: 'MPが最も低い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.mp < b.mp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b013',
      name: 'MPが最も低い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.mp < b.mp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b014',
      name: 'MPが最も高い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.mp > b.mp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b015',
      name: 'MPが最も高い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.mp > b.mp),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b016',
      name: '最も攻撃力が低い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.attack < b.attack),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b017',
      name: '最も攻撃力が低い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.attack < b.attack),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b018',
      name: '最も攻撃力が高い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.attack > b.attack),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b019',
      name: '最も攻撃力が高い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.attack > b.attack),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b020',
      name: '最も防御力が低い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.defense < b.defense),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b021',
      name: '最も防御力が低い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.defense < b.defense),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b022',
      name: '最も防御力が高い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.defense > b.defense),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b023',
      name: '最も防御力が高い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.defense > b.defense),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b024',
      name: '最も素早さが低い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.speed < b.speed),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b025',
      name: '最も素早さが低い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.speed < b.speed),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b026',
      name: '最も素早さが高い味方',
      targetCategory: TargetCategory.ally,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.speed > b.speed),
    ),
    Target(
      uuid: '2f9b7ad3-1a0f-4d75-9a9b-8d87d1f7b027',
      name: '最も素早さが高い敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) =>
          _selectSingle(candidates, (a, b) => a.speed > b.speed),
    ),
    Target(
      uuid: targetFirstEnemyId,
      name: '先頭の敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) {
        if (candidates.isEmpty) {
          return [];
        }
        return [candidates.first];
      },
    ),
    Target(
      uuid: targetAttackingEnemyId,
      name: '自分を攻撃している敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (context, subject, candidates) {
        final attacker = context.lastAttackers[subject];
        if (attacker == null || attacker is! Enemy) {
          return [];
        }
        if (candidates.any((candidate) => candidate == attacker)) {
          return [attacker];
        }
        return [];
      },
    ),
    Target(
      uuid: targetEnemyTelegraphId,
      name: '攻撃予兆の敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) {
        return candidates
            .where(
              (candidate) =>
                  candidate is Enemy && candidate.isTelegraphing,
            )
            .toList();
      },
    ),
    Target(
      uuid: targetEnemyIrregularId,
      name: '非定型の敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) {
        return candidates
            .where(
              (candidate) =>
                  candidate is Enemy && candidate.type == EnemyType.irregular,
            )
            .toList();
      },
    ),
    Target(
      uuid: targetEnemyRegularId,
      name: '定型の敵',
      targetCategory: TargetCategory.enemy,
      selectTargets: (_, __, candidates) {
        return candidates
            .where(
              (candidate) =>
                  candidate is Enemy && candidate.type == EnemyType.regular,
            )
            .toList();
      },
    ),
  ];
}

Target getTargetByUuid(
  String uuid, {
  TargetCategory? fallbackCategory,
}) {
  for (final target in getTargetList()) {
    if (target.uuid == uuid) {
      return target;
    }
  }
  if (fallbackCategory != null) {
    return getTargetListByCategory(fallbackCategory).first;
  }
  return getSelectableTargetList().first;
}

List<Target> getTargetListByCategory(TargetCategory category) {
  if (category == TargetCategory.any) {
    return getTargetList();
  }
  return getTargetList()
      .where((target) => target.targetCategory == category)
      .toList();
}

List<Target> getSelectableTargetList() {
  return getTargetList()
      .where((target) => !_legacyTargetIds.contains(target.uuid))
      .toList();
}

Target? mapConditionUuidToTarget(String? conditionUuid) {
  switch (conditionUuid) {
    case conditionLowestHpEnemyId:
      return getTargetByUuid(targetLowestHpEnemyId);
    case conditionHighestHpEnemyId:
      return getTargetByUuid(targetHighestHpEnemyId);
    case conditionRandomEnemyId:
      return getTargetByUuid(targetRandomEnemyId);
    case conditionRandomAllyId:
      return getTargetByUuid(targetRandomAllyId);
    case conditionAllEnemiesId:
      return getTargetByUuid(targetAllEnemiesId);
    case conditionAllAlliesId:
      return getTargetByUuid(targetAllAlliesId);
    case conditionEnemyTelegraphId:
      return getTargetByUuid(targetEnemyTelegraphId);
    case conditionEnemyIrregularExistsId:
      return getTargetByUuid(targetEnemyIrregularId);
    case conditionEnemyRegularExistsId:
      return getTargetByUuid(targetEnemyRegularId);
    case conditionAllyHpBelow75Id:
      return getTargetByUuid(targetAllyHpBelow75Id);
    case conditionAllyHpBelow50Id:
      return getTargetByUuid(targetAllyHpBelow50Id);
    case conditionAllyHpBelow25Id:
      return getTargetByUuid(targetAllyHpBelow25Id);
    case conditionLowestMpEnemyId:
      return getTargetByUuid(targetLowestMpEnemyId);
    case conditionHighestMpEnemyId:
      return getTargetByUuid(targetHighestMpEnemyId);
    case conditionLowestAttackEnemyId:
      return getTargetByUuid(targetLowestAttackEnemyId);
    case conditionHighestAttackEnemyId:
      return getTargetByUuid(targetHighestAttackEnemyId);
    case conditionLowestDefenseEnemyId:
      return getTargetByUuid(targetLowestDefenseEnemyId);
    case conditionHighestDefenseEnemyId:
      return getTargetByUuid(targetHighestDefenseEnemyId);
    case conditionLowestSpeedEnemyId:
      return getTargetByUuid(targetLowestSpeedEnemyId);
    case conditionHighestSpeedEnemyId:
      return getTargetByUuid(targetHighestSpeedEnemyId);
    case conditionLowestHpAllyId:
      return getTargetByUuid(targetLowestHpAllyId);
    case conditionHighestHpAllyId:
      return getTargetByUuid(targetHighestHpAllyId);
    case conditionLowestMpAllyId:
      return getTargetByUuid(targetLowestMpAllyId);
    case conditionHighestMpAllyId:
      return getTargetByUuid(targetHighestMpAllyId);
    case conditionLowestAttackAllyId:
      return getTargetByUuid(targetLowestAttackAllyId);
    case conditionHighestAttackAllyId:
      return getTargetByUuid(targetHighestAttackAllyId);
    case conditionLowestDefenseAllyId:
      return getTargetByUuid(targetLowestDefenseAllyId);
    case conditionHighestDefenseAllyId:
      return getTargetByUuid(targetHighestDefenseAllyId);
    case conditionLowestSpeedAllyId:
      return getTargetByUuid(targetLowestSpeedAllyId);
    case conditionHighestSpeedAllyId:
      return getTargetByUuid(targetHighestSpeedAllyId);
  }
  return null;
}

Target targetFromLegacyRule({
  String? targetUuid,
  String? conditionUuid,
}) {
  if (targetUuid != null && targetUuid.isNotEmpty) {
    if (targetUuid == targetMatchingAllyId) {
      final mapped = mapConditionUuidToTarget(conditionUuid);
      return mapped ?? getTargetByUuid(targetAllAlliesId);
    }
    if (targetUuid == targetMatchingEnemyId) {
      final mapped = mapConditionUuidToTarget(conditionUuid);
      return mapped ?? getTargetByUuid(targetAllEnemiesId);
    }
    return getTargetByUuid(targetUuid);
  }
  final mapped = mapConditionUuidToTarget(conditionUuid);
  if (mapped != null) {
    return mapped;
  }
  return getSelectableTargetList().first;
}
