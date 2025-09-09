import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../models/user_model.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final UserModel user = UserModel(
      uid: 'user1',
      name: 'Rahul Sharma',
      phone: '1234567890',
      collegeId: 'IITB2020',
      college: 'IIT Bombay',
      course: 'B.Tech',
      branch: 'Computer Science',
      year: 3,
      interests: ['Coding', 'Gaming', 'Music'],
      instagram: '@rahulsharma',
      linkedin: 'linkedin.com/in/rahulsharma',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Edit profile functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 50.0,
              backgroundColor: Colors.blue,
              child: Icon(
                Icons.person,
                size: 50.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              user.name,
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '${user.course} - ${user.branch}, Year ${user.year}',
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            Text(
              user.college,
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8.0),
            AlumniBadge(), // Alumni badge widget
            const SizedBox(height: 24.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Interests',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Wrap(
              spacing: 8.0,
              children: user.interests
                  .map(
                    (interest) => Chip(
                      label: Text(interest),
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 16.0),
            const Divider(),
            const SizedBox(height: 16.0),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Social Links',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            if (user.instagram != null)
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Instagram'),
                subtitle: Text(user.instagram!),
                onTap: () {
                  // Open Instagram
                },
              ),
            if (user.linkedin != null)
              ListTile(
                leading: const Icon(Icons.work),
                title: const Text('LinkedIn'),
                subtitle: Text(user.linkedin!),
                onTap: () {
                  // Open LinkedIn
                },
              ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Logout functionality
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(), // Removed const
                  ),
                  (route) => false,
                );
              },
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}

class AlumniBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Text(
        'Alumni',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class FeedbackWallScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Feedback Wall')),
      body: Center(child: Text('Feedback Wall Feature Coming Soon!')),
    );
  }
}

class SkillShowcaseScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Skill Showcase')),
      body: Center(child: Text('Skill Showcase Feature Coming Soon!')),
    );
  }
}

class MarketplaceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Marketplace')),
      body: Center(child: Text('Marketplace Feature Coming Soon!')),
    );
  }
}

class LeaderboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('College Leaderboard')),
      body: Center(child: Text('Leaderboard Feature Coming Soon!')),
    );
  }
}