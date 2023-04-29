enum Job {
  fighter(id: 1, name: '戦士'),
  paladin(id: 2, name: '神殿騎士'),
  ranger(id: 3, name: 'レンジャー'),
  wizard(id: 4, name: '魔法使い'),
  shaman(id: 5, name: 'シャーマン'),
  priest(id: 6, name: '僧侶');

  final int id;
  final String name;

  const Job({
    required this.id,
    required this.name,
  });
}
