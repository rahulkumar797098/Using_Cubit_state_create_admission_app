import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:student_admission_app_cubit_state/cubit/student_cubit.dart';
import 'package:student_admission_app_cubit_state/data/local/db_helper.dart';
import 'package:student_admission_app_cubit_state/screen/add_info.dart';
import 'package:student_admission_app_cubit_state/screen/home_screen.dart';

void main() {
  final dbHelper = DBHelper.instance;
  runApp(
    BlocProvider(
      create: (context) => StudentCubit(dbHelper),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
