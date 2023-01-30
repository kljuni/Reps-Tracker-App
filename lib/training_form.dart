import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:date_field/date_field.dart';

class TrainingForm extends StatefulWidget {
  @override
  _TrainingFormState createState() => _TrainingFormState();
}

class _TrainingFormState extends State<TrainingForm> {
  final _formKey = GlobalKey<FormState>();
  String _name = "Ivan's Test";
  final _nameController = TextEditingController();
  DateTime _exercise_date = DateTime.now();
  DateTime _startTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Exercise name TODO';
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

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _exercise_date = pickedDate;
      });
    });
    print('...');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:15, bottom: 25),
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
                          labelText: DateFormat.yMd().format(_startTime),
                        ),
                        onTap: () async {
                          final selectedDateA = await selectDate(_startTime);
                          if (selectedDateA != null) {
                            setState(() {
                              _startTime = selectedDateA;
                            });
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
                        labelText: DateFormat.yMd().format(_endTime),
                      ),
                      onTap: () async {
                        final selectedDateA = await selectDate(_endTime);
                        if (selectedDateA != null) {
                          setState(() {
                            _endTime = selectedDateA;
                          });
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

  // void _submitForm() {
  //   if (_formKey.currentState.validate()) {
  //     _formKey.currentState.save();
  //     // Do something with the data.
  //   }
  // }
}
