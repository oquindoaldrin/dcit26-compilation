import 'package:flutter/material.dart';

void main() => runApp(const StudentProfileApp());

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 2 - Student Profile',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1F6B45)),
        useMaterial3: true,
      ),
      home: const StudentProfileScreen(),
    );
  }
}

class StudentProfileScreen extends StatelessWidget {
  const StudentProfileScreen({super.key});

  static const green = Color(0xFF1F6B45);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: green,
        foregroundColor: Colors.white,
        title: const Text('Student Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header card
            Card(
              color: const Color(0xFFE8F3EC),
              elevation: 0,
              child: ListTile(
                contentPadding: const EdgeInsets.all(16),
                leading: const CircleAvatar(
                  radius: 28,
                  backgroundColor: green,
                  child: Icon(Icons.person, color: Colors.white, size: 32),
                ),
                title: const Text(
                  'John Aldrin Oquindo',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                subtitle: const Text('BSCS • 3rd Year • 1st Section'),
              ),
            ),
            const SizedBox(height: 16),
            const ProfileField(label: 'Name', value: 'John Aldrin Oquindo'),
            const ProfileField(label: 'Age', value: '21'),
            const ProfileField(
              label: 'Course/Year/Section',
              value: 'BSCS / 3rd Year / 1st Section',
            ),
            const ProfileField(
              label: 'About me',
              value: 'I am a Computer Science student and i like games.',
            ),
            const ProfileField(
              label: 'Achievements',
              value: 'absolutely nothing, but I am a good person.',
            ),
            const ProfileField(
              label: 'Skills',
              value: 'Dart, Flutter, Git/GitHub, teamwork',
            ),
          ],
        ),
      ),
    );
  }
}

class ProfileField extends StatelessWidget {
  final String label;
  final String value;

  const ProfileField({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: StudentProfileScreen.green,
              ),
            ),
            const SizedBox(height: 4),
            Text(value, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
