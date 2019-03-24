import 'package:flutter/material.dart';

import 'thing.dart';
import 'my_database_provider.dart';
import 'my_home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MaterialApp Title',
      theme: ThemeData(primarySwatch: Colors.green),
      home: Scaffold(
        appBar: AppBar(title: Text('AppBar Title')),
        body:   Center(child: MyHomePage()),
      ),
    );
  }
}
