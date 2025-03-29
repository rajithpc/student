import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:student/database/crud_functions.dart';
import 'package:student/models/student_model.dart';

class StudentFormScreen extends StatefulWidget {
  final StudentModel? student;
  const StudentFormScreen({super.key, required this.student});

  @override
  State<StudentFormScreen> createState() => _StudentFormScreenState();
}

class _StudentFormScreenState extends State<StudentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  GenderType? _selectedGender;
  DomainType? _selectedDomain;

  DatabaseFuntions database = DatabaseFuntions();

  @override
  void initState() {
    super.initState();
    if (widget.student != null) {
      _nameController.text = widget.student!.name;
      _ageController.text = widget.student!.age.toString();
      _emailController.text = widget.student!.email;
      _selectedGender = widget.student!.gender;
      _selectedDomain = widget.student!.domain;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(widget.student == null ? "Add Student" : "Edit Student"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            elevation: 4,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.person, size: 80, color: Colors.blueAccent),
                  const SizedBox(height: 10),
                  const Divider(),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _nameController,
                          decoration:
                              const InputDecoration(labelText: "Student Name"),
                          validator: (value) =>
                              value!.isEmpty ? "Enter student name" : null,
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _ageController,
                          decoration: const InputDecoration(labelText: "Age"),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          validator: (value) {
                            if (value!.isEmpty) return "Enter age";
                            if (int.tryParse(value) == null) {
                              return "Enter a valid number";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(labelText: "Email"),
                          validator: (value) =>
                              value!.isEmpty ? "Enter email" : null,
                        ),
                        DropdownButtonFormField<GenderType>(
                          value: _selectedGender,
                          decoration:
                              const InputDecoration(labelText: "Gender"),
                          items: GenderType.values.map((gender) {
                            return DropdownMenuItem(
                              value: gender,
                              child: Text(gender.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedGender = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? "Select gender" : null,
                        ),
                        const SizedBox(height: 10),
                        DropdownButtonFormField<DomainType>(
                          value: _selectedDomain,
                          decoration:
                              const InputDecoration(labelText: "Domain"),
                          items: DomainType.values.map((domain) {
                            return DropdownMenuItem(
                              value: domain,
                              child: Text(domain.name.toUpperCase()),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _selectedDomain = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? "Select domain" : null,
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(150, 50),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("Cancel"),
                            ),
                            ElevatedButton(
                              onPressed: _saveStudent,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                minimumSize: const Size(150, 50),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: const Text("Save"),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _saveStudent() {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      int age = int.parse(_ageController.text.trim());
      String email = _emailController.text.trim();

      StudentModel studentData = StudentModel(
          id: widget.student == null ? '0' : widget.student!.id,
          name: name,
          age: age,
          email: email,
          gender: _selectedGender!,
          domain: _selectedDomain!);
      widget.student == null
          ? database.addStudent(studentData)
          : database.updateStudent(studentData);
      Navigator.pop(context, studentData);
    }
  }

  void editStudent(String studentId) {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text.trim();
      int age = int.parse(_ageController.text.trim());
      String email = _emailController.text.trim();

      StudentModel studentData = StudentModel(
          id: widget.student!.id,
          name: name,
          age: age,
          email: email,
          gender: _selectedGender!,
          domain: _selectedDomain!);
      database.updateStudent(studentData);
      Navigator.pop(context, studentData);
    }
  }
}
