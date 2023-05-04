import 'dart:math';

import 'package:collection/collection.dart';
import 'package:vermelha_app/models/character.dart';

import 'package:vermelha_app/models/vermelha_context.dart';
import 'package:vermelha_app/models/player_character.dart';

typedef GetTargets = List<Character> Function(VermelhaContext context);

enum TargetCategory {
  ally,
  enemy,
}

class Condition {
  final String uuid;
  final String name;
  final TargetCategory targetCategory;
  final GetTargets getTargets;

  Condition({
    required this.uuid,
    required this.name,
    required this.targetCategory,
    required this.getTargets,
  });
}

List<Condition> getConditionList() {
  return [
    Condition(
      uuid: '43ed09b5-7682-4c43-94d7-077c2b6dcaaa',
      name: '最もHPが低い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce(
            (value, element) => value.hp < element.hp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'c1e476b6-2aaf-4989-a6f3-ef8c441a3027',
      name: '最もHPが高い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce(
            (value, element) => value.hp > element.hp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '8faf13ec-3499-4a2e-bbbe-cddf6649c542',
      name: 'ランダムな敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target =
            context.enemies[Random().nextInt(context.enemies.length)];
        return [target];
      },
    ),
    Condition(
      uuid: '8fddad5a-6ba3-42ad-8edc-4190e524554f',
      name: 'ランダムな味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies[Random().nextInt(context.allies.length)];
        return [target];
      },
    ),
    Condition(
      uuid: 'a6c3360c-75f3-4ef9-bdf1-5c2b6859cc66',
      name: '敵全体',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        return context.enemies;
      },
    ),
    Condition(
      uuid: '664d9dfe-5f86-4ab7-9bcf-c884f16c814b',
      name: '味方全体',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        return context.allies;
      },
    ),
    Condition(
      uuid: 'efe1084b-206c-48cc-bf94-b298560c9f7f',
      name: 'HPが75%以下の味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        context.allies.sort((a, b) => a.hp.compareTo(b.hp));
        final target = context.allies
            .firstWhereOrNull((element) => element.hp <= element.maxHp * 0.75);
        return target == null ? [] : [target];
      },
    ),
    Condition(
      uuid: 'ad34f112-1941-4a41-bb3e-446e3e6a4b30',
      name: 'HPが50%以下の味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        context.allies.sort((a, b) => a.hp.compareTo(b.hp));
        final target = context.allies
            .firstWhereOrNull((element) => element.hp <= element.maxHp * 0.5);
        return target == null ? [] : [target];
      },
    ),
    Condition(
      uuid: '7d659ee0-02f3-4a51-84a4-54d34b9d2927',
      name: 'HPが25%以下の味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        context.allies.sort((a, b) => a.hp.compareTo(b.hp));
        final target = context.allies
            .firstWhereOrNull((element) => element.hp <= element.maxHp * 0.25);
        return target == null ? [] : [target];
      },
    ),
    Condition(
      uuid: 'e547b45d-0971-499d-bd1a-fabe49f173b4',
      name: '最もMPが低い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce(
            (value, element) => value.mp < element.mp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '8f49bcbb-98cb-4558-aeab-e53415a77ae6',
      name: '最もMPが高い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce(
            (value, element) => value.mp > element.mp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '6aebef67-12a5-4908-83d8-d66e0354c167',
      name: '最も攻撃力が低い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce((value, element) =>
            value.attack < element.attack ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '643d55bb-a4cf-440e-bf4c-438a7be858b9',
      name: '最も攻撃力が高い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce((value, element) =>
            value.attack > element.attack ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'fa8f705a-9fd4-4eb3-a7e3-017aed6d263f',
      name: '最も防御力が低い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce((value, element) =>
            value.defense < element.defense ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '5a861b68-8ba8-4d12-9507-4fb0fdf233dc',
      name: '最も防御力が高い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce((value, element) =>
            value.defense > element.defense ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'd4fd1d86-5328-4a73-8e4e-94b287bfb702',
      name: '最も素早さが低い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce(
            (value, element) => value.speed < element.speed ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'c4005bd2-6b67-4365-9885-1d5b02244b3f',
      name: '最も素早さが高い敵',
      targetCategory: TargetCategory.enemy,
      getTargets: (context) {
        final target = context.enemies.reduce(
            (value, element) => value.speed > element.speed ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'bae85139-a5be-4454-834f-33cc53237f31',
      name: '最もHPが低い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce(
            (value, element) => value.hp < element.hp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '2c69306b-a99f-458e-b167-6b1d3a20ec8e',
      name: '最もHPが高い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce(
            (value, element) => value.hp > element.hp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'd272d4fa-73b9-41cd-844e-6215ac07870e',
      name: '最もMPが低い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce(
            (value, element) => value.mp < element.mp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '1660ab10-5856-4332-b416-cf783469fed0',
      name: '最もMPが高い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce(
            (value, element) => value.mp > element.mp ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'cfebee94-2912-4308-94e3-40363d3e3520',
      name: '最も攻撃力が低い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce((value, element) =>
            value.attack < element.attack ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'e2633be7-e06f-4037-aec1-7267fac94ead',
      name: '最も攻撃力が高い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce((value, element) =>
            value.attack > element.attack ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'd576cea0-c1d2-4c6d-b619-ba7688e3f0df',
      name: '最も防御力が低い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce((value, element) =>
            value.defense < element.defense ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '4997e40d-d421-4c38-a932-7e614cea7a7f',
      name: '最も防御力が高い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce((value, element) =>
            value.defense > element.defense ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: 'cd7fa7f8-6810-43b3-9500-912176da75a9',
      name: '最も素早さが低い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce(
            (value, element) => value.speed < element.speed ? value : element);
        return [target];
      },
    ),
    Condition(
      uuid: '5c12a2a6-cd78-4169-b84f-9773851e3058',
      name: '最も素早さが高い味方',
      targetCategory: TargetCategory.ally,
      getTargets: (context) {
        final target = context.allies.reduce(
            (value, element) => value.speed > element.speed ? value : element);
        return [target];
      },
    ),
  ];
}

Condition getConditionByUuid(String uuid) {
  return getConditionList().firstWhere((element) => element.uuid == uuid);
}

List<Condition> getConditionListByCategory(TargetCategory category) {
  return getConditionList()
      .where((element) => element.targetCategory == category)
      .toList();
}
