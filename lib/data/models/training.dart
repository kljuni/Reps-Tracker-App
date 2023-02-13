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
      "name": name,
      "date": date.millisecondsSinceEpoch,
    };
  }
}

class Exercise {
  final int id;
  final int training_id;
  final String name;
  final String category;
  final int sets;
  final int reps;
  final double weight;

  Exercise({
    required this.id,
    required this.training_id,
    required this.name,
    required this.category,
    required this.sets,
    required this.reps,
    required this.weight,
  });

  Map<String, dynamic> toMap(int training_id) {
    return {
      'training_id': training_id,
      'name': name,
      'category': category,
      'sets': sets,
      'reps': reps,
      'weight': weight,
    };
  }

  Map<String, dynamic> toMapWithoutTrainingId() {
    return {
      'name': name,
      'category': category,
      'sets': sets,
      'reps': reps,
      'weight': weight,
    };
  }
}
