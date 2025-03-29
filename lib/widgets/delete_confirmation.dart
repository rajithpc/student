import 'package:flutter/material.dart';
import 'package:student/database/crud_functions.dart';

Future<void> confirmDelete(BuildContext context, String studentId) async {
  DatabaseFuntions database = DatabaseFuntions();
  bool? confirm = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirm Delete"),
        content: Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false), // Cancel
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Confirm
            child: Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );

  if (confirm == true) {
    database.deleteStudent(studentId, context); // Call your delete function
  }
}
