import 'package:flutter/material.dart';

import 'exercise.dart';
import 'database_provider.dart';
import 'home_page.dart';

void main() => runApp(GymnasticsConditioningBuddy());

class GymnasticsConditioningBuddy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gymnastics Conditioning Buddy',
      theme: ThemeData(primarySwatch: Colors.green),
      home: HomePage(),
    );
  }
}
