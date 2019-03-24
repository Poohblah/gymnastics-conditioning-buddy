import 'dart:math';

class Thing {
  final int id;
  final String name;
  final int number;

  Thing({this.id, this.name, this.number});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'number': number,
    };
  }

  @override
  String toString() {
    return 'Thing{id: $id, name: $name, number: $number}';
  }
}
