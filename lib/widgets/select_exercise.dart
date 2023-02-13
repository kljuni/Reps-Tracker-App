import 'package:flutter/material.dart';
import '../data/models/training.dart';

class SelectExercise extends StatelessWidget {
  final Training _training;
  final String category;
  final List<String> exercises;

  SelectExercise(this._training, this.category, this.exercises);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          category,
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: constraints.maxHeight - kToolbarHeight,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: exercises.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    Navigator.pop(
                        context,
                        Exercise(
                            id: 0,
                            training_id: _training.id,
                            name: exercises[i],
                            category: category,
                            sets: 0,
                            reps: 0,
                            weight: 0));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      exercises[i],
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(height: 0.5),
            ),
          );
        },
      ),
    );
  }
}
