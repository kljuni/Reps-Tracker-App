import 'package:flutter/material.dart';
import 'package:flutter_experiments/data/models/training.dart';
import 'package:flutter_experiments/exercise_form.dart';
import 'package:provider/provider.dart';
import "dart:math";

import 'data/database.dart';
import 'training_list_model.dart';
import 'select_category.dart';

class ExerciseList extends StatelessWidget {
  final Training _training;

  ExerciseList(this._training);

  final List<String> messages = [
    "Added new set! Bravo! 🏋️",
    "New set, new win! ✌️",
    "Way to go!",
    "On your way! 🏆",
    "Sets keep adding up 🙌",
    "You are rocking! 🚀",
    "Thats 🔥",
    "💥 New set added!",
    "Keep rolllin' 🤸"
  ];

  String getSnackbarMessage() {
    return messages[Random().nextInt(messages.length)];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      // physics: NeverScrollableScrollPhysics(),
      physics: BouncingScrollPhysics(),
      itemCount: _training.exercises.length + 2,
      itemBuilder: (BuildContext context, int i) {
        if (i == 0) {
          return Container(); // zero height: not visible
        } else if (i == _training.exercises.length + 1) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(30),
              child: ElevatedButton.icon(
                  onPressed: () async {
                    final Exercise exercise = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SelectCategory(_training)),
                    );
                    Provider.of<TrainingModel>(context, listen: false).addExercise(exercise);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                    size: 25.0,
                  ),
                  label: Text(
                    "Add Exercise",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(15),
                    shape: StadiumBorder(),
                    backgroundColor: Theme.of(context).primaryColor,
                  )),
            ),
          );
        }
        return Dismissible(
            background: Container(
              color: Colors.lightGreen,
              alignment: Alignment.center,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 1),
                    child: Icon(
                      Icons.add_task,
                      size: 50,
                    ),
                  ),
                  Text("Swipe to add a set! ${i}")
                ],
              ),
            ),
            key: ValueKey<String>('$i-${_training.exercises[i - 1].id}'),
            confirmDismiss: (direction) async {
              Provider.of<TrainingModel>(context, listen: false)
                  .addSetToExericse(
                      _training.id, _training.exercises[i - 1].id);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              var message = getSnackbarMessage();
              var snack = SnackBar(
                action: SnackBarAction(
                  label: 'Undo',
                  onPressed: () {
                    Provider.of<TrainingModel>(context, listen: false)
                        .addSetToExericse(
                            _training.id, _training.exercises[i - 1].id, -1);
                  },
                ),
                content: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(message),
                ),
                duration: const Duration(milliseconds: 6000),
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0, // Inner padding for SnackBar content.
                ),
                behavior: SnackBarBehavior.floating,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              );
              ScaffoldMessenger.of(context).showSnackBar(snack);
              return false;
            },
            child: ExerciseForm(_training.exercises[i - 1]));
      },
      separatorBuilder: (_, __) => Divider(height: 0.5),
    );
  }
}
