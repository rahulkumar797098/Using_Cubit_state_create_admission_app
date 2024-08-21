import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:student_admission_app_cubit_state/cubit/student_cubit.dart';
import 'package:student_admission_app_cubit_state/custom_text_field.dart';
import 'package:student_admission_app_cubit_state/model/student_model.dart';

class UpdateScreen extends StatefulWidget {
  final StudentModel student;

  const UpdateScreen({super.key, required this.student});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  late TextEditingController nameController;
  late TextEditingController fatherController;
  late TextEditingController classController;
  late TextEditingController dobController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.student.name);
    fatherController = TextEditingController(text: widget.student.father);
    classController = TextEditingController(text: widget.student.classNam);
    dobController = TextEditingController(text: widget.student.age);
  }

  Future<void> _selectDate() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(dobController.text.isNotEmpty ? dobController.text : DateTime.now().toString()),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (selectedDate != null) {
      setState(() {
        dobController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Update Details"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Card(
                elevation: 5,
                shadowColor: Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.asset(
                        "assets/image/rahul.jpg",
                        height: 200,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: IconButton(
                        icon: const Icon(
                          Icons.image_rounded,
                          size: 28,
                          color: Colors.black87,
                        ),
                        onPressed: () {},
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 420,
                  child: Card(
                    elevation: 8,
                    shadowColor: Colors.lightBlueAccent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Name of the Student",
                                style: TextStyle(fontSize: 20),
                              ),
                              CustomTextField(
                                controller: nameController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Father's name",
                                style: TextStyle(fontSize: 20),
                              ),
                              CustomTextField(
                                controller: fatherController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Class",
                                style: TextStyle(fontSize: 20),
                              ),
                              CustomTextField(
                                controller: classController,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Date of birth",
                                style: TextStyle(fontSize: 20),
                              ),
                              CustomTextField(
                                controller: dobController,
                                suffixIcon: const Icon(
                                  Icons.calendar_month_rounded,
                                ),
                                suffixOnTop: _selectDate,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: 170,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(width: 2, color: Colors.orange),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 20, color: Colors.red),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 170,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.orange,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: const BorderSide(width: 2, color: Colors.black),
                        ),
                      ),
                      onPressed: () {
                        final updatedStudent = StudentModel(
                          id: widget.student.id, // Pass the ID for updating the correct record
                          name: nameController.text,
                          father: fatherController.text,
                          age: dobController.text,
                          classNam: classController.text,
                        );
                        context.read<StudentCubit>().updateStudent(updatedStudent); // Call update method
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Update",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
