

import 'package:db_app_with_ui/Students.dart';
import 'Databases.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Databases handler;

  Future<int> addStudents() async {
    Students firstStudent = Students(id: 1, name: "Ramu", age: 23, marks: 56);
    Students secondStudent = Students(id: 2, name: "Rama", age: 22, marks: 68);
    Students thirdStudent = Students(id: 3, name: "Raja", age: 21, marks: 67);
    Students fourthStudent = Students(id: 4, name: "Rahul", age: 20, marks: 64);

    List<Students> students = [
      firstStudent,
      secondStudent,
      thirdStudent,
      fourthStudent
    ];

    return await handler.insertStudents(students);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    handler = Databases();
    handler.initDB().whenComplete(() async {
      await addStudents();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: FutureBuilder(
          future: handler.retrieveStudents(),
          builder: (context, AsyncSnapshot<List<Students>>snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(snapshot.data![index].name),
                      subtitle: Text(snapshot.data![index].age.toString()),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
