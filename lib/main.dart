import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student ID Card Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const StudentIDFormPage(),
    );
  }
}

class StudentIDFormPage extends StatefulWidget {
  const StudentIDFormPage({super.key});

  @override
  State<StudentIDFormPage> createState() => _StudentIDFormPageState();
}

class _StudentIDFormPageState extends State<StudentIDFormPage> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _programController = TextEditingController();
  final TextEditingController _departmentController = TextEditingController();
  final TextEditingController _countryController = TextEditingController();

  String? studentId;
  String? studentName;
  String? program;
  String? department;
  String? country;
  String? _selectedImagePath;
  
  bool _showCard = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _programController.dispose();
    _departmentController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _toggleView() {
    setState(() {
      if (!_showCard) {
        // Generate card
        studentId = _idController.text.trim();
        studentName = _nameController.text.trim();
        program = _programController.text.trim();
        department = _departmentController.text.trim();
        country = _countryController.text.trim();
        _showCard = true;
      } else {
        // Edit mode
        _showCard = false;
      }
    });
  }

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _selectedImagePath = image.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student ID Card Form'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              if (!_showCard) ...[
                // Image picker section
                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: _selectedImagePath != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              _selectedImagePath!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo, size: 40, color: Colors.grey),
                              SizedBox(height: 8),
                              Text("Tap to select photo", style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _idController,
                  decoration: const InputDecoration(
                    labelText: "Student ID",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Student Name",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _programController,
                  decoration: const InputDecoration(
                    labelText: "Program",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: "Department",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: "Country",
                    border: OutlineInputBorder(),
                  ),
                ),
              ] else ...[
                Card(
                  color: Colors.white,
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_selectedImagePath != null) ...[
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                _selectedImagePath!,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 16),
                        ],
                        Text("Student ID: $studentId", style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text("Student Name: $studentName", style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text("Program: $program", style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text("Department: $department", style: const TextStyle(fontSize: 18)),
                        const SizedBox(height: 8),
                        Text("Country: $country", style: const TextStyle(fontSize: 18)),
                      ],
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _toggleView,
                child: Text(_showCard ? "Edit" : "Generate"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}