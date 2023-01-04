import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  var questionIndex = 0;

  void answerQuestion() {
    setState(() {
      questionIndex++;
    });
    print("Answer chosen");
  }

  @override
  Widget build(BuildContext context) {
    var questions = [
      "What's your favorite color?",
      "What's your favorite animal?",
    ];

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text("My First App"),
      ),
      body: Column(
        children: <Widget>[
          Text(questions[questionIndex]),
          ElevatedButton(onPressed: answerQuestion, child: Text("Answer 1")),
          ElevatedButton(onPressed: answerQuestion, child: Text("Answer 2")),
          ElevatedButton(onPressed: answerQuestion, child: Text("Answer 3")),
        ],
      ),
    ));
  }
}
