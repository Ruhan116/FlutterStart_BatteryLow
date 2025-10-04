import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'dart:math';

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
  final _random = Random();

  List<Color> backgroundColors = [
    const Color(0xFF001F4D),
    const Color(0xFF001F4D),
    Colors.white,
    Colors.white,
    const Color(0xFF001F4D),
    const Color(0xFF001F4D),
  ];

  @override
  void dispose() {
    _idController.dispose();
    _nameController.dispose();
    _programController.dispose();
    _departmentController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _generateRandomColors() {
    // Generate 3 random colors
    List<Color> threeColors = List.generate(
      3,
      (_) => Color.fromARGB(
        255,
        _random.nextInt(256),
        _random.nextInt(256),
        _random.nextInt(256),
      ),
    );

    // Repeat each color twice to get 6 elements
    setState(() {
      backgroundColors = [
        threeColors[0],
        threeColors[0],
        threeColors[1],
        threeColors[1],
        threeColors[2],
        threeColors[2],
      ];
    });
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
      backgroundColor: Colors.grey[900],
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
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: "Student Name",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _programController,
                  decoration: const InputDecoration(
                    labelText: "Program",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _departmentController,
                  decoration: const InputDecoration(
                    labelText: "Department",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _countryController,
                  decoration: const InputDecoration(
                    labelText: "Country",
                    border: OutlineInputBorder(),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
              ] else ...[
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: backgroundColors,
                        stops: [0.0, 0.35, 0.35, 0.96, 0.96, 1.0],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 40,
                            height: 40,
                            child: Image(
                              image: AssetImage('assets/images/IUT.png'),
                              fit: BoxFit.contain,
                            ),
                          ),
                          const Text(
                            'Islamic University of Technology',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10),
                          Padding(
                            padding: const EdgeInsets.only(left: 25.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_selectedImagePath != null) ...[
                                  SizedBox(
                                    width: 120,
                                    height: 120,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.network(
                                        _selectedImagePath!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                ],
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.vpn_key, size: 16),
                                    const SizedBox(width: 6),
                                    const Text('Student ID'),
                                  ],
                                ),
                                Card(
                                  color: Colors.blue[200],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(studentId ?? ""),
                                  ),
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.person, size: 16),
                                    const SizedBox(width: 6),
                                    const Text('Student Name'),
                                  ],
                                ),
                                Text("      ${studentName ?? ""}"),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.school, size: 16),
                                    const SizedBox(width: 6),
                                    Text('Program: ${program ?? ""}'),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.computer, size: 16),
                                    const SizedBox(width: 6),
                                    Text('Department ${department ?? ""}'),
                                  ],
                                ),
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.gps_fixed, size: 16),
                                    const SizedBox(width: 6),
                                    Text(country ?? ""),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ]
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: _toggleView,
                    child: Text(_showCard ? "Edit" : "Generate"),
                  ),
                  if (_showCard) ...[
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: _generateRandomColors,
                      child: const Text("Change Colors"),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}