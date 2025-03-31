import 'package:cloud_firestore/cloud_firestore.dart';
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
  DatabaseFuntions database = DatabaseFuntions();
  List<StudentModel> students = [];
  List<StudentModel> filteredStudents = [];
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Search(onSearch: _filterStudents),
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('student').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("Error: ${snapshot.error}"));
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No students found"));
              }

              students = snapshot.data!.docs.map((doc) {
                return StudentModel.fromMap(
                    doc.data() as Map<String, dynamic>, doc.id);
              }).toList();

              if (!isSearching) {
                filteredStudents = List.from(students); // Reset filtered list
              }

              return ListView.builder(
                itemCount: filteredStudents.length,
                itemBuilder: (context, index) {
                  return StudentsListItem(student: filteredStudents[index]);
                },
              );
            },
          ),
        ),
      ],
    );
  }

  void _filterStudents(String query) {
    setState(() {
      if (query.isEmpty) {
        isSearching = false;
        filteredStudents = List.from(students);
      } else {
        isSearching = true;
        filteredStudents = students
            .where((student) =>
                student.name.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }
}
