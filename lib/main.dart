import 'package:flutter/material.dart';
import 'package:flutter_experiments/logs_screen.dart';

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
            headline3: TextStyle(fontSize: 16.0, color: Colors.black),
            headline4: TextStyle(fontSize: 12.0, color: Colors.black),
            bodyText1: TextStyle(fontSize: 16.0, color: Colors.black),
            subtitle1: TextStyle(fontSize: 12.0, color: Colors.grey),
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
        home: NavigationExample());
  }
}

class NavigationExample extends StatefulWidget {
  const NavigationExample();

  @override
  State<NavigationExample> createState() => _NavigationExampleState();
}

class _NavigationExampleState extends State<NavigationExample> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RepsTracker'),
      ),
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.history),
            label: 'Log',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(
            icon: Icon(Icons.fitness_center),
            label: 'Routines',
          ),
        ],
      ),
      body: <Widget>[
        Container(
          // color: Colors.red,
          alignment: Alignment.center,
          child: Logs(),
        ),
        Container(
          color: Colors.green,
          alignment: Alignment.center,
          child: const Text('Page 2'),
        ),
        Container(
          color: Colors.blue,
          alignment: Alignment.center,
          child: const Text('Page 3'),
        ),
      ][currentPageIndex],
    );
  }
}
