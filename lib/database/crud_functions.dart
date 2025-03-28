import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/student_model.dart';

class DatabaseFuntions {
  Future<int> getNextStudentId() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('student').get();
    return snapshot.docs.length + 1;
  }

  void addData(StudentModel student) async {
    int newId = await getNextStudentId();
    await FirebaseFirestore.instance.collection('student').add({
      'id': newId,
      'name': student.name,
      'age': student.age,
      'email': student.email,
      'gender': student.gender.name,
      'domain': student.domain.name,
    });
  }

  Future<List<StudentModel>> fetchStudents() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('student').get();

    return snapshot.docs.map((doc) {
      return StudentModel.fromMap(doc.id, doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<void> updateStudent(StudentModel student) async {
    try {
      await FirebaseFirestore.instance
          .collection('student')
          .doc(student.id.toString())
          .update({
        'id': student.id,
        'name': student.name,
        'age': student.age,
        'email': student.email,
        'gender': student.gender.name,
        'domain': student.domain.name,
      });

      print("Student updated successfully!");
    } catch (e) {
      print("Error updating student: $e");
    }
  }
}
