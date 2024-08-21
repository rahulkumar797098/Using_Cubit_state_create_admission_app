import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../../model/student_model.dart';



class DBHelper {
  DBHelper._privateConstructor();
  static final DBHelper instance = DBHelper._privateConstructor();

  static const String studentTable = "StudentData";
  static const String columnId = "id";
  static const String columnName = "name";
  static const String columnFather = "father";
  static const String columnAge = "age";
  static const String columnClassNam = "class_nam";

  Database? _database;

  Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await _openDb();
    return _database!;
  }

  Future<Database> _openDb() async {
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String dbPath = join(appDirectory.path, "student.db");
    return await openDatabase(
      dbPath,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE $studentTable ("
            "$columnId INTEGER PRIMARY KEY AUTOINCREMENT, "
            "$columnName TEXT, "
            "$columnFather TEXT, "
            "$columnAge TEXT, "
            "$columnClassNam TEXT"
            ")");
      },
    );
  }

  Future<int> addStudent(StudentModel student) async {
    final db = await _db;
    return await db.insert(studentTable, student.toMap());
  }

  Future<List<StudentModel>> getAllStudents() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query(studentTable);
    return List.generate(maps.length, (i) {
      return StudentModel.fromMap(maps[i]);
    });
  }

  Future<int> updateStudent(StudentModel student) async {
    final db = await _db;
    return await db.update(
      studentTable,
      student.toMap(),
      where: '$columnId = ?',
      whereArgs: [student.id],
    );
  }

  Future<int> deleteStudent(int id) async {
    final db = await _db;
    return await db.delete(
      studentTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );
  }
}
