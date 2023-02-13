import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../data/models/training.dart';
import 'training_list_model.dart';

enum ExerciseMenuItem { delete }

class ExerciseForm extends StatefulWidget {
  final Exercise _exercise;

  ExerciseForm(this._exercise);

  @override
  State<ExerciseForm> createState() => _ExerciseFormState();
}

class _ExerciseFormState extends State<ExerciseForm> {
  final _setsController = TextEditingController();
  final _repsController = TextEditingController();
  final _weightController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _repsController.text = widget._exercise.reps.toString();
    _setsController.text = widget._exercise.sets.toString();
    _weightController.text = widget._exercise.weight.toString();
  }

  @override
  Widget build(BuildContext context) {
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
              Text("Swipe to add a set!")
            ],
          ),
        ),
        key: ValueKey<String>('${widget._exercise.id}'),
        confirmDismiss: (direction) async {
          Provider.of<TrainingModel>(context, listen: false)
              .updateSetsToExericse(widget._exercise.training_id, widget._exercise.id,
                  widget._exercise.sets + 1);
          setState(() {
            _setsController.text = (widget._exercise.sets + 1).toString();
          });
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          var message = getSnackbarMessage();
          var snack = SnackBar(
            action: SnackBarAction(
              label: 'Undo',
              onPressed: () {
                Provider.of<TrainingModel>(context, listen: false)
                    .updateSetsToExericse(
                        widget._exercise.training_id,
                        widget._exercise.id,
                        widget._exercise.sets - 1);
                setState(() {
                  _setsController.text = (widget._exercise.sets - 1).toString();
                });
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
        child: Padding(
          padding: EdgeInsets.only(bottom: 15, left: 15, right: 15),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Row(
                    children: [
                      Text(
                        widget._exercise.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      Spacer(),
                      PopupMenuButton<ExerciseMenuItem>(onSelected: (value) {
                        executeMenuAction(value, context);
                      }, itemBuilder: (context) {
                        return [
                          PopupMenuItem<ExerciseMenuItem>(
                            child: Text("Delete",
                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.apply(color: Colors.black)),
                            value: ExerciseMenuItem.delete,
                          )
                        ];
                      })
                    ],
                  ),
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _setsController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            isDense: true,
                            labelText: 'Set',
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 18)),
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          final parsedInteger = int.tryParse(value);
                          if (parsedInteger != null) {
                            Provider.of<TrainingModel>(context, listen: false)
                                .updateSetsToExericse(
                                    widget._exercise.training_id,
                                    widget._exercise.id,
                                    parsedInteger);
                            // setState(() {
                            //   _setsController.text = value;
                            // });
                          }
                        },
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: TextFormField(
                          controller: _repsController,
                          style: TextStyle(fontSize: 18),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(5),
                              isDense: true,
                              labelText: 'Reps'),
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Please enter a name';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            final parsedInteger = int.tryParse(value);
                            if (parsedInteger != null) {
                              Provider.of<TrainingModel>(context, listen: false)
                                  .updateRepsToExericse(
                                      widget._exercise.training_id,
                                      widget._exercise.id,
                                      parsedInteger);
                              // setState(() {
                              //   _repsController.text = value;
                              // });
                            }
                          },
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        controller: _weightController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            isDense: true,
                            labelText: 'Weight'),
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          final parsedInteger = double.tryParse(value);
                          if (parsedInteger != null) {
                            Provider.of<TrainingModel>(context, listen: false)
                                .updateWeightToExericse(
                                    widget._exercise.training_id,
                                    widget._exercise.id,
                                    parsedInteger);
                            // setState(() {
                            //     _weightController.text = value;
                            //   });
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  executeMenuAction(ExerciseMenuItem action, BuildContext context) {
    switch (action) {
      case ExerciseMenuItem.delete:
        {
          Provider.of<TrainingModel>(context, listen: false)
              .deleteExercise(widget._exercise);
        }
        break;
    }
  }

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
}
