import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/post_model.dart';
import '../widgets/post_card.dart';

class AcademicFeedScreen extends StatefulWidget {
  const AcademicFeedScreen({super.key});

  @override
  State<AcademicFeedScreen> createState() => _AcademicFeedScreenState();
}

class _AcademicFeedScreenState extends State<AcademicFeedScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  String _selectedFilter = 'All';

  final List<String> _filters = [
    'All',
    'Study Notes',
    'Opportunities',
    'Research',
    'Projects',
    'Events',
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    // Animation setup removed
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                      const Color(0xFF4CC9F0).withOpacity(0.1),
                      const Color(0xFF00BFFF).withOpacity(0.1),
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
                                  colors: [Color(0xFF4CC9F0), Color(0xFF00BFFF)],
                                ),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Icon(
                                Icons.school,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            // App Name
                            ShaderMask(
                              shaderCallback: (bounds) => const LinearGradient(
                                colors: [Color(0xFF4CC9F0), Color(0xFF00BFFF)],
                              ).createShader(bounds),
                              child: const Text(
                                'Academic Feed',
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
                                _buildActionButton(Icons.filter_list, () => _showFilterDialog()),
                                const SizedBox(width: 8),
                                _buildActionButton(Icons.add_circle_outline, () => _showAddPostDialog()),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Knowledge.Share.Grow',
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
          
          // Quick Stats Section
          SliverToBoxAdapter(
            child: _buildQuickStats(),
          ),
          
          // Filter Chips
          SliverToBoxAdapter(
            child: _buildFilterChips(),
          ),
          
          // Academic Posts
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final posts = _getAcademicPosts();
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
              childCount: _getAcademicPosts().length,
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

  Widget _buildQuickStats() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4CC9F0).withOpacity(0.2),
            const Color(0xFF00BFFF).withOpacity(0.2),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: const Color(0xFF4CC9F0).withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Study Notes', '1.2K', Icons.article_outlined),
          _buildStatItem('Opportunities', '45', Icons.work_outline),
          _buildStatItem('Research', '89', Icons.science_outlined),
          _buildStatItem('Projects', '156', Icons.code_outlined),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String count, IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          color: const Color(0xFF4CC9F0),
          size: 24,
        ),
        const SizedBox(height: 8),
        Text(
          count,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.7),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final filter = _filters[index];
          final isSelected = _selectedFilter == filter;
          
          return Container(
            margin: const EdgeInsets.only(right: 8),
            child: GestureDetector(
              onTap: () => setState(() => _selectedFilter = filter),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF4CC9F0).withOpacity(0.2)
                      : Colors.grey[800],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF4CC9F0)
                        : Colors.grey[700]!,
                    width: 1,
                  ),
                ),
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected
                        ? const Color(0xFF4CC9F0)
                        : Colors.grey[400],
                    fontSize: 14,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<PostModel> _getAcademicPosts() {
    // Mock data for demonstration
    final List<PostModel> posts = [
      PostModel(
        id: '1',
        userId: 'user1',
        userName: 'Dr. Rajesh Kumar',
        userCollege: 'IIT Bombay',
        content: '📚 Sharing comprehensive notes on Machine Learning algorithms. These notes cover everything from basic concepts to advanced implementations. Perfect for students preparing for interviews or exams!\n\nTopics covered:\n• Linear Regression\n• Decision Trees\n• Neural Networks\n• Deep Learning\n\nDownload link in comments!',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
        isAcademic: true,
        likes: 128,
        feedType: FeedType.academic,
        imageUrl: 'https://picsum.photos/400/300?random=10',
      ),
      PostModel(
        id: '2',
        userId: 'user2',
        userName: 'Priya Sharma',
        userCollege: 'NIT Surathkal',
        content: '🎯 Google Summer of Code 2024 applications are now open! This is a great opportunity for students to work on open-source projects and get paid. I\'ve compiled a list of organizations that are looking for contributors.\n\nKey dates:\n• Application deadline: March 19, 2024\n• Results: May 1, 2024\n• Coding period: May 27 - August 19, 2024\n\nDM me for application tips!',
        timestamp: DateTime.now().subtract(const Duration(hours: 3)),
        isAcademic: true,
        likes: 89,
        feedType: FeedType.academic,
        imageUrl: 'https://picsum.photos/400/300?random=11',
      ),
      PostModel(
        id: '3',
        userId: 'user3',
        userName: 'Amit Patel',
        userCollege: 'IIIT Hyderabad',
        content: '🔬 Excited to share our research paper on "Quantum Computing Applications in Cryptography" has been accepted at IEEE Conference! This work explores how quantum algorithms can enhance security protocols.\n\nKey findings:\n• 40% improvement in encryption speed\n• Enhanced security against quantum attacks\n• Practical implementation strategies\n\nFull paper available on arXiv. Link in bio!',
        timestamp: DateTime.now().subtract(const Duration(hours: 6)),
        isAcademic: true,
        likes: 156,
        feedType: FeedType.academic,
        imageUrl: 'https://picsum.photos/400/300?random=12',
      ),
      PostModel(
        id: '4',
        userId: 'user4',
        userName: 'Neha Reddy',
        userCollege: 'BITS Pilani',
        content: '💻 Just completed my final year project on "AI-Powered Campus Navigation System"! The app helps students navigate campus buildings using computer vision and AR technology.\n\nFeatures:\n• Real-time navigation\n• AR overlays for directions\n• Accessibility features\n• Offline mode support\n\nOpen source on GitHub! Contributions welcome.',
        timestamp: DateTime.now().subtract(const Duration(hours: 8)),
        isAcademic: true,
        likes: 203,
        feedType: FeedType.academic,
        imageUrl: 'https://picsum.photos/400/300?random=13',
      ),
      PostModel(
        id: '5',
        userId: 'user5',
        userName: 'Vikram Singh',
        userCollege: 'IIT Delhi',
        content: '📊 Hackathon Alert! TechFest 2024 is organizing a 48-hour hackathon on "Sustainable Technology Solutions". Prizes worth ₹5 lakhs!\n\nTracks:\n• Green Energy\n• Waste Management\n• Climate Monitoring\n• Sustainable Agriculture\n\nRegistration closes in 3 days. Team up and let\'s build something amazing!',
        timestamp: DateTime.now().subtract(const Duration(hours: 12)),
        isAcademic: true,
        likes: 67,
        feedType: FeedType.academic,
        imageUrl: 'https://picsum.photos/400/300?random=14',
      ),
    ];

    // Filter posts based on selected filter
    if (_selectedFilter == 'All') {
      return posts;
    } else {
      // Simple keyword-based filtering
      return posts.where((post) {
        final content = post.content.toLowerCase();
        switch (_selectedFilter) {
          case 'Study Notes':
            return content.contains('notes') || content.contains('study');
          case 'Opportunities':
            return content.contains('hiring') || content.contains('intern') || content.contains('job');
          case 'Research':
            return content.contains('research') || content.contains('paper') || content.contains('study');
          case 'Projects':
            return content.contains('project') || content.contains('github') || content.contains('build');
          case 'Events':
            return content.contains('hackathon') || content.contains('event') || content.contains('conference');
          default:
            return true;
        }
      }).toList();
    }
  }

  void _handleLike(PostModel post) {
    setState(() {
      // Mock like functionality
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Liked ${post.userName}\'s academic post!'),
        backgroundColor: const Color(0xFF4CC9F0),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleComment(PostModel post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Opening comments for ${post.userName}\'s post'),
        backgroundColor: const Color(0xFF00BFFF),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _handleShare(PostModel post) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Shared ${post.userName}\'s academic content!'),
        backgroundColor: const Color(0xFF4CC9F0),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showFilterDialog() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[600],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Filter Academic Content',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ..._filters.map((filter) => ListTile(
              title: Text(
                filter,
                style: const TextStyle(color: Colors.white),
              ),
              trailing: _selectedFilter == filter
                  ? const Icon(Icons.check, color: Color(0xFF4CC9F0))
                  : null,
              onTap: () {
                setState(() => _selectedFilter = filter);
                Navigator.pop(context);
              },
            )),
          ],
        ),
      ),
    );
  }

  void _showAddPostDialog() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Add Academic Post feature coming soon!'),
        backgroundColor: Color(0xFF4CC9F0),
      ),
    );
  }
}