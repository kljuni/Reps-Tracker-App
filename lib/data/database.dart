import 'dart:async';
import 'dart:io' as io;
import 'dart:io';
import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'models/training.dart';
import 'dart:async' show Future;
import 'package:flutter/services.dart' show rootBundle;

class DbManager {
  static final DbManager _instance = DbManager._internal();
  factory DbManager() => _instance;
  static Database? _db;

  DbManager._internal();

  Future<Database> get db async {
    _db ??= await init();
    return _db!;
  }

  Future<Database> init() async {
    var databasesPath = await getDatabasesPath();
    var path = join(databasesPath, "database.db");
    print("path");
    print("here we are");

    // Check if the database exists
    var exists = await databaseExists(path);

    if (!exists) {
      // Should happen only the first time you launch your application
      print("Creating new copy from asset");

      // Make sure the parent directory exists
      try {
        await Directory(dirname(path)).create(recursive: true);
      } catch (_) {}

      // Copy from asset
      ByteData data = await rootBundle.load(join("assets", "training.db"));
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);

      // Write and flush the bytes written
      await File(path).writeAsBytes(bytes, flush: true);
    } else {
      print("Opening existing database");
    }
    // open the database
    return await openDatabase(path, version: 1, onCreate: onCreate);
  }

  void onCreate(Database db, int version) async {
    String allQueries = await rootBundle.loadString('assets/sql/init_db.sql');

    List<String> queries = allQueries.split(';');

    for (String query in queries) {
      if (query.trim().isNotEmpty) {
        await db.execute(query);
      }
    }
  }

  Future<Training> createNewTraining(Training training) async {
    final trainingId = await (await db).insert("training", training.toMap());
    for (var exercise in training.exercises) {
      (await db).insert("exercise", exercise.toMap(trainingId));
    }
    final List<Map<String, dynamic>> insertedTraining = await (await db)
        .query("training", where: "id = ?", whereArgs: [trainingId]);
    return Training(
        id: insertedTraining[0]['id'],
        exercises: [],
        name: insertedTraining[0]['name'],
        date: DateTime.fromMillisecondsSinceEpoch(
            insertedTraining[0]['date'] as int));
  }

  Future<List<Training>> getTrainings() async {
    final database = await db;

    final List<Map<String, dynamic>> trainingMaps =
        await database.query('training');

    final trainings = Future.wait(List.generate(trainingMaps.length, (i) async {
      final int trainingId = trainingMaps[i]['id'];
      final List<Map<String, dynamic>> exerciseMaps = await database
          .query('exercise', where: 'training_id = ?', whereArgs: [trainingId]);

      final List<Exercise> exercises = List.generate(exerciseMaps.length, (j) {
        return Exercise(
            id: exerciseMaps[j]['id'],
            training_id: exerciseMaps[j]['training_id'],
            name: exerciseMaps[j]['name'],
            weight: exerciseMaps[j]['weight'],
            sets: exerciseMaps[j]['sets'],
            reps: exerciseMaps[j]['reps'],
            category: exerciseMaps[j]['category']);
      });

      return Training(
          id: trainingMaps[i]['id'],
          exercises: exercises,
          name: trainingMaps[i]['name'],
          date: DateTime.fromMillisecondsSinceEpoch(
              trainingMaps[i]['date'] as int));
    }));

    return trainings;
  }

  Future<int> createNewExercise(int trainingId, Exercise exercise) async {
    return (await db).insert("exercise", exercise.toMap(trainingId));
  }

  Future<void> updateTraining(Training training) async {
    (await db).update(
      'training',
      training.toMap(),
      where: "id = ?",
      whereArgs: [training.id],
    );
  }
  
  Future<void> updateExercise(Exercise exercise) async {
    (await db).update(
      'exercise',
      exercise.toMapWithoutTrainingId(),
      where: "id = ?",
      whereArgs: [exercise.id],
    );
  }
}
