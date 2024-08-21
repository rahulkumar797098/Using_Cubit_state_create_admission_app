import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_admission_app_cubit_state/cubit/student_cubit.dart';
import 'package:student_admission_app_cubit_state/screen/add_info.dart';
import 'package:student_admission_app_cubit_state/screen/update_screen.dart';
import '../cubit/student_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    super.initState();
    context.read<StudentCubit>().getAllStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student List"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.orangeAccent,
        foregroundColor: Colors.white,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddInfo()),
          );
        },
        label: Row(
          children: [
            Icon(Icons.add , size: 25,),
            Text("New Admission", style: TextStyle(fontSize: 20 ),)
          ],
        ),

      ),
      body: BlocBuilder<StudentCubit, StudentState>(
        builder: (context, state) {
          if (state.students.isEmpty) {
            return const Center(child: Text("No students available."));
          }

          return ListView.builder(
            itemCount: state.students.length,
            itemBuilder: (context, index) {
              final student = state.students[index];

              return Dismissible(
                key: Key(student.id.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (direction) {
                  // Remove the item from the data source
                  context.read<StudentCubit>().deleteStudent(student.id!);

                  // Show a snackbar
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("${student.name} deleted")),
                  );
                },
                child: GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => UpdateScreen(student: student,)));

                  },
                  child: Card(
                    child: Row(
                      children: [
                        SizedBox(
                          height: 100,
                          width: 100,
                          child: Image.asset("assets/image/rahul.jpg"),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Name: ${student.name}"),
                            Text("Father's Name: ${student.father}"),
                            Text("Age: ${student.age}"),
                            Text("Class: ${student.classNam}"),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

