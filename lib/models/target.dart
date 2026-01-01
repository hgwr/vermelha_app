import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
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
  return getTargetList().first;
}

List<Target> getTargetListByCategory(TargetCategory category) {
  return getTargetList()
      .where((target) => target.targetCategory == category)
      .toList();
}
