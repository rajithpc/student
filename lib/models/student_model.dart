enum GenderType { male, femail, other }

enum DomainType { flutter, python, mearn, dataScience }

class StudentModel {
  final String id;
  final String name;
  final int age;
  final String email;
  final GenderType gender;
  final DomainType domain;
  final String? imageURL;
  final String? publicID;

  StudentModel(
      {required this.id,
      required this.name,
      required this.age,
      required this.email,
      required this.gender,
      required this.domain,
      required this.imageURL,
      required this.publicID});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'email': email,
      'gender': gender.name,
      'domain': domain.name,
      'imageURL': imageURL,
      'publicID': publicID
    };
  }

  factory StudentModel.fromMap(Map<String, dynamic> data, String documentId) {
    return StudentModel(
        id: documentId,
        name: data['name'],
        age: data['age'],
        email: data['email'],
        gender: GenderType.values.firstWhere((e) => e.name == data['gender']),
        domain: DomainType.values.firstWhere((e) => e.name == data['domain']),
        imageURL: data['imageURL'],
        publicID: data['publicID']);
  }
}
