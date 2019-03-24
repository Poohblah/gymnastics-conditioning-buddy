import 'package:flutter/material.dart';

import 'thing.dart';
import 'my_database_provider.dart';

class MyThingForm extends StatefulWidget {
  @override
  MyThingFormState createState() {
    return MyThingFormState();
  }
}

class MyThingFormState extends State<MyThingForm> {
  // Create a global key that will uniquely identify the Form widget and allow
  // us to validate the form
  //
  // Note: This is a GlobalKey<FormState>, not a GlobalKey<MyThingFormState>!
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _numberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Thing')),
      body: _build(context),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _numberController.dispose();
    super.dispose();
  }

  Widget _build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            key: Key('name'),
            controller: _nameController,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter a name';
              }
            },
          ),
          TextFormField(
            key: Key('number'),
            controller: _numberController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value.isEmpty || !_isNumeric(value)) {
                return 'Please enter a number';
              }
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: RaisedButton(
              key: Key('submit'),
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
    Thing t = Thing(name: _nameController.text, number: int.parse(_numberController.text));
    MyDatabaseProvider().insertThing(t);
  }

  bool _isNumeric(String s) {
    return int.tryParse(s) != null;
  }
}
