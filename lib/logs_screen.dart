import 'package:flutter/material.dart';
import 'data/models/training.dart';
import 'training_details.dart';
import 'widgets/DateLog.dart';

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
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Bench press",
          category: ExerciseCategory.Chest.toString()),
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
    Training(date: DateTime.now(), name: "Morning session", exercises: [
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Lounges",
          category: ExerciseCategory.Legs.toString()),
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
    Training(date: DateTime.now(), name: "Midday session", exercises: [
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Bench press",
          category: ExerciseCategory.Chest.toString()),
      Exercise(
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: EdgeInsets.symmetric(vertical: 10, horizontal: 0),
      child: ListView.separated(
        itemCount: _logsHistory.length,
        itemBuilder: (BuildContext context, int i) {
          return Card(
            elevation: 0,
            color: Theme.of(context).canvasColor,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TrainingDetails(_logsHistory[i])),
                );
              },
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 16, right: 22),
                    child: DateLog(_logsHistory[i].date),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(left: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(_logsHistory[i].name,
                              style: Theme.of(context).textTheme.bodyText1),
                          ..._logsHistory[i]
                              .exercises
                              .map((item) => new Text(
                                    "${item.name} - ${item.sets} sets",
                                    style:
                                        Theme.of(context).textTheme.subtitle1,
                                  ))
                              .toList()
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Icon(Icons.content_copy),
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider();
        },
      ),
    );
  }
}
