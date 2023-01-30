import 'package:flutter/material.dart';
import 'package:flutter_experiments/exercise_list.dart';
import 'package:flutter_experiments/training_form.dart';

import 'package:intl/intl.dart';

import 'data/models/training.dart';

class TrainingDetails extends StatelessWidget {
  final Training training;
  late final String monthString;

  TrainingDetails(this.training) {
    monthString = DateFormat('MMM yy').format(training.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(monthString),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: Column(
          children: [
            TrainingForm(),
            Expanded(child: ExerciseList(training.exercises)),
            ElevatedButton.icon(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 30.0,
                ),
                label: Text("Add Exercise"),
                style: ElevatedButton.styleFrom(
                  shape: StadiumBorder(),
                  backgroundColor: Theme.of(context).primaryColor,
                )
                // style: ButtonStyle(
                //     shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                //         // RoundedRectangleBorder(
                //         //     borderRadius: BorderRadius.circular(18.0),
                //         //     side: BorderSide(color: Colors.red))
                //             ))
                )
          ],
        ));
  }
}
