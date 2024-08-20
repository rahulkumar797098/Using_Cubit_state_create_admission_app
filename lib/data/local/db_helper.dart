import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/student_model.dart';

class DBHelper {
  DBHelper._();

  static final DBHelper getInstance = DBHelper._();

  static final String tableStudent = "studentData";
  static final String columnStudentId = "id";
  static final String columnName = "name";
  static final String columnFather = "father";
  static final String columnAge = "age";
  static final String columnClassNam = "classNam";

  Database? myDB;

  Future<Database> getDb() async {
    myDB ??= await openDb();
    return myDB!;
  }

  Future<Database> openDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String rootPath = appDirectory.path;
    String dbPath = join(rootPath, "studentData.db");

    return await openDatabase(dbPath, version: 1, onCreate: (db, version) {
      db.execute(
          "CREATE TABLE $tableStudent ( $columnStudentId INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT, $columnFather TEXT, $columnAge TEXT, $columnClassNam TEXT )");
    });
  }

  Future<bool> addStudent(StudentModel student) async {
    var db = await getDb();
    int rowsAffected = await db.insert(tableStudent, student.toMap());
    return rowsAffected > 0;
  }

  Future<List<StudentModel>> getAllStudents() async {
    var db = await getDb();
    List<StudentModel> students = [];

    var data = await db.query(tableStudent);
    for (Map<String, dynamic> eachStudent in data) {
      StudentModel studentModel = StudentModel.fromMap(eachStudent);
      students.add(studentModel);
    }

    return students;
  }

  Future<bool> updateStudent({required StudentModel updatedStudent, required int id}) async {
    var db = await getDb();
    int rowsAffected = await db.update(
      tableStudent,
      updatedStudent.toMap(),
      where: "$columnStudentId = ?",
      whereArgs: [id],
    );
    return rowsAffected > 0;
  }

  Future<bool> deleteStudent({required int id}) async {
    var db = await getDb();
    int rowsAffected = await db.delete(
      tableStudent,
      where: "$columnStudentId = ?",
      whereArgs: [id],
    );
    return rowsAffected > 0;
  }
}
