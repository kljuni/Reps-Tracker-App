import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

import 'data/models/training.dart';

enum ExerciseCategory {
  Abs,
  Back,
  Biceps,
  Cardio,
  Chest,
  Forearms,
  Legs,
  Shoulders,
  Triceps
}

class Logs extends StatefulWidget {
  const Logs({Key? key}) : super(key: key);

  @override
  State<Logs> createState() => _LogsState();
}

class _LogsState extends State<Logs> {
  final List<Training> _logsHistory = [
    Training(date: DateTime.now(), name: "Evening session", exercises: [
      Exercise(
          sets: [Set(reps: 1, weight: 0)],
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          sets: [Set(reps: 10, weight: 50)],
          name: "Bench press",
          category: ExerciseCategory.Chest.toString()),
      Exercise(
          sets: [Set(reps: 15, weight: 30)],
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
    Training(date: DateTime.now(), name: "Morning session", exercises: [
      Exercise(
          sets: [Set(reps: 1, weight: 0)],
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          sets: [Set(reps: 10, weight: 50)],
          name: "Lounges",
          category: ExerciseCategory.Legs.toString()),
      Exercise(
          sets: [Set(reps: 15, weight: 30)],
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
    Training(date: DateTime.now(), name: "Midday session", exercises: [
      Exercise(
          sets: [Set(reps: 1, weight: 0)],
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          sets: [Set(reps: 10, weight: 50)],
          name: "Bench press",
          category: ExerciseCategory.Chest.toString()),
      Exercise(
          sets: [Set(reps: 15, weight: 30)],
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: _logsHistory.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          onTap: () {
            print('Clicked on item #$index'); // Print to console
          },
          title: Text(_logsHistory[index].name),
          subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _logsHistory[index]
                  .exercises
                  .map((item) =>
                      new Text("${item.name} of ${item.sets.length} sets"))
                  .toList()),
          leading: Column(children: <Widget>[
            Text(DateFormat('EEEE')
                .format(_logsHistory[index].date)
                .substring(0, 3)),
            Text(_logsHistory[index].date.day.toString()),
            Text(DateFormat('MMMM')
                .format(_logsHistory[index].date)
                .substring(0, 3))
          ]),
          trailing: Icon(Icons.edit),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider();
      },
    );
  }
}
