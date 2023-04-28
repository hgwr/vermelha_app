class Job {
  final int id;
  final String name;
  final String description;

  const Job({
    required this.id,
    required this.name,
    required this.description,
  });
}

List<Job> getJobList() {
  return const [
    Job(id: 1, name: 'Warrior', description: 'A warrior.'),
    Job(id: 2, name: 'Paladin', description: 'A paladin.'),
    Job(id: 3, name: 'Ranger', description: 'A ranger.'),
    Job(id: 4, name: 'Mage', description: 'A mage.'),
    Job(id: 5, name: 'Shaman', description: 'A shaman.'),
    Job(id: 6, name: 'Priest', description: 'A priest.'),
  ];
}

Job getJob(int id) {
  return getJobList().firstWhere((job) => job.id == id);
}
