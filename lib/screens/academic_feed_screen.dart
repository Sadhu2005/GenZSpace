import 'package:flutter/material.dart';
import '../models/post_model.dart';

class AcademicFeedScreen extends StatelessWidget {
  const AcademicFeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final List<PostModel> posts = [
      PostModel(
        id: '3',
        userId: 'user3',
        userName: 'Amit Kumar',
        userCollege: 'IIT Delhi',
        content: 'Sharing my notes on Data Structures and Algorithms. Hope it helps!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isAcademic: true,
        likes: 28,
        feedType: FeedType.academic,
      ),
      PostModel(
        id: '4',
        userId: 'user4',
        userName: 'Neha Singh',
        userCollege: 'BITS Pilani',
        content: 'Google is hiring interns for summer 2024. Apply now!',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isAcademic: true,
        likes: 35,
        feedType: FeedType.academic,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Academic Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add academic post functionality
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          posts[index].userName[0].toUpperCase(),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            posts[index].userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          Text(
                            posts[index].userCollege,
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 10.0),
                  Text(posts[index].content),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.favorite_border),
                        onPressed: () {},
                      ),
                      Text('${posts[index].likes}'),
                      const SizedBox(width: 20.0),
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () {},
                      ),
                      const Text('8'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}