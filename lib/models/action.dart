import 'package:vermelha_app/models/character.dart';
import 'package:vermelha_app/models/job.dart';
import 'package:vermelha_app/models/vermelha_context.dart';

abstract class Action {
  final int id;
  final Job availableJob;
  final String name;
  final int power;
  final int accuracy;
  final int mpCost;
  final int damage;
  final int heal;
  final int duration;

  const Action({
    required this.id,
    required this.availableJob,
    required this.name,
    required this.power,
    required this.accuracy,
    required this.mpCost,
    required this.damage,
    required this.heal,
    required this.duration,
  });

  void applyEffect(VermelhaContext context, Character subject);
}
