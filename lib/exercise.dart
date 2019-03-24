import 'dart:math';

class Exercise {
  final int id;
  final String name;

  Exercise({this.id, this.name});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }

  @override
  String toString() {
    return 'Exercise{id: $id, name: $name}';
  }
}
