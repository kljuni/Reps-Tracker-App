import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'training_details.dart';
import 'training_list_model.dart';
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

class Logs extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<TrainingModel>(builder: (context, data, child) {
        var allTrainings = Provider.of<TrainingModel>(context, listen: false).allTrainings;
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
                        value: Provider.of<TrainingModel>(context),
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
                                style:
                                    Theme.of(context).textTheme.bodyText1),
                            ...training.exercises
                                .map((item) => new Text(
                                      "${item.name} - ${item.sets} sets - ${item.reps} reps",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1,
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
