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

  /**
   * Always keep the database name and
   *  table name simple and make sure
   * datamodel name should match the data provided/given
   */
  Future<int> insertStudents(List<Students> students) async {
    int result = 0;
    final Database db = await initDB();

    for (var student in students) {
      result = await db.insert('students', student.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    return result;
  }

  Future<List<Students>> retrieveStudents() async {
    final Database db = await initDB();

    final List<Map<String, Object>> queryResult = db.query('students') as List<Map<String, Object>>;

    return queryResult.map((e) => Students.fromMap(e)).toList();
  }


}
