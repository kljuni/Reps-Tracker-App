import 'package:flutter/material.dart';
import 'package:flutter_experiments/data/models/training.dart';
import 'package:flutter_experiments/exercise_form.dart';

class ExerciseList extends StatelessWidget {
  final List<Exercise> _exercises;

  ExerciseList(this._exercises);

  addNewRep(int index) {
    this._exercises[index].sets++;
  }

  final snackBar = SnackBar(
    action: SnackBarAction(
      label: 'Undo',
      onPressed: () {
        print("undoing ...");
      },
    ),
    content: const Text('Added new set! Bravo!'),
    duration: const Duration(milliseconds: 10000),
    // width: 280.0, // Width of the SnackBar.
    padding: const EdgeInsets.symmetric(
      horizontal: 8.0, // Inner padding for SnackBar content.
    ),
    behavior: SnackBarBehavior.floating,
    elevation: 2,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return _exercises.length > 0
        ? ListView.separated(
            // physics: NeverScrollableScrollPhysics(),
            itemCount: _exercises.length + 2,
            itemBuilder: (BuildContext context, int i) {
              if (i == 0 || i == _exercises.length + 1) {
                return Container(); // zero height: not visible
              }
              return Dismissible(
                  background: Container(
                    color: Colors.lightGreen,
                    alignment: Alignment.center,
                    child: Icon(
                      Icons.add_task,
                      size: 50,
                    ),
                  ),
                  key: ValueKey<int>(i),
                  // onDismissed: (DismissDirection direction) {
                  //   print("One dissmissed");
                  // },
                  direction: DismissDirection.startToEnd,
                  confirmDismiss: (direction) async {
                    addNewRep(i - 1);
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                    return false;
                  },
                  child: ExerciseForm(_exercises[i - 1]));

              // ExerciseForm(_exercises[i - 1]);
            },
            separatorBuilder: (_, __) => Divider(height: 0.5),
          )
        : Text("No exericses yet.");
    // return Container(
    //     height: 200,
    //     child: _exercises.length > 0
    //         ? ListView.separated(
    //             // physics: NeverScrollableScrollPhysics(),
    //             itemCount: _exercises.length,
    //             itemBuilder: (BuildContext context, int i) {
    //               // return Text(_exercises[i].name);
    //               return ExerciseForm(_exercises[i]);
    //             },
    //             separatorBuilder: (BuildContext context, int index) {
    //               return const Divider();
    //             })
    //         : Text("No exericses yet."));
  }
}
