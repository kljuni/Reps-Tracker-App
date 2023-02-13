import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/database.dart';
import '../data/models/training.dart';
import 'logs_screen.dart';
import 'training_details.dart';
import 'training_list_model.dart';
import '../utils/helpers/text_helpers.dart';

class ScreenNavigator extends StatefulWidget {
  @override
  State<ScreenNavigator> createState() => _ScreenNavigatorState();
}

class _ScreenNavigatorState extends State<ScreenNavigator> {
  late Future<List<Training>> _trainings;
  late TrainingModel _trainingsModel;
  int currentPageIndex = 0;

  @override
  void initState() {
    super.initState();
    _trainingsModel = TrainingModel();
    _trainings = fetchTrainings();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => _trainingsModel,
        child: FutureBuilder<List<Training>>(
            future: _trainings,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                Future.delayed(Duration.zero, () {
                  Provider.of<TrainingModel>(context, listen: false)
                      .addAllTrainings(snapshot.data!);
                });

                return Scaffold(
                  appBar: AppBar(
                    title: Text(
                      'RepsTracker',
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
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
                      )
                    ],
                  ),
                  body: <Widget>[
                    Container(
                      alignment: Alignment.center,
                      child: Logs(_trainingsModel),
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Text('Work in progress.',
                          style: Theme.of(context).textTheme.headlineLarge),
                    )
                  ][currentPageIndex],
                  floatingActionButton: currentPageIndex == 0
                      ? FloatingActionButton(
                          child: Icon(Icons.add),
                          onPressed: () async {
                            await _insert().then((value) async {
                              await Future.delayed(Duration.zero, () {
                                Provider.of<TrainingModel>(context,
                                        listen: false)
                                    .addOneTraining(value);
                              });
                              return value;
                            }).then((value) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ChangeNotifierProvider<
                                    TrainingModel>.value(
                                  value: _trainingsModel,
                                  child: TrainingDetails(value),
                                );
                              }));
                            });
                          })
                      : null,
                );
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }

              return Scaffold(
                body: Center(
                  child: Container(
                    // color: Colors.white,
                    child: CircularProgressIndicator(),
                  ),
                ),
              );
            }));
  }

  Future<List<Training>> fetchTrainings() async {
    final database = await DbManager();
    return database.getTrainings();
  }

  Future<Training> _insert() async {
    final startDateTime = DateTime.now();
    final database = await DbManager();
    return await database.createNewTraining(Training(
        id: 0,
        date: startDateTime,
        name: getDefaultName(startDateTime.hour),
        exercises: []));
  }
}
