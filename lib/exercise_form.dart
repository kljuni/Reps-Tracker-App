import 'package:flutter/material.dart';

import 'data/models/training.dart';

class ExerciseForm extends StatefulWidget {
  final Exercise exercise;

  ExerciseForm(this.exercise);

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
    _setsController.text = widget.exercise.sets.toString();
    _repsController.text = widget.exercise.reps.toString();
    _weightController.text = widget.exercise.weight.toString();
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
            Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Row(
                children: [
                  Text(
                    widget.exercise.name,
                    style: Theme.of(context).textTheme.headline3,
                  ),
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
                      }),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: TextFormField(
                        controller: _repsController,
                        style: TextStyle(fontSize: 18),
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(5),
                            isDense: true,
                            labelText: 'Reps'),
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return 'Please enter a name';
                          }
                          return null;
                        }),
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
                      }),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
