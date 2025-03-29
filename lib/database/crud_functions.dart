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
      int? docId = int.tryParse(doc.id); // Convert ID to integer
      if (docId != null && docId > maxId) {
        maxId = docId;
      }
    }

    return (maxId + 1).toString(); // Return next ID as a String
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
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc(student.id)
          .set(student.toMap());

      print("Student added with custom ID: ${student.id}");
    } catch (e) {
      print("Error adding student: $e");
    }
  }

  // Future<List<StudentModel>> fetchStudents() async {
  //   QuerySnapshot snapshot =
  //       await FirebaseFirestore.instance.collection('student').get();

  //   return snapshot.docs.map((doc) {
  //     return StudentModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
  //   }).toList();
  // }

  Future<List<StudentModel>> fetchStudents() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('student').get();

    return querySnapshot.docs.map((doc) {
      return StudentModel.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }

  // Future<void> updateStudent(StudentModel student) async {
  //   try {
  //     await FirebaseFirestore.instance
  //         .collection('student')
  //         .doc(student.id.toString())
  //         .update({
  //       'id': student.id,
  //       'name': student.name,
  //       'age': student.age,
  //       'email': student.email,
  //       'gender': student.gender.name,
  //       'domain': student.domain.name,
  //     });

  //     print("Student updated successfully!");
  //   } catch (e) {
  //     print("Error updating student: $e");
  //   }
  // }

  Future<void> updateStudent(StudentModel student) async {
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc(student.id) // 🔹 Use the same custom ID
          .update(student.toMap());

      print("Student updated successfully!");
    } catch (e) {
      print("Error updating student: $e");
    }
  }

  Future<void> deleteStudent(String studentId, BuildContext context) async {
    DocumentReference docRef =
        FirebaseFirestore.instance.collection('student').doc(studentId);

    DocumentSnapshot doc = await docRef.get();

    if (doc.exists) {
      await docRef.delete();
      SnackbarMessage.showSnackbar(context, 'Student Removed');
    } else {
      print("Error: Student not found!");
    }
  }
}
