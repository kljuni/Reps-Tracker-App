class Training {
  final int id;
  final List<Exercise> exercises;
  final String name;
  final DateTime date;

  Training({
    required this.id,
    required this.exercises,
    required this.name,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'date': date,
    };
  }

  @override
  String toString() {
    return 'Training{name: $name, date: $date}';
  }
}


class Exercise {
  final int id;
  String name;
  final String category;
  int sets;
  int reps;
  double weight;

  Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.sets,
    required this.reps,
    required this.weight,
  });
}
