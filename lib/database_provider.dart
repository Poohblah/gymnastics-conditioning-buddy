import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'exercise.dart';

class DatabaseProvider {
  static final DatabaseProvider _instance = DatabaseProvider._internal();
  Database _db;

  DatabaseProvider._internal();

  factory DatabaseProvider() { return _instance; }

  Future<Database> getDatabase() async {
    if (_db != null) return _db;
    _db = await _init();
    return _db;
  }

  Future<Database> _init() async {
    var path = join(await getDatabasesPath(), 'exercise_database.db');
    // re-create the database every time for testing purposes
    var f = File(path);
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE exercises(id INTEGER PRIMARY KEY, name TEXT)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertExercise(Exercise exercise) async {
    var db = await getDatabase();
    await db.insert(
      'exercises',
      exercise.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Exercise>> getAllExercises() async {
    var db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('exercises');

    // Convert the List<Map<String, dynamic> into a List<Exercise>.
    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }

  Future<List<Exercise>> getRandomExercises({int limit: 10}) async {
    var db = await getDatabase();

    var query = "SELECT * from exercises ORDER BY RANDOM() LIMIT ${limit}";

    final List<Map<String, dynamic>> maps = await db.rawQuery(query);

    // Convert the List<Map<String, dynamic> into a List<Exercise>.
    return List.generate(maps.length, (i) {
      return Exercise(
        id: maps[i]['id'],
        name: maps[i]['name'],
      );
    });
  }
}

Future<List<Exercise>> getExercises() async {
  var dbp = new DatabaseProvider();
  return await dbp.getAllExercises();
}
