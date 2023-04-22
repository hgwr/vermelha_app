enum StatusParameter {
  hp(name: 'HP'),
  mp(name: 'MP'),
  attack(name: 'Attack'),
  defense(name: 'Defense'),
  magicPower(name: 'Magic Power'),
  speed(name: 'Speed');

  final String name;

  const StatusParameter({required this.name});
}
