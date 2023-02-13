import 'package:flutter/material.dart';
import 'package:flutter_experiments/data/database.dart';
import 'screen_navigator.dart';

void main() async {
  DbManager();
  runApp(App());
}

class App extends StatelessWidget {
  const App();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
            titleSmall: TextStyle(fontSize: 20.0, color: Colors.black),
            headlineLarge: TextStyle(fontSize: 20.0, color: Colors.black),
            headlineMedium: TextStyle(fontSize: 18.0, color: Colors.black),
            headlineSmall: TextStyle(fontSize: 12.0, color: Colors.black),
            // displayLarge: TextStyle(fontSize: 16.0, color: Colors.black),
            // displayMedium: TextStyle(fontSize: 15.0, color: Colors.black),
            // displaySmall: TextStyle(fontSize: 14.0, color: Colors.black),
            bodyLarge: TextStyle(fontSize: 16.0, color: Colors.black),
            titleLarge: TextStyle(fontSize: 12.0, color: Colors.grey),
            labelLarge: TextStyle(fontSize: 15.0, color: Colors.white),
          ),

          appBarTheme: const AppBarTheme(
            titleTextStyle: TextStyle(fontSize: 18.0, color: Colors.black)
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
