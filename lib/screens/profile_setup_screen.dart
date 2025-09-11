import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();
  final TextEditingController _branchController = TextEditingController();
  final TextEditingController _interestsController = TextEditingController();

  String? _selectedCollege;
  final List<String> _colleges = [
    'IIT Bombay',
    'IIT Delhi',
    'IIT Madras',
    'IIT Kanpur',
    'IIT Kharagpur',
    'IIT Roorkee',
    'IIT Guwahati',
    'IIT Hyderabad',
    'NIT Trichy',
    'NIT Surathkal',
    'BITS Pilani',
    'DTU Delhi',
    'NSUT Delhi',
    'VIT Vellore',
    'SRM Chennai',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Complete Your Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 20.0),
              const CircleAvatar(
                radius: 50.0,
                backgroundColor: Colors.blue,
                child: Icon(
                  Icons.person,
                  size: 50.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20.0),
              CustomTextField(
                controller: _nameController,
                hintText: 'Full Name',
                prefixIcon: Icons.person,
              ),
              const SizedBox(height: 15.0),
              DropdownButtonFormField<String>(
                value: _selectedCollege,
                decoration: InputDecoration(
                  hintText: 'Select College',
                  prefixIcon: const Icon(Icons.school),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
                items: _colleges.map((String college) {
                  return DropdownMenuItem<String>(
                    value: college,
                    child: Text(college),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedCollege = newValue;
                  });
                },
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                controller: _courseController,
                hintText: 'Course (e.g., B.Tech, B.Sc, MBBS)',
                prefixIcon: Icons.menu_book,
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                controller: _branchController,
                hintText: 'Branch (e.g., CSE, ECE, Mechanical)',
                prefixIcon: Icons.engineering,
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                controller: _yearController,
                hintText: 'Year (e.g., 1, 2, 3, 4)',
                keyboardType: TextInputType.number,
                prefixIcon: Icons.calendar_today,
              ),
              const SizedBox(height: 15.0),
              CustomTextField(
                controller: _interestsController,
                hintText: 'Interests (comma separated)',
                prefixIcon: Icons.interests,
              ),
              const SizedBox(height: 30.0),
              CustomButton(
                text: 'Complete Setup',
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomeScreen(),
                    ),
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}