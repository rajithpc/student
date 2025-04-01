import 'package:flutter/material.dart';
import 'package:student/database/crud_functions.dart';

Future<void> confirmDelete(
    BuildContext ctx, String studentId, String? publicID) async {
  DatabaseFuntions database = DatabaseFuntions();

  bool confirm = await showDialog(
        context: ctx,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Confirm Delete"),
            content:
                const Text("Are you sure you want to delete this student?"),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text("Cancel"),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child:
                    const Text("Delete", style: TextStyle(color: Colors.red)),
              ),
            ],
          );
        },
      ) ??
      false;

  if (confirm) {
    // ignore: use_build_context_synchronously
    database.deleteStudent(studentId, ctx, publicID);
  }
}
