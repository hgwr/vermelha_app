
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

const String actionPhysicalAttackId = 'f2068e01-90d3-4390-bbc5-252cb32ddb65';
const String actionAttackMagicId = 'd66c1d0a-5d6d-4b36-8e68-9bfe144d4d44';
const String actionBigHealId = 'd3ab3cd3-fb49-4e9d-a79f-4abd05bb58a2';
const String actionSmallHealId = '5647560a-ed11-4efb-be7a-4dce903927fd';
const String actionBigCureId = 'be91d004-7c49-4382-9f94-2fa94da4a10d';
const String actionSmallCureId = '66adfc55-f97f-4ecb-abbe-aacb4b3bcaa5';
const String actionDefendId = '7d3b8b26-0c10-4b6c-9ad3-5b6b1a9db861';
const String actionUsePotionId = 'f3fd6a9f-7e6c-4b52-b3d6-5c2e57c0d3a4';
const String actionUseEtherId = 'a83f6f60-99b6-4d5d-8b4e-93fa25f6f1c5';
const int _smallHealAmount = 10;

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

int _applyDefending(
  VermelhaContext context,
  Character target,
  int damage,
) {
  if (context.defending.contains(target)) {
    context.defending.remove(target);
    return (damage * 0.5).round();
  }
  return damage;
}

List<Action> getActionList() {
  return [
    Action(
      uuid: actionPhysicalAttackId,
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
        final isTelegraphing = subject is Enemy && subject.isTelegraphing;
        if (subject is Enemy && subject.isTelegraphing) {
          subject.isTelegraphing = false;
        }
        for (final target in targets) {
          var damage = subject.attack - target.defense > 0
              ? subject.attack - target.defense
              : 0;
          damage += context.random.nextInt(10);
          final multiplier =
              _damageMultiplier(AttackType.weapon, subject, target);
          if (isTelegraphing) {
            damage = (damage * 1.5).round();
          }
          damage = (damage * multiplier).round();
          damage = _applyDefending(context, target, damage);
          target.hp -= damage;
        }
        return true;
      },
    ),
    Action(
      uuid: actionAttackMagicId,
      availableJobs: [Job.wizard, Job.shaman],
      name: '攻撃魔法',
      attackType: AttackType.magic,
      mpCost: 8,
      baseDurationSeconds: 20,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        final isTelegraphing = subject is Enemy && subject.isTelegraphing;
        if (subject is Enemy && subject.isTelegraphing) {
          subject.isTelegraphing = false;
        }
        for (final target in targets) {
          var damage = subject.magicPower - target.defense > 0
              ? subject.magicPower - target.defense
              : 0;
          damage += context.random.nextInt(10);
          final multiplier =
              _damageMultiplier(AttackType.magic, subject, target);
          if (isTelegraphing) {
            damage = (damage * 1.5).round();
          }
          damage = (damage * multiplier).round();
          damage = _applyDefending(context, target, damage);
          target.hp -= damage;
        }
        return true;
      },
    ),
    Action(
      uuid: actionBigHealId,
      availableJobs: [Job.priest],
      name: '大回復魔法',
      attackType: AttackType.none,
      mpCost: 10,
      baseDurationSeconds: 30,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        for (final target in targets) {
          target.hp = target.maxHp;
        }
        return true;
      },
    ),
    Action(
      uuid: actionSmallHealId,
      availableJobs: [Job.priest],
      name: '小回復魔法',
      attackType: AttackType.none,
      mpCost: 5,
      baseDurationSeconds: 10,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        for (final target in targets) {
          target.hp =
              (target.hp + _smallHealAmount).clamp(0, target.maxHp).toInt();
        }
        return true;
      },
    ),
    Action(
      uuid: actionBigCureId,
      availableJobs: [Job.shaman],
      name: '大治癒術',
      attackType: AttackType.none,
      mpCost: 1,
      baseDurationSeconds: 100,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        for (final target in targets) {
          target.hp = target.maxHp;
        }
        return true;
      },
    ),
    Action(
      uuid: actionSmallCureId,
      availableJobs: [Job.shaman],
      name: '小治癒術',
      attackType: AttackType.none,
      mpCost: 0,
      baseDurationSeconds: 50,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        for (final target in targets) {
          target.hp =
              (target.hp + _smallHealAmount).clamp(0, target.maxHp).toInt();
        }
        return true;
      },
    ),
    Action(
      uuid: actionDefendId,
      availableJobs: [
        Job.fighter,
        Job.paladin,
        Job.ranger,
        Job.wizard,
        Job.shaman,
        Job.priest
      ],
      name: '防御',
      attackType: AttackType.none,
      mpCost: 0,
      baseDurationSeconds: 6,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        for (final target in targets) {
          context.defending.add(target);
        }
        return true;
      },
    ),
    Action(
      uuid: actionUsePotionId,
      availableJobs: [
        Job.fighter,
        Job.paladin,
        Job.ranger,
        Job.wizard,
        Job.shaman,
        Job.priest
      ],
      name: '回復薬を使う',
      attackType: AttackType.none,
      mpCost: 0,
      baseDurationSeconds: 10,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        return true;
      },
    ),
    Action(
      uuid: actionUseEtherId,
      availableJobs: [
        Job.fighter,
        Job.paladin,
        Job.ranger,
        Job.wizard,
        Job.shaman,
        Job.priest
      ],
      name: '魔力水を使う',
      attackType: AttackType.none,
      mpCost: 0,
      baseDurationSeconds: 10,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed.toDouble();
      },
      applyEffect: (context, subject, targets) async {
        return true;
      },
    ),
  ];
}

Action getActionByUuid(String uuid) {
  return getActionList().firstWhere((action) => action.uuid == uuid);
}
