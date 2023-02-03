import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'data/models/training.dart';
import 'logs_screen.dart';
import 'training_details.dart';
import 'training_list_model.dart';
import 'utils/helpers/text_helpers.dart';

class ScreenNavigator extends StatefulWidget {
  const ScreenNavigator();

  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  int currentPageIndex = 0;

  final List<Training> _logsHistory = [
    Training(id: 1, date: DateTime.now(), name: "Evening session", exercises: [
      Exercise(
          id: 1,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          id: 2,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Bench press",
          category: ExerciseCategory.Chest.toString()),
      Exercise(
          id: 3,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
    Training(id: 2, date: DateTime.now(), name: "Morning session", exercises: [
      Exercise(
          id: 4,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          id: 5,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Lounges",
          category: ExerciseCategory.Legs.toString()),
      Exercise(
          id: 6,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
    Training(id: 3, date: DateTime.now(), name: "Midday session", exercises: [
      Exercise(
          id: 7,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Finger press",
          category: ExerciseCategory.Forearms.toString()),
      Exercise(
          id: 8,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Bench press",
          category: ExerciseCategory.Chest.toString()),
      Exercise(
          id: 9,
          sets: 5,
          weight: 10,
          reps: 10,
          name: "Squats",
          category: ExerciseCategory.Legs.toString())
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    final _trainingsModel = TrainingModel(_logsHistory);
    return ChangeNotifierProvider(
      create: (context) => _trainingsModel,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RepsTracker'),
        ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.history),
              label: 'Log',
            ),
            NavigationDestination(
              icon: Icon(Icons.calendar_month),
              label: 'Calendar',
            ),
            NavigationDestination(
              icon: Icon(Icons.fitness_center),
              label: 'Routines',
            ),
          ],
        ),
        body: <Widget>[
          Container(
            // color: Colors.red,
            alignment: Alignment.center,
            child: Logs(),
          ),
          Container(
            color: Colors.green,
            alignment: Alignment.center,
            child: const Text('Page 2'),
          ),
          Container(
            color: Colors.blue,
            alignment: Alignment.center,
            child: const Text('Page 3'),
          ),
        ][currentPageIndex],
        floatingActionButton: currentPageIndex == 0
            ? FloatingActionButton(
                child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    var startDateTime = DateTime.now();
                    var blankTraining = Training(
                        id: 0,
                        exercises: [],
                        name: getDefaultName(startDateTime.hour),
                        date: startDateTime);

                    // TODO, make a SQLite call to make a new training, and add it to the ChangeNotifier

                    return ChangeNotifierProvider<TrainingModel>.value(
                      value: _trainingsModel,
                      child: TrainingDetails(blankTraining),
                    );
                  }));
                })
            : null,
      ),
    );
  }
}
