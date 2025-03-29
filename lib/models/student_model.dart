enum GenderType { male, femail, other }

enum DomainType { flutter, python, mearn, dataScience }

class StudentModel {
  final String id;
  final String name;
  final int age;
  final String email;
  final GenderType gender;
  final DomainType domain;

  StudentModel(
      {required this.id,
      required this.name,
      required this.age,
      required this.email,
      required this.gender,
      required this.domain});

  // factory StudentModel.fromMap(String docId, Map<String, dynamic> map) {
  //   return StudentModel(
  //     id: map['id'] ?? '',
  //     name: map['name'] ?? '',
  //     age: map['age'] ?? 0,
  //     email: map['email'] ?? '',
  //     gender: GenderType.values.firstWhere(
  //         (e) => e.toString().split('.').last == map['gender'],
  //         orElse: () => GenderType.other),
  //     domain: DomainType.values.firstWhere(
  //         (e) => e.toString().split('.').last == map['domain'],
  //         orElse: () => DomainType.dataScience),
  //   );
  // }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'gender': gender.name,
      'domain': domain.name,
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> data, String documentId) {
    return StudentModel(
      id: documentId, // Assign Firestore document ID
      name: data['name'],
      age: data['age'],
      email: data['email'],
      gender: GenderType.values.firstWhere((e) => e.name == data['gender']),
      domain: DomainType.values.firstWhere((e) => e.name == data['domain']),
    );
  }
}
