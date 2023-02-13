import 'package:flutter/material.dart';

import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/models/training.dart';
import 'exercise_list.dart';
import 'training_form.dart';
import 'training_list_model.dart';

enum TrainingMenuItem { delete }

class TrainingDetails extends StatelessWidget {
  final Training training;
  late final String monthString;

  TrainingDetails(this.training) {
    monthString = DateFormat('MMM dd').format(training.date);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TrainingModel>(builder: (context, data, child) {
      // var currentTraining = data.getTrainingById(training.id);
      return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              monthString,
              style: Theme.of(context).appBarTheme.titleTextStyle,
            ),
            actions: [
              PopupMenuButton<TrainingMenuItem>(onSelected: (value) {
                executeMenuAction(value, context);
              }, itemBuilder: (context) {
                return [
                  PopupMenuItem<TrainingMenuItem>(
                    child: Text(
                      "Delete",
                      style: Theme.of(context)
                          .textTheme
                          .labelLarge
                          ?.apply(color: Colors.black),
                    ),
                    value: TrainingMenuItem.delete,
                  )
                ];
              })
            ],
          ),
          body: Column(
            children: [
              TrainingForm(training),
              Flexible(fit: FlexFit.loose, child: ExerciseList(training)),
            ],
          ));
    });
  }

  executeMenuAction(TrainingMenuItem action, BuildContext context) {
    switch (action) {
      case TrainingMenuItem.delete:
        {
          Provider.of<TrainingModel>(context, listen: false)
              .deleteTraining(training);
          Navigator.pop(context);
        }
        break;
    }
  }
}
