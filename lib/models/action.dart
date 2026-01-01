import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/enemy.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/player_character.dart';
import 'package:vermelha_app/models/vermelha_context.dart';

typedef ApplyEffect = Future<bool> Function(
  VermelhaContext context,
  Character subject,
  List<Character> targets,
);
typedef ComputeDuration = double Function(
  double baseDurationSeconds,
  VermelhaContext context,
  Character subject,
  List<Character> targets,
);

enum AttackType {
  none,
  weapon,
  bow,
  magic,
}

class Action {
  final String uuid;
  final List<Job> availableJobs;
  final String name;
  final AttackType attackType;
  final int mpCost;
  final double baseDurationSeconds;
  final ComputeDuration computeDuration;
  final ApplyEffect applyEffect;

  const Action({
    required this.uuid,
    required this.availableJobs,
    required this.name,
    required this.attackType,
    required this.mpCost,
    required this.baseDurationSeconds,
    required this.computeDuration,
    required this.applyEffect,
  });
}

AttackType _effectiveAttackType(AttackType attackType, Character subject) {
  if (attackType != AttackType.weapon) {
    return attackType;
  }
  if (subject is PlayerCharacter && subject.job == Job.ranger) {
    return AttackType.bow;
  }
  return attackType;
}

double _enemyDamageMultiplier(AttackType attackType, EnemyType enemyType) {
  switch (attackType) {
    case AttackType.weapon:
      return enemyType == EnemyType.regular ? 1.0 : 0.5;
    case AttackType.bow:
      return enemyType == EnemyType.regular ? 0.66 : 1.0;
    case AttackType.magic:
      return enemyType == EnemyType.regular ? 0.5 : 1.5;
    case AttackType.none:
      return 1.0;
  }
}

double _damageMultiplier(
  AttackType attackType,
  Character subject,
  Character target,
) {
  final effective = _effectiveAttackType(attackType, subject);
  if (target is Enemy) {
    return _enemyDamageMultiplier(effective, target.type);
  }
  return 1.0;
}

List<Action> getActionList() {
  return [
    Action(
      uuid: 'f2068e01-90d3-4390-bbc5-252cb32ddb65',
      availableJobs: [
        Job.fighter,
        Job.paladin,
        Job.ranger,
        Job.wizard,
        Job.shaman,
        Job.priest
      ],
      name: '物理攻撃',
      attackType: AttackType.weapon,
      mpCost: 0,
      baseDurationSeconds: 10,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        final target = targets.first;
        var damage = subject.attack - target.defense > 0
            ? subject.attack - target.defense
            : 0;
        damage += context.random.nextInt(10);
        final multiplier =
            _damageMultiplier(AttackType.weapon, subject, target);
        if (subject is Enemy && subject.isTelegraphing) {
          subject.isTelegraphing = false;
          damage = (damage * 1.5).round();
        }
        damage = (damage * multiplier).round();
        target.hp -= damage;
        return true;
      },
    ),
    Action(
      uuid: 'd66c1d0a-5d6d-4b36-8e68-9bfe144d4d44',
      availableJobs: [Job.wizard, Job.shaman],
      name: '攻撃魔法',
      attackType: AttackType.magic,
      mpCost: 8,
      baseDurationSeconds: 20,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        final target = targets.first;
        var damage = subject.magicPower - target.defense > 0
            ? subject.magicPower - target.defense
            : 0;
        damage += context.random.nextInt(10);
        final multiplier = _damageMultiplier(AttackType.magic, subject, target);
        if (subject is Enemy && subject.isTelegraphing) {
          subject.isTelegraphing = false;
          damage = (damage * 1.5).round();
        }
        damage = (damage * multiplier).round();
        target.hp -= damage;
        return true;
      },
    ),
    Action(
      uuid: 'd3ab3cd3-fb49-4e9d-a79f-4abd05bb58a2',
      availableJobs: [Job.priest],
      name: '大回復魔法',
      attackType: AttackType.none,
      mpCost: 10,
      baseDurationSeconds: 30,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        final target = targets.first;
        target.hp = target.maxHp;
        return true;
      },
    ),
    Action(
      uuid: '5647560a-ed11-4efb-be7a-4dce903927fd',
      availableJobs: [Job.priest],
      name: '小回復魔法',
      attackType: AttackType.none,
      mpCost: 5,
      baseDurationSeconds: 10,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        final target = targets.first;
        target.hp += 10;
        return true;
      },
    ),
    Action(
      uuid: 'be91d004-7c49-4382-9f94-2fa94da4a10d',
      availableJobs: [Job.shaman],
      name: '大治癒術',
      attackType: AttackType.none,
      mpCost: 1,
      baseDurationSeconds: 100,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        final target = targets.first;
        target.hp = target.maxHp;
        return true;
      },
    ),
    Action(
      uuid: '66adfc55-f97f-4ecb-abbe-aacb4b3bcaa5',
      availableJobs: [Job.shaman],
      name: '小治癒術',
      attackType: AttackType.none,
      mpCost: 0,
      baseDurationSeconds: 50,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        final target = targets.first;
        target.hp += 10;
        return true;
      },
    )
  ];
}

Action getActionByUuid(String uuid) {
  return getActionList().firstWhere((action) => action.uuid == uuid);
}
