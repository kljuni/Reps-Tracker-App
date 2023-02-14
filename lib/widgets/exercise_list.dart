import 'package:flutter/material.dart';
import '../data/models/training.dart';
import 'package:provider/provider.dart';

import 'exercise_form.dart';
import 'training_list_model.dart';
import 'select_category.dart';

class ExerciseList extends StatelessWidget {
  final Training _training;

  ExerciseList(this._training);

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
                    Provider.of<TrainingModel>(context, listen: false)
                        .addExercise(exercise);
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
        return ExerciseForm(_training.exercises[i - 1]);
      },
      separatorBuilder: (_, __) => Divider(height: 0.5),
    );
  }
}
