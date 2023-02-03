import 'package:flutter/material.dart';

import 'screen_navigator.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: "RepsTracker",
        theme: ThemeData(
          // Define the default brightness and colors.
          brightness: Brightness.light,
          primarySwatch: Colors.lightBlue,

          // Define the default font family.
          fontFamily: 'Lato',

          // Define the default `TextTheme`. Use this to specify the default
          // text styling for headlines, titles, bodies of text, and more.
          textTheme: const TextTheme(
            headline2: TextStyle(fontSize: 22.0, color: Colors.black),
            headline3: TextStyle(fontSize: 18.0, color: Colors.black),
            headline4: TextStyle(fontSize: 12.0, color: Colors.black),
            bodyText1: TextStyle(fontSize: 16.0, color: Colors.black),
            subtitle1: TextStyle(fontSize: 12.0, color: Colors.grey),
            button: TextStyle(fontSize: 15.0, color: Colors.white)
          ),

          inputDecorationTheme: const InputDecorationTheme(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(255, 196, 196, 196)),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color.fromARGB(151, 68, 137, 255)),
            ),
          ),
        ),
        home: ScreenNavigator());
  }
}
