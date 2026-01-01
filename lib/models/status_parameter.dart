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
  for (final parameter in statusParameters) {
    if (parameter.name == name) {
      return parameter;
    }
  }
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
  return StatusParameter.hp;
}
