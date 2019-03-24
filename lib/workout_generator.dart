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
        onPressed: () { _generateExercises(); },
        tooltip: 'Generate Workout',
        child: Icon(Icons.shuffle),
        key: Key('generate workout button'),
      ),
    );
  }

  Future<void> _generateExercises() async {
    setState(() {});
  }

  Widget _buildWorkout() {
    return new FutureBuilder(
      key: Key('list'),
      future: _dbp.getRandomExercises(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return Text('no connection state');
          case ConnectionState.active:
            return Text('connection active...');
          case ConnectionState.waiting:
            return Text('connection waiting...');
          case ConnectionState.done:
            if (snapshot.hasError) return Text("Error: ${snapshot.error}");
            _exercises = snapshot.data;
            return _buildExerciseList();
        }
      },
    );
  }

  Widget _buildExerciseList() {
    return ListView.separated(
      padding: const EdgeInsets.all(16.0),
      itemCount: _exercises.length,
      itemBuilder: (context, i) {
        return _buildRow(_exercises[i]);
      },
      separatorBuilder: (_context, _i) { return Divider(); },
    );
  }

  Widget _buildRow(Exercise exercise) {
    return ListTile(title: Text(exercise.name, key: Key("exercise ${exercise.id}"), style:_biggerFont));
  }
}
