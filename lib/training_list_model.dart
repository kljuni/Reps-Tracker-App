import 'dart:collection';
import 'package:flutter/material.dart';
import 'data/database.dart';
import 'data/models/training.dart';

class TrainingModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  final List<Training> _trainings = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Training> get allTrainings =>
      UnmodifiableListView(_trainings);

  Training getTrainingById(int id) {
    return _trainings.firstWhere((item) => item.id == id);
  }

  void addAllTrainings(List<Training> trainings) {
    _trainings.clear();
    _trainings.addAll(trainings);
    _trainings.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void addOneTraining(Training training) {
    _trainings.add(training);
    _trainings.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void updateTraining(Training training) {
    final index = _trainings.indexWhere((item) => item.id == training.id);
    _trainings.replaceRange(index, index + 1, [training]);
    _trainings.sort((a, b) => b.date.compareTo(a.date));
    notifyListeners();
  }

  void deleteTraining(Training training) async {
    try {
      final success = await DbManager().deleteTraining(training);

      if (success) {
        _trainings.removeWhere((item) => item.id == training.id);
        notifyListeners();
      } else {
        throw Exception("Could not delete training");
      }
    } catch (e) {
      print("Error adding sets to exericse: $e");
    }
  }

  void addSetToExericse(int trainingId, int exerciseId, [int sets = 1]) async {
    try {
      var training = _trainings.firstWhere((item) => item.id == trainingId);
      var exercise =
          training.exercises.firstWhere((item) => item.id == exerciseId);
      exercise.sets += sets;
      await DbManager().updateExercise(exercise);
    } catch (e) {
      print("Error adding sets to exericse: $e");
    }

    notifyListeners();
  }

  void updateSetsToExericse(int trainingId, int exerciseId, int sets) async {
    try {
      var training = _trainings.firstWhere((item) => item.id == trainingId);
      var exercise =
          training.exercises.firstWhere((item) => item.id == exerciseId);
      exercise.sets = sets;
      await DbManager().updateExercise(exercise);
    } catch (e) {
      print("Error adding sets to exericse: $e");
    }

    notifyListeners();
  }

  void updateRepsToExericse(int trainingId, int exerciseId, int reps) async {
    try {
      var training = _trainings.firstWhere((item) => item.id == trainingId);
      var exercise =
          training.exercises.firstWhere((item) => item.id == exerciseId);
      exercise.reps = reps;
      await DbManager().updateExercise(exercise);
    } catch (e) {
      print("Error adding reps to exericse: $e");
    }

    notifyListeners();
  }

  void updateWeightToExericse(
      int trainingId, int exerciseId, double weight) async {
    try {
      var training = _trainings.firstWhere((item) => item.id == trainingId);
      var exercise =
          training.exercises.firstWhere((item) => item.id == exerciseId);
      exercise.weight = weight;
      await DbManager().updateExercise(exercise);
    } catch (e) {
      print("Error adding reps to exercise: $e");
    }

    notifyListeners();
  }

  void addExercise(Exercise exercise) async {
    try {
      final success = await DbManager().createNewExercise(exercise);
      if (success) {
        var training = _trainings.firstWhere((item) => item.id == exercise.training_id);
        training.exercises.add(exercise);
        notifyListeners();
      } else {
        throw Exception("Could not add exercise");
      }
      
    } catch (e) {
      print("Error adding exercise: $e");
    }
  }

  void deleteExercise(Exercise exercise) async {
    try {
      final success = await DbManager().deleteExercise(exercise);
      if (success) {
        var training = _trainings.firstWhere((item) => item.id == exercise.training_id);
        training.exercises.removeWhere((item) => item.id == exercise.id);
        notifyListeners();
      } else {
        throw Exception("Could not delete exercise");
      }
      
    } catch (e) {
      print("Error deleting exercise: $e");
    }
  }
}
