import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';
import 'database_provider.dart';

class WorkoutGenerator extends StatefulWidget {
  @override
  _WorkoutGeneratorState createState() => _WorkoutGeneratorState();
}

class _WorkoutGeneratorState extends State<WorkoutGenerator> {
  var _dbp = new DatabaseProvider();
  var _exercises = <Exercise>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildWorkout(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { _generateAllExercises(); },
        tooltip: 'Generate Workout',
        child: Icon(Icons.shuffle),
        key: Key('generate workout button'),
      ),
    );
  }

  Future<void> _generateSingleExercise(int index) async {
    List<Exercise> e = await _dbp.getRandomExercises(limit: 1, exclude: _exercises);
    // List<Exercise> e = await _dbp.getRandomExercises(limit: 1);
    _exercises[index] = e[0];
    setState(() {});
  }

  Future<void> _generateAllExercises() async {
    _exercises = await _dbp.getRandomExercises();
    setState(() {});
  }

  Widget _buildWorkout() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _exercises.length,
      itemBuilder: (context, i) { return _buildRow(i); },
      separatorBuilder: (_context, _i) { return Divider(); },
    );
  }

  Widget _buildRow(int index) {
    Exercise exercise = _exercises[index];
    return ListTile(
      title: Text(exercise.name, key: Key("exercise ${exercise.id}"), style:_biggerFont),
      trailing: FloatingActionButton(
        onPressed: () { _generateSingleExercise(index); },
        tooltip: 'Regenerate Exercise',
        child: Icon(Icons.shuffle, size: 16.0),
        mini: true,
      )
    );
  }
}
