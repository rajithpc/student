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
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Colors.grey[300],
        backgroundImage:
            (student.imageURL != null && student.imageURL!.isNotEmpty)
                ? NetworkImage(student.imageURL!)
                : const AssetImage('assets/empty_user.jpg') as ImageProvider,
      ),
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
          confirmDelete(context, student.id, student.publicID);
        },
        icon: const Icon(Icons.delete),
      ),
    );
  }
}
