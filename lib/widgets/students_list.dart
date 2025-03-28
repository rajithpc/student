import 'package:flutter/material.dart';
import 'package:student/database/crud_functions.dart';
import 'package:student/models/student_model.dart';
import 'package:student/widgets/students_list_item.dart';

import 'search.dart';

class StudentsList extends StatefulWidget {
  const StudentsList({super.key});

  @override
  State<StudentsList> createState() => _StudentsListState();
}

class _StudentsListState extends State<StudentsList> {
  late Future<List<StudentModel>> studentsFuture;
  List<StudentModel> students = [];
  DatabaseFuntions database = DatabaseFuntions();

  @override
  void initState() {
    super.initState();
    studentsFuture = database.fetchStudents();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(onSearch: _filterStudents),
        Expanded(
          child: FutureBuilder<List<StudentModel>>(
            future: studentsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text("No students found"));
              }

              List<StudentModel> students = snapshot.data!;

              return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  return StudentsListItem(student: students[index]);
                },
              );
            },
          ),
        )
      ],
    );
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        students = students;
      } else {
        students = students
            .where((student) =>
                student.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}
