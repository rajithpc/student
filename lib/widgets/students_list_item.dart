import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../screens/student_details_screen.dart';
import 'delete_confirmation.dart';

class StudentsListItem extends StatelessWidget {
  final StudentModel student;
  const StudentsListItem({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: const Icon(Icons.no_accounts_rounded),
        title: Text(student.name),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDetailsScreen(student: student),
            ),
          );
        },
        trailing: IconButton(
          onPressed: () {
            confirmDelete(context, student.id);
          },
          icon: const Icon(Icons.delete),
        ));
  }
}
