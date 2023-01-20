import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class DateLog extends StatelessWidget {
  final DateTime date;

  late final String weekDayString;
  late final String monthString;
  late final String dayNumber;

  DateLog(this.date) {
    weekDayString =
        DateFormat('EEEE').format(date).substring(0, 3).toUpperCase();
    monthString = DateFormat('MMMM').format(date).substring(0, 3).toUpperCase();
    dayNumber = date.day.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            weekDayString,
            style: Theme.of(context).textTheme.headline4,
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 3),
            child: Text(
              dayNumber,
              style: Theme.of(context).textTheme.headline2,
            ),
          ),
          Text(
            monthString,
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
    );
  }
}
