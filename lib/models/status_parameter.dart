enum StatusParameter {
  hp,
  mp,
  attack,
  defense,
  magicPower,
  speed;
}

const List<StatusParameter> statusParameters = StatusParameter.values;

StatusParameter getStatusParameterByName(String name) {
  final normalized = name.toLowerCase().replaceAll(' ', '');
  switch (normalized) {
    case 'hp':
      return StatusParameter.hp;
    case 'mp':
      return StatusParameter.mp;
    case 'attack':
      return StatusParameter.attack;
    case 'defense':
      return StatusParameter.defense;
    case 'magicpower':
      return StatusParameter.magicPower;
    case 'speed':
      return StatusParameter.speed;
  }
  throw ArgumentError('Unknown StatusParameter name: $name');
}
