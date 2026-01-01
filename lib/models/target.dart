import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/condition.dart';
import 'package:vermelha_app/models/vermelha_context.dart';

typedef SelectTargets = List<Character> Function(
  VermelhaContext context,
  Character subject,
  List<Character> candidates,
);

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
