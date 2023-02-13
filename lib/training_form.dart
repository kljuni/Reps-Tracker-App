import 'package:flutter/material.dart';
import 'package:flutter_experiments/data/database.dart';
import 'package:flutter_experiments/training_list_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'data/models/training.dart';
import 'utils/helpers/text_helpers.dart';

class TrainingForm extends StatefulWidget {
  final Training _training;

  TrainingForm(this._training);

  @override
  _TrainingFormState createState() => _TrainingFormState();
}

class _TrainingFormState extends State<TrainingForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  late DateTime _exercise_date;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget._training.name;
    _exercise_date = widget._training.date;
  }

  Future<DateTime?> selectDate(DateTime initialDate) async {
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );
    return selectedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
      child: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.only(top: 15, left: 15, right: 15),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: TextFormField(
                        maxLength: 30,
                        controller: _nameController,
                        style: TextStyle(fontSize: 18),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(15),
                            isDense: true,
                            labelText: 'Name',
                            counterText: "",),
                        validator: (value) {
                          if (value == null || value.length == 0) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onChanged: (value) async {
                          print('First text field: $value');
                          try {
                            final trainingUpdate = Training(
                                id: widget._training.id,
                                exercises: widget._training.exercises,
                                name: value,
                                date: widget._training.date);
                            await DbManager().updateTraining(trainingUpdate);
                            Provider.of<TrainingModel>(context, listen: false)
                                .updateTraining(trainingUpdate);
                          } catch (e) {
                            print("Error updating training: $e");
                          }
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: TextFormField(
                      style: TextStyle(fontSize: 18),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        isDense: true,
                        labelText: DateFormat.yMd().format(_exercise_date),
                      ),
                      onTap: () async {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        final selectedDateA = await selectDate(_exercise_date);
                        if (selectedDateA != null) {
                          try {
                            final trainingUpdate = Training(
                                id: widget._training.id,
                                exercises: [],
                                name: _nameController.text,
                                date: selectedDateA);
                            await DbManager().updateTraining(trainingUpdate);

                            Provider.of<TrainingModel>(context, listen: false)
                                .updateTraining(trainingUpdate);

                            // await DbManager().updateTraining(training);
                            setState(() {
                              _exercise_date = selectedDateA;
                            });
                          } catch (e) {
                            print("Error updating training: $e");
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
