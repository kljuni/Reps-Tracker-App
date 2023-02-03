import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
  late TimeOfDay _startTime;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget._training.name;
    _exercise_date = widget._training.date;
    _startTime = TimeOfDay.fromDateTime(widget._training.date);
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
              Container(
                margin: EdgeInsets.only(bottom: 8),
                child: TextFormField(
                    controller: _nameController,
                    style: TextStyle(fontSize: 18),
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(15),
                        isDense: true,
                        labelText: 'Name'),
                    validator: (value) {
                      if (value == null || value.length == 0) {
                        return 'Please enter a name';
                      }
                      return null;
                    }),
              ),
              Row(
                children: [
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
                          setState(() {
                            _exercise_date = selectedDateA;
                          });
                        }
                      },
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: TextFormField(
                              style: TextStyle(fontSize: 18),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(15),
                                isDense: true,
                                labelText: DateFormat('HH:mm').format(
                                    DateFormat.Hm().parse(
                                        _startTime.format(context).toString())),
                              ),
                              onTap: () async {
                                FocusScope.of(context)
                                    .requestFocus(new FocusNode());
                                TimeOfDay? pickedTime = await showTimePicker(
                                  initialTime: TimeOfDay.now(),
                                  context: context,
                                );

                                if (pickedTime != null) {
                                  setState(() {
                                    _nameController.text =
                                        getDefaultName(pickedTime.hour);
                                    _startTime = pickedTime;
                                  });
                                } else {
                                  print("Time is not selected");
                                }
                              }))),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
