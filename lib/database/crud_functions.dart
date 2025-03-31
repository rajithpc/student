import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/student_model.dart';
import '../widgets/snackbar_message.dart';

class DatabaseFuntions {
  Future<String> getNextStudentId() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('student').get();

    int maxId = 0;

    for (var doc in snapshot.docs) {
      int? docId = int.tryParse(doc.id);
      if (docId != null && docId > maxId) {
        maxId = docId;
      }
    }

    return (maxId + 1).toString();
  }

  void addStudent(StudentModel student) async {
    String newId = await getNextStudentId();
    StudentModel studentData = StudentModel(
      id: newId,
      name: student.name,
      age: student.age,
      email: student.email,
      gender: student.gender,
      domain: student.domain,
    );

    createStudent(studentData);
  }

  Future<void> createStudent(StudentModel student) async {
    await FirebaseFirestore.instance
        .collection('student')
        .doc(student.id)
        .set(student.toMap());
  }

  Future<List<StudentModel>> fetchStudents() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('student').get();

    return querySnapshot.docs.map((doc) {
      return StudentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  Future<void> updateStudent(StudentModel student, BuildContext context) async {
    await FirebaseFirestore.instance
        .collection('student')
        .doc(student.id)
        .update(student.toMap());

    SnackbarMessage.showSnackbar(
        // ignore: use_build_context_synchronously
        context,
        'Student details updated successfully!');
  }

  Future<void> deleteStudent(String studentId, BuildContext context) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('student').doc(studentId);

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();

      // ignore: use_build_context_synchronously
      SnackbarMessage.showSnackbar(context, 'Student Removed');
    }
  }
}
