import '../data/local/db_helper.dart';

class StudentModel {
  String? name;
  String? father;
  String? age;
  String? classNam;

  StudentModel({required this.name, required this.father, required this.age, required this.classNam});

  /// fromMap -> Model
  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      name: map[DBHelper.columnName],
      father: map[DBHelper.columnFather],
      age: map[DBHelper.columnAge],
      classNam: map[DBHelper.columnClassNam],
    );
  }

  /// toMap <- from Model
  Map<String, dynamic> toMap() {
    return {
      DBHelper.columnName: name,
      DBHelper.columnFather: father,
      DBHelper.columnAge: age,
      DBHelper.columnClassNam: classNam,
    };
  }
}
