import 'package:flutter/material.dart';

import 'exercise.dart';
import 'database_provider.dart';

class NewExerciseForm extends StatefulWidget {
  @override
  NewExerciseFormState createState() {
    return NewExerciseFormState();
  }
}

class NewExerciseFormState extends State<NewExerciseForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<NewExerciseFormState>!
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Exercise')),
      body: _build(context),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            key: Key('exercise name'),
            controller: _nameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a name';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              key: Key('submit new exercise'),
              onPressed: () {
                if (_formKey.currentState.validate()) {
                  _submit();
                  Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }

  void _submit() {
    Exercise t = Exercise(name: _nameController.text);
    DatabaseProvider().insertExercise(t);
  }

  bool _isNumeric(String s) {
    return int.tryParse(s) != null;
  }
}
