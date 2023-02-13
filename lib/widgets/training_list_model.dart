import 'dart:collection';
import 'package:flutter/material.dart';
import '../data/database.dart';
import '../data/models/training.dart';

class TrainingModel extends ChangeNotifier {
  final List<Training> _trainings = [];

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

  void updateSetsToExericse(int trainingId, int exerciseId, int sets) async {
    try {
      var training = _trainings.firstWhere((item) => item.id == trainingId);
      var exercise =
          training.exercises.firstWhere((item) => item.id == exerciseId);
      final exerciseUpdate = Exercise(
          id: exerciseId,
          training_id: trainingId,
          name: exercise.name,
          category: exercise.category,
          sets: sets,
          reps: exercise.reps,
          weight: exercise.weight);
      final success = await DbManager().updateExercise(exerciseUpdate);
      if (success) {
        final index = training.exercises.indexWhere((item) => item.id == exerciseId);
        training.exercises.replaceRange(index, index +1, [exerciseUpdate]);
        notifyListeners();
      }
    } catch (e) {
      print("Error adding sets to exericse: $e");
    }
  }

  void updateRepsToExericse(int trainingId, int exerciseId, int reps) async {
    try {
      var training = _trainings.firstWhere((item) => item.id == trainingId);
      var exercise =
          training.exercises.firstWhere((item) => item.id == exerciseId);
      final exerciseUpdate = Exercise(
          id: exerciseId,
          training_id: trainingId,
          name: exercise.name,
          category: exercise.category,
          sets: exercise.sets,
          reps: reps,
          weight: exercise.weight);
      final success = await DbManager().updateExercise(exerciseUpdate);
      if (success) {
        training.exercises.removeWhere((item) => item.id == exerciseId);
        training.exercises.add(exerciseUpdate);
        notifyListeners();
      }
    } catch (e) {
      print("Error adding sets to exericse: $e");
    }
  }

  void updateWeightToExericse( int trainingId, int exerciseId, double weight) async {
    try {
      var training = _trainings.firstWhere((item) => item.id == trainingId);
      var exercise =
          training.exercises.firstWhere((item) => item.id == exerciseId);
      final exerciseUpdate = Exercise(
          id: exerciseId,
          training_id: trainingId,
          name: exercise.name,
          category: exercise.category,
          sets: exercise.sets,
          reps: exercise.reps,
          weight: weight);
      final success = await DbManager().updateExercise(exerciseUpdate);
      if (success) {
        training.exercises.removeWhere((item) => item.id == exerciseId);
        training.exercises.add(exerciseUpdate);
      }
    } catch (e) {
      print("Error adding sets to exericse: $e");
    }

    notifyListeners();
  }

  void addExercise(Exercise exercise) async {
    try {
      final createdExercise = await DbManager().createNewExercise(exercise);
      var training =
          _trainings.firstWhere((item) => item.id == exercise.training_id);
      training.exercises.add(createdExercise);
      notifyListeners();
    } catch (e) {
      print("Error adding exercise: $e");
    }
  }

  void deleteExercise(Exercise exercise) async {
    try {
      final success = await DbManager().deleteExercise(exercise);
      if (success) {
        var training =
            _trainings.firstWhere((item) => item.id == exercise.training_id);
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
