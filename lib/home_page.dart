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
    return Scaffold(
      appBar: AppBar(title: Text('Gymnastics Conditioning Buddy')),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.fitness_center),
            title: Text('Exercise Database'),
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => ExerciseList())); },
          ),
          ListTile(
            leading: Icon(Icons.directions_run),
            title: Text('Generate Workout'),
            onTap: () { Navigator.push(context, MaterialPageRoute(builder: (context) => WorkoutGenerator())); },
          ),
        ],
      ),
    );
  }
}
