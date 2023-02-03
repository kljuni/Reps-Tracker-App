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
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          centerTitle: true,
          title: Text(monthString),
        ),
        body: Column(
          children: [
            TrainingForm(training),
            Flexible(fit: FlexFit.loose, child: ExerciseList(training)),
          ],
        ));
  }
}
