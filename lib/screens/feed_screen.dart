import 'package:flutter/material.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';

class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final List<PostModel> posts = [
      PostModel(
        id: '1',
        userId: 'user1',
        userName: 'Rahul Sharma',
        userCollege: 'IIT Bombay',
        content: 'Just finished my exams! Time to relax! 🎉',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isAcademic: false,
        likes: 15,
      ),
      PostModel(
        id: '2',
        userId: 'user2',
        userName: 'Priya Patel',
        userCollege: 'NIT Surathkal',
        content: 'Check out this amazing meme I found! 😂',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isAcademic: false,
        likes: 42,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('YuvaSpace Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add post functionality
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
                      const Text('12'),
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