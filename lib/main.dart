import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Enrollment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
        useMaterial3: true,
      ),
      home: const RegistrationPage(),
    );
  }
}

// ============================================================
// PAGE 1 - USER REGISTRATION
// ============================================================

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final nameController = TextEditingController();
  final sectionController = TextEditingController();
  final courseController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    sectionController.dispose();
    courseController.dispose();
    super.dispose();
  }

  void nextPage() {
    if (nameController.text.trim().isEmpty ||
        sectionController.text.trim().isEmpty ||
        courseController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in all fields.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectEnrollmentPage(
          name: nameController.text.trim(),
          section: sectionController.text.trim(),
          course: courseController.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Registration'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              const Text(
                'Student Information',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: sectionController,
                decoration: const InputDecoration(
                  labelText: 'Section',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.class_),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: courseController,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
              ),

              const Spacer(),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: nextPage,
                  child: const Text(
                    'Next',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PAGE 2 - SUBJECT ENROLLMENT
// ============================================================

class SubjectEnrollmentPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;

  const SubjectEnrollmentPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
  });

  @override
  State<SubjectEnrollmentPage> createState() =>
      _SubjectEnrollmentPageState();
}

class _SubjectEnrollmentPageState
    extends State<SubjectEnrollmentPage> {
  final subject1Controller = TextEditingController();
  final time1Controller = TextEditingController();

  final subject2Controller = TextEditingController();
  final time2Controller = TextEditingController();

  @override
  void dispose() {
    subject1Controller.dispose();
    time1Controller.dispose();
    subject2Controller.dispose();
    time2Controller.dispose();
    super.dispose();
  }

  void nextPage() {
    if (subject1Controller.text.trim().isEmpty ||
        time1Controller.text.trim().isEmpty ||
        subject2Controller.text.trim().isEmpty ||
        time2Controller.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill in both subjects and times.'),
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SubjectVerificationPage(
          name: widget.name,
          section: widget.section,
          course: widget.course,
          subject1: subject1Controller.text.trim(),
          time1: time1Controller.text.trim(),
          subject2: subject2Controller.text.trim(),
          time2: time2Controller.text.trim(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Enrollment'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 10),

              const Text(
                'Enter Subjects',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: subject1Controller,
                decoration: const InputDecoration(
                  labelText: 'Subject 1',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: time1Controller,
                decoration: const InputDecoration(
                  labelText: 'Time 1',
                  hintText: 'Example: 8:00 AM - 9:00 AM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),

              const SizedBox(height: 25),

              TextField(
                controller: subject2Controller,
                decoration: const InputDecoration(
                  labelText: 'Subject 2',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.book),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: time2Controller,
                decoration: const InputDecoration(
                  labelText: 'Time 2',
                  hintText: 'Example: 10:00 AM - 11:00 AM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('Back'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      onPressed: nextPage,
                      child: const Text('Next'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ============================================================
// PAGE 3 - SUBJECT VERIFICATION
// ============================================================

class SubjectVerificationPage extends StatefulWidget {
  final String name;
  final String section;
  final String course;

  final String subject1;
  final String time1;

  final String subject2;
  final String time2;

  const SubjectVerificationPage({
    super.key,
    required this.name,
    required this.section,
    required this.course,
    required this.subject1,
    required this.time1,
    required this.subject2,
    required this.time2,
  });

  @override
  State<SubjectVerificationPage> createState() =>
      _SubjectVerificationPageState();
}

class _SubjectVerificationPageState
    extends State<SubjectVerificationPage> {
  bool isSaving = false;

  Future<void> saveData() async {
    setState(() {
      isSaving = true;
    });

    try {
      await FirebaseFirestore.instance
          .collection('students')
          .add({
        'name': widget.name,
        'section': widget.section,
        'course': widget.course,

        'subject1': widget.subject1,
        'time1': widget.time1,

        'subject2': widget.subject2,
        'time2': widget.time2,

        'createdAt': FieldValue.serverTimestamp(),
      });

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Student enrollment saved successfully!',
          ),
          backgroundColor: Colors.green,
        ),
      );

      // Return to the first page after saving.
      Navigator.of(context).popUntil(
        (route) => route.isFirst,
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Error saving data: $e',
          ),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isSaving = false;
        });
      }
    }
  }

  Widget infoRow(String title, String value) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
          children: [
            TextSpan(
              text: '$title: ',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextSpan(text: value),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Subject Verification'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Please verify your information',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 20),

              infoRow('Name', widget.name),
              infoRow('Section', widget.section),
              infoRow('Course', widget.course),

              const SizedBox(height: 10),

              const Text(
                'Enrolled Subjects',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 12),

              infoRow(
                '1. ${widget.subject1}',
                widget.time1,
              ),

              infoRow(
                '2. ${widget.subject2}',
                widget.time2,
              ),

              const Spacer(),

              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: isSaving
                          ? null
                          : () {
                              Navigator.pop(context);
                            },
                      child: const Text('Back'),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton(
                        onPressed: isSaving ? null : saveData,
                        child: isSaving
                            ? const SizedBox(
                                width: 22,
                                height: 22,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Save',
                                style: TextStyle(
                                  fontSize: 17,
                                ),
                              ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}