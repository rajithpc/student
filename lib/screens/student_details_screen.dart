import 'package:flutter/material.dart';
import '../models/student_model.dart';
import 'student_form_screen.dart';

class StudentDetailsScreen extends StatelessWidget {
  final StudentModel student;

  const StudentDetailsScreen({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: const Text("Student Details"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person, size: 80, color: Colors.blueAccent),
                  const SizedBox(height: 10),
                  Text(
                    student.name,
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  const Divider(),
                  _buildDetailRow("Age", student.age.toString()),
                  _buildDetailRow("Gender", student.gender.name.toUpperCase()),
                  _buildDetailRow("Domain", student.domain.name.toUpperCase()),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.edit),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StudentFormScreen(student: student),
              ),
            );
          }),
    );
  }

  Widget _buildDetailRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
          Text(value,
              style: const TextStyle(fontSize: 18, color: Colors.blueGrey)),
        ],
      ),
    );
  }
}
