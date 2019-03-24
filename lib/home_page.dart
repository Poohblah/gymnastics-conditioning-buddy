import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'exercise_list.dart';
import 'workout_generator.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gymnastics Conditioning Buddy'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Exercises', key: Key('exercises tab')),
              Tab(text: 'Workout', key: Key('workout tab')),
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
