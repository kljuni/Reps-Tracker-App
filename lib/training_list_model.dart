import 'dart:collection';
import 'package:flutter/material.dart';
import 'data/models/training.dart';

class TrainingModel extends ChangeNotifier {
  TrainingModel(List<Training> trainingsList) {
    _trainings.addAll(trainingsList);
  }

  /// Internal, private state of the cart.
  final List<Training> _trainings = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Training> get allTrainings =>
      UnmodifiableListView(_trainings);

  void addTraining(Training training) {
    _trainings.add(training);
    notifyListeners();
  }

  void addSetsToExericse(int trainingId, int exerciseId, [int sets = 1]) {
    var training = _trainings.firstWhere((item) => item.id == trainingId);
    var exercise =
        training.exercises.firstWhere((item) => item.id == exerciseId);
    exercise.sets += sets;
    // ignore: todo
    // TODO, add error managament if id not found
    notifyListeners();
  }

  void removeSetFromExericse(int trainingId, int exerciseId) {
    var training = _trainings.firstWhere((item) => item.id == trainingId);
    var exercise =
        training.exercises.firstWhere((item) => item.id == exerciseId);
    exercise.sets -= 1;
    // ignore: todo
    // TODO, add error managament if id not found
    notifyListeners();
  }

  void addExercise(int trainingId, Exercise exercise) {
    var training = _trainings.firstWhere((item) => item.id == trainingId);
    training.exercises.add(exercise);
    // ignore: todo
    // TODO, add error managament if id not found
    notifyListeners();
  }
}
