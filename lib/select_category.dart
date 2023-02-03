import 'package:flutter/material.dart';

import 'logs_screen.dart';

class SelectCategory extends StatelessWidget {
  const SelectCategory({Key? key}) : super(key: key);

  // ignore: todo
  // TODO, add call to fill exericse list

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Select Exercise"),
      ),
      body: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: constraints.maxHeight - kToolbarHeight,
            child: ListView.separated(
              physics: BouncingScrollPhysics(),
              itemCount: ExerciseCategory.values.length,
              itemBuilder: (BuildContext context, int i) {
                return InkWell(
                  onTap: () {
                    // Your onTap code here
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      ExerciseCategory.values[i].name,
                      style: Theme.of(context).textTheme.headline3,
                    ),
                  ),
                );
              },
              separatorBuilder: (_, __) => Divider(height: 0.5),
            ),
          );
        },
      ),
    );
  }
}
