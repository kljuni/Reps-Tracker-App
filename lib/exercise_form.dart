import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'data/models/training.dart';
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
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 18),
                  child: Row(
                    children: [
                      Text(
                        widget._exercise.name,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<ExerciseMenuItem>(onSelected: (value) {
                  executeMenuAction(value, context);
                }, itemBuilder: (context) {
                  return [
                    PopupMenuItem<ExerciseMenuItem>(
                      child: Text(
                        "Delete",
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge?.apply(color: Colors.black)
                      ),
                      value: ExerciseMenuItem.delete,
                    )
                  ];
                })
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: TextFormField(
                    controller: _setsController,
                    style: TextStyle(fontSize: 18),
                    keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      print(value);
                      final parsedInteger = int.tryParse(value);
                      if (parsedInteger != null) {
                        Provider.of<TrainingModel>(context, listen: false)
                            .updateSetsToExericse(widget._exercise.training_id,
                                widget._exercise.id, parsedInteger);
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
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
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
                      }
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  executeMenuAction(ExerciseMenuItem action, BuildContext context) {
    switch (action) {
      case ExerciseMenuItem.delete:
        {
          Provider.of<TrainingModel>(context, listen: false)
              .deleteExercise(widget._exercise);
          Navigator.pop(context);
        }
        break;
    }
  }
}
