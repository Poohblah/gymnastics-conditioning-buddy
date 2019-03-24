import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'thing.dart';

class MyDatabaseProvider {
  static final MyDatabaseProvider _instance = MyDatabaseProvider._internal();
  Database _db;

  MyDatabaseProvider._internal();

  factory MyDatabaseProvider() { return _instance; }

  Future<Database> getDatabase() async {
    if (_db != null) return _db;
    _db = await _init();
    return _db;
  }

  Future<Database> _init() async {
    var path = join(await getDatabasesPath(), 'thing_database.db');
    // re-create the database every time for testing purposes
    var f = File(path);
    f.delete();
    return await openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE things(id INTEGER PRIMARY KEY, name TEXT, number INTEGER)",
        );
      },
      // Set the version. This executes the onCreate function and provides a
      // path to perform database upgrades and downgrades.
      version: 1,
    );
  }

  Future<void> insertThing(Thing thing) async {
    var db = await getDatabase();
    await db.insert(
      'things',
      thing.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Thing>> getAllThings() async {
    var db = await getDatabase();
    final List<Map<String, dynamic>> maps = await db.query('things');

    // Convert the List<Map<String, dynamic> into a List<Thing>.
    return List.generate(maps.length, (i) {
      return Thing(
        id: maps[i]['id'],
        name: maps[i]['name'],
        number: maps[i]['number'],
      );
    });
  }

  // Future<void> updateThing(Thing thing) async {
  //   final db = await database;

  //   await db.update(
  //     'things',
  //     thing.toMap(),
  //     where: "id = ${thing.id}",
  //   );
  // }

  // Future<void> deleteThing(Thing thing) async {
  //   final db = await database;

  //   await db.delete(
  //     'things',
  //     where: "id = ${thing.id}",
  //   );
  // }

}

Future<List<Thing>> getThings() async {
  var dbp = new MyDatabaseProvider();
  return await dbp.getAllThings();
}
