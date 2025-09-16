import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../widgets/post_card.dart';
import '../models/post_model.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> with TickerProviderStateMixin {
  late AnimationController _refreshController;
  late Animation<double> _refreshAnimation;

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _refreshAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _refreshController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final List<PostModel> posts = [
      PostModel(
        id: '1',
        userId: 'user1',
        userName: 'Rahul Sharma',
        userCollege: 'IIT Bombay',
        content: 'Just finished my exams! Time to relax! 🎉\n\nFinally done with all the stress and late-night study sessions. Who else is celebrating?',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
        isAcademic: false,
        likes: 15,
        feedType: FeedType.fun,
        imageUrl: 'https://picsum.photos/400/300?random=1',
      ),
      PostModel(
        id: '2',
        userId: 'user2',
        userName: 'Priya Patel',
        userCollege: 'NIT Surathkal',
        content: 'Check out this amazing meme I found! 😂\n\nThis perfectly describes our college life!',
        timestamp: DateTime.now().subtract(const Duration(hours: 5)),
        isAcademic: false,
        likes: 42,
        feedType: FeedType.fun,
        imageUrl: 'https://picsum.photos/400/300?random=2',
      ),
      PostModel(
        id: '3',
        userId: 'user3',
        userName: 'Amit Kumar',
        userCollege: 'IIIT Hyderabad',
        content: 'Study group session was amazing today! 📚\n\nWe covered so much material and everyone was so helpful. Love this community!',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        isAcademic: true,
        likes: 28,
        feedType: FeedType.academic,
      ),
      PostModel(
        id: '4',
        userId: 'user4',
        userName: 'Sneha Reddy',
        userCollege: 'BITS Pilani',
        content: 'Campus sunset vibes 🌅\n\nSometimes you just need to pause and appreciate the beauty around you.',
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        isAcademic: false,
        likes: 67,
        feedType: FeedType.fun,
        imageUrl: 'https://picsum.photos/400/300?random=3',
      ),
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          // Custom App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF00BFFF).withOpacity(0.1),
                      const Color(0xFF8A2BE2).withOpacity(0.1),
                    ],
                  ),
                ),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Row(
                          children: [
                            // Logo
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                gradient: const LinearGradient(
                                  colors: [Color(0xFF00BFFF), Color(0xFF8A2BE2)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.auto_awesome,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // App Name
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF00BFFF), Color(0xFF8A2BE2)],
                              ).createShader(bounds),
                              child: const Text(
                                'GenZSpace',
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            // Action buttons
                            Row(
                              children: [
                                _buildActionButton(Icons.notifications_outlined, () {}),
                                const SizedBox(width: 8),
                                _buildActionButton(Icons.add_circle_outline, () {}),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Connect.Share.Grow',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.7),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          
          // Stories Section
          SliverToBoxAdapter(
            child: Container(
              height: 100,
              margin: const EdgeInsets.symmetric(vertical: 8),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: 8,
                itemBuilder: (context, index) {
                  return _buildStoryItem(index);
                },
              ),
            ),
          ),
          
          // Posts Section
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: PostCard(
                        post: posts[index],
                        onLike: () => _handleLike(posts[index]),
                        onComment: () => _handleComment(posts[index]),
                        onShare: () => _handleShare(posts[index]),
                      ),
                    ),
                  ),
                );
              },
              childCount: posts.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget _buildStoryItem(int index) {
    final isAddStory = index == 0;
    final colors = [
      const Color(0xFF00BFFF),
      const Color(0xFF8A2BE2),
      const Color(0xFFFF8C00),
      const Color(0xFFFF69B4),
      const Color(0xFF4CC9F0),
      const Color(0xFFF72585),
      const Color(0xFF7209B7),
    ];
    
    return Container(
      width: 70,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {},
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: isAddStory ? null : LinearGradient(
                  colors: [colors[index % colors.length], colors[index % colors.length].withOpacity(0.7)],
                ),
                color: isAddStory ? Colors.grey[800] : null,
                border: Border.all(
                  color: isAddStory ? Colors.grey[600]! : Colors.transparent,
                  width: 2,
                ),
              ),
              child: Icon(
                isAddStory ? Icons.add : Icons.person,
                color: isAddStory ? Colors.grey[400] : Colors.white,
                size: isAddStory ? 24 : 30,
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            isAddStory ? 'Your Story' : 'User ${index}',
            style: TextStyle(
              color: Colors.white.withOpacity(0.7),
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  void _handleLike(PostModel post) {
    setState(() {
      // Mock like functionality
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Liked ${post.userName}\'s post!'),
        backgroundColor: const Color(0xFF00BFFF),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleComment(PostModel post) {
    // Navigate to comments screen
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening comments for ${post.userName}\'s post'),
        backgroundColor: const Color(0xFF8A2BE2),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleShare(PostModel post) {
    // Share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shared ${post.userName}\'s post!'),
        backgroundColor: const Color(0xFFFF8C00),
        duration: const Duration(seconds: 1),
      ),
    );
  }
}