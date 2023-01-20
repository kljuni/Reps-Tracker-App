import 'package:flutter/material.dart';
import 'package:flutter_experiments/exerices_form.dart';

import 'package:intl/intl.dart';

import 'data/models/training.dart';

class ExerciseDetails extends StatelessWidget {
  final Training training;
  late final String monthString;

  ExerciseDetails(this.training) {
    monthString = DateFormat('MMM yy').format(training.date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(monthString),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Add your onPressed code here!
          },
          label: const Text('Add Exercise'),
          icon: const Icon(Icons.add),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        body: ExerciseForm());
  }
}
