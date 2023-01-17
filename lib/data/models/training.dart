class Training {
  // final int? id;
  final List<Exercise> exercises;
  final String name;
  final DateTime date;

  const Training({
    // this.id,
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

  // TODO, add toDataExportMap ??

  @override
  String toString() {
    return 'Training{name: $name, date: $date}';
  }

}

class Exercise {
  // final int id;
  final List<Set> sets;
  final String name;
  final String category;

  const Exercise({
    // required this.id,
    required this.sets,
    required this.name,
    required this.category,
  });
}

class Set {
  // final int id;
  final int reps;
  final double weight;

  const Set({
    // required this.id,
    required this.reps,
    required this.weight,
  });
}