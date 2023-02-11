import 'package:flutter/material.dart';

import 'logs_screen.dart';
import 'select_exercise.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Select Exercise"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: constraints.maxHeight - kToolbarHeight,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: ExerciseCategory.exercises.length,
              itemBuilder: (BuildContext context, int i) {
                final category = ExerciseCategory.exercises.keys.elementAt(i);
                var exercises; 
                if (ExerciseCategory.exercises.containsKey(category)) {
                  exercises = ExerciseCategory.exercises[category] ?? [];
                }

                return InkWell(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SelectExercise(category, exercises)),
                    ).then((exercise) {
                      Navigator.pop(context, exercise);
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      category,
                      style: Theme.of(context).textTheme.headline3,
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
