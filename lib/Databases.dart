import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'Students.dart';

class Databases {
  Future<Database> initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(join(path, 'students.db'), onCreate: (db, version) {
      db.execute(
        'CREATE TABLE students(id INTEGER PRIMARY KEY, name TEXT, age INTEGER, marks INTEGER)',
      );
    }, version: 1);
  }

  Future<int> insertStudents(List<Students> students) async {
    return null;
  }
}
