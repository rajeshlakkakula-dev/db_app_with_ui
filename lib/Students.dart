
class Students {
  late int id;
  late String name;
  late int age;
  late int marks;

  Students(
      {required this.id,
      required this.name,
      required this.age,
      required this.marks});
 // Retreive the data from map and save it in your local variables
  Students.fromMap(Map<String, dynamic> result)
      : id = result["id"],
        name = result["name"],
        age = result["age"],
        marks = result["marks"];

  // ToMap you take the saved values into your local variables and can return a map.
  Map<String, Object> toMap() {
    return {'id': id, 'name': name, 'age': age, 'marks': marks};
  }
}
