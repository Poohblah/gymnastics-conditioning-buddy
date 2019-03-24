import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'exercise.dart';
import 'database_provider.dart';
import 'new_exercise_form.dart';

class ExerciseList extends StatefulWidget {
  @override
  _ExerciseListState createState() => _ExerciseListState();
}

class _ExerciseListState extends State<ExerciseList> {
  var _exercises = <Exercise>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () { Navigator.push(context, MaterialPageRoute(builder: (context) => NewExerciseForm())); },
        tooltip: 'Add Exercise',
        child: Icon(Icons.add),
        key: Key('add new exercise button'),
      ),
    );
  }

  Widget _buildList() {
    return new FutureBuilder(
      key: Key('exercise list'),
      future: getExercises(),
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
            return _buildExercises();
        }
      },
    );
  }

  Widget _buildExercises() {
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
