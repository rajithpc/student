enum GenderType { male, femail, other }

enum DomainType { flutter, python, mearn, dataScience }

class StudentModel {
  final int id;
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

  factory StudentModel.fromMap(String docId, Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      email: map['email'] ?? '',
      gender: GenderType.values.firstWhere(
          (e) => e.toString().split('.').last == map['gender'],
          orElse: () => GenderType.other),
      domain: DomainType.values.firstWhere(
          (e) => e.toString().split('.').last == map['domain'],
          orElse: () => DomainType.dataScience),
    );
  }
}
