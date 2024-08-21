import 'package:bloc/bloc.dart';
import 'package:student_admission_app_cubit_state/cubit/student_state.dart';
import '../data/local/db_helper.dart';
import '../model/student_model.dart';

class StudentCubit extends Cubit<StudentState> {
  final DBHelper _dbHelper;

  StudentCubit(this._dbHelper) : super(StudentState(students: []));

  // Method to add a student
  void addStudent(StudentModel student) async {
    await _dbHelper.addStudent(student);
    getAllStudents(); // Refresh the list after adding
  }

  // Method to update a student
  void updateStudent(StudentModel student) async {
    await _dbHelper.updateStudent(student);
    getAllStudents(); // Refresh the list after updating
  }

  // Method to delete a student
  void deleteStudent(int id) async {
    await _dbHelper.deleteStudent(id);
    getAllStudents(); // Refresh the list after deleting
  }

  // Method to get all students
  Future<void> getAllStudents() async {
    final students = await _dbHelper.getAllStudents();
    emit(StudentState(students: students));
  }
}
