import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/job.dart';
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

class Action {
  final String uuid;
  final List<Job> availableJobs;
  final String name;
  final int mpCost;
  final double baseDurationSeconds;
  final ComputeDuration computeDuration;
  final ApplyEffect applyEffect;

  const Action({
    required this.uuid,
    required this.availableJobs,
    required this.name,
    required this.mpCost,
    required this.baseDurationSeconds,
    required this.computeDuration,
    required this.applyEffect,
  });
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
      mpCost: 0,
      baseDurationSeconds: 10,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed;
      },
      applyEffect: (context, subject, targets) async {
        final target = targets.first;
        var damage = subject.attack - target.defense > 0
            ? subject.attack - target.defense
            : 0;
        damage += context.random.nextInt(10);
        target.hp -= damage;
        return true;
      },
    ),
    Action(
      uuid: 'd3ab3cd3-fb49-4e9d-a79f-4abd05bb58a2',
      availableJobs: [Job.priest],
      name: '大回復魔法',
      mpCost: 10,
      baseDurationSeconds: 30,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed;
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
      mpCost: 5,
      baseDurationSeconds: 10,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed;
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
      mpCost: 1,
      baseDurationSeconds: 100,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed;
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
      mpCost: 0,
      baseDurationSeconds: 50,
      computeDuration: (baseDurationSeconds, context, subject, targets) {
        return baseDurationSeconds / subject.speed;
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
