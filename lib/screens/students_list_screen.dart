import 'package:flutter/material.dart';
import 'package:student/screens/student_form_screen.dart';
import 'package:student/widgets/students_list.dart';

class StudentsListScreen extends StatefulWidget {
  const StudentsListScreen({super.key});

  @override
  State<StudentsListScreen> createState() => _StudentsListScreenState();
}

class _StudentsListScreenState extends State<StudentsListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Students List'),
      ),
      body: Center(
          child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 600,
              ),
              child: const StudentsList())),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          bool? studentAdded = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const StudentFormScreen(student: null),
            ),
          );

          if (studentAdded == true) {
            setState(() {});
          }
        },
      ),
    );
  }
}
