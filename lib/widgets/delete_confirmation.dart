import 'package:flutter/material.dart';
import 'package:student/database/crud_functions.dart';

Future<void> confirmDelete(BuildContext context, String studentId) async {
  DatabaseFuntions database = DatabaseFuntions();
  bool? confirm = await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Confirm Delete"),
        content: const Text("Are you sure you want to delete this student?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true), // Confirm
            child: const Text("Delete", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );

  if (confirm == true) {
    // ignore: use_build_context_synchronously
    database.deleteStudent(studentId, context);
  }
}
