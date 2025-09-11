import 'package:flutter/material.dart';
import '../models/user_model.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  // Mock data for demonstration
  final List<UserModel> _users = [
    UserModel(
      uid: 'user1',
      name: 'Rahul Sharma',
      phone: '1234567890',
      collegeId: 'IITB2020',
      college: 'IIT Bombay',
      course: 'B.Tech',
      branch: 'Computer Science',
      year: 3,
      interests: ['Coding', 'Gaming', 'Music'],
      joinedAt: DateTime.now().subtract(const Duration(days: 30)),
    ),
    UserModel(
      uid: 'user2',
      name: 'Priya Patel',
      phone: '0987654321',
      collegeId: 'NITK2021',
      college: 'NIT Surathkal',
      course: 'B.Tech',
      branch: 'Electronics',
      year: 2,
      interests: ['Dancing', 'Photography', 'Art'],
      joinedAt: DateTime.now().subtract(const Duration(days: 25)),
    ),
    UserModel(
      uid: 'user3',
      name: 'Amit Kumar',
      phone: '1122334455',
      collegeId: 'IITD2019',
      college: 'IIT Delhi',
      course: 'B.Tech',
      branch: 'Mechanical',
      year: 4,
      interests: ['Sports', 'Reading', 'Traveling'],
      joinedAt: DateTime.now().subtract(const Duration(days: 20)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Students'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name, college, branch...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                if (_searchQuery.isEmpty ||
                    user.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    user.college.toLowerCase().contains(_searchQuery.toLowerCase()) ||
                    user.branch.toLowerCase().contains(_searchQuery.toLowerCase())) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          user.name[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(user.name),
                      subtitle: Text('${user.course} - ${user.branch}, Year ${user.year}'),
                      trailing: const Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        // Navigate to user profile
                      },
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}