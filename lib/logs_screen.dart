import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'training_details.dart';
import 'training_list_model.dart';
import 'widgets/DateLog.dart';

class ExerciseCategory {
  static final Map<String, List<String>> exercises = {
    'Abs': ["Crunch", "Plank", "Side Plank", "Leg Raises"],
    'Back': [
      "Pull Ups",
      "Chin Ups",
      "Bent-over Row",
      "Deadlift",
      "Hyper Extension"
    ],
    'Biceps': ["Dumbbell Curl", "Slow Chin Ups"],
    'Cardio': ["Running", "Cycling", "Walking", "Hiking"],
    'Chest': ["Push Ups", "Bench Press"],
    'Forearms': ["Finger Hanging", "Pinch"],
    'Legs': ["Squat", "Romanian deadlift"],
    'Shoulders': ["Dumbbell Press", "Dumbbell lateral raise"],
    'Triceps': ["Dumbbell Extension", "Narrow-Grip Push Ups"]
  };

  static List<String>? getExercisesForKey(String key) {
    return exercises[key];
  }
}

class Logs extends StatelessWidget {
  final TrainingModel trainingsModel;

  Logs(this.trainingsModel);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TrainingModel>(builder: (context, data, child) {
        var allTrainings = data.allTrainings;
        return ListView.separated(
          itemCount: allTrainings.length,
          itemBuilder: (BuildContext context, int i) {
            final training = allTrainings[i];
            return Card(
              elevation: 0,
              color: Theme.of(context).canvasColor,
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<TrainingModel>.value(
                        value: trainingsModel,
                        child: TrainingDetails(training),
                      ),
                    ),
                  ).then((_) =>
                      ScaffoldMessenger.of(context).hideCurrentSnackBar());
                },
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 16, right: 22),
                      child: DateLog(training.date),
                    ),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.only(left: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(allTrainings[i].name,
                                style: Theme.of(context).textTheme.bodyText1),
                            ...training.exercises
                                .map((item) => new Text(
                                      "${item.name} - ${item.sets} sets - ${item.reps} reps",
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
        );
      }),
    );
  }
}
