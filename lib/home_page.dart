import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';
import 'database_provider.dart';
import 'exercise_list.dart';
import 'workout_generator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _exercises = <Exercise>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gymnastics Conditioning Buddy'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Exercises'),
              Tab(text: 'Workout'),
            ]
          ),
        ),
        body: TabBarView(
          children: [
            ExerciseList(),
            WorkoutGenerator(),
          ],
        ),
      ),
    );
  }
}
