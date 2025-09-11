import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/user_model.dart';
import '../widgets/vibe_story_widget.dart';
import '../widgets/add_vibe_widget.dart';

class MyVibesScreen extends StatefulWidget {
  const MyVibesScreen({super.key});

  @override
  State<MyVibesScreen> createState() => _MyVibesScreenState();
}

class _MyVibesScreenState extends State<MyVibesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
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
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          children: [
            Icon(
              Icons.auto_awesome,
              color: Colors.purple[300],
              size: 28,
            ),
            const SizedBox(width: 8),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.purple[300]!,
                  Colors.pink[300]!,
                  Colors.orange[300]!,
                ],
              ).createShader(bounds),
              child: const Text(
                'My Vibes',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add_circle, color: Colors.purple[300]),
            onPressed: () => _showAddVibeDialog(),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildVibesContent(),
      ),
    );
  }

  Widget _buildVibesContent() {
    // Mock data for demonstration
    final List<MyVibe> myVibes = [
      MyVibe(
        id: '1',
        userId: 'user1',
        userName: 'Rahul Sharma',
        userProfileImage: '',
        content: 'Just finished my coding session! 💻✨',
        imageUrl: 'https://picsum.photos/300/400?random=1',
        createdAt: DateTime.now().subtract(const Duration(hours: 2)),
        expiresAt: DateTime.now().add(const Duration(hours: 22)),
        vibeType: 'image',
      ),
      MyVibe(
        id: '2',
        userId: 'user2',
        userName: 'Priya Patel',
        userProfileImage: '',
        content: 'Study vibes only! 📚',
        createdAt: DateTime.now().subtract(const Duration(hours: 4)),
        expiresAt: DateTime.now().add(const Duration(hours: 20)),
        vibeType: 'text',
      ),
      MyVibe(
        id: '3',
        userId: 'user3',
        userName: 'Amit Kumar',
        userProfileImage: '',
        content: 'Campus sunset vibes 🌅',
        imageUrl: 'https://picsum.photos/300/400?random=2',
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        expiresAt: DateTime.now().add(const Duration(hours: 18)),
        vibeType: 'image',
      ),
    ];

    return Column(
      children: [
        // Add your vibe section
        _buildAddYourVibe(),
        const SizedBox(height: 20),
        // Stories section
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: myVibes.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: VibeStoryWidget(
                        vibe: myVibes[index],
                        onTap: () => _viewVibe(myVibes[index]),
                        onReact: () => _reactToVibe(myVibes[index]),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAddYourVibe() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.purple[800]!.withOpacity(0.3),
            Colors.pink[800]!.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.purple[300]!.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.auto_awesome,
            color: Colors.purple[300],
            size: 40,
          ),
          const SizedBox(height: 12),
          const Text(
            'Share Your Vibe',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Let your friends know what you\'re up to!',
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.7),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildVibeTypeButton(
                icon: Icons.text_fields,
                label: 'Text',
                onTap: () => _showAddVibeDialog(type: 'text'),
              ),
              _buildVibeTypeButton(
                icon: Icons.image,
                label: 'Photo',
                onTap: () => _showAddVibeDialog(type: 'image'),
              ),
              _buildVibeTypeButton(
                icon: Icons.videocam,
                label: 'Video',
                onTap: () => _showAddVibeDialog(type: 'video'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVibeTypeButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.purple[300]!.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.purple[300]!.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.purple[300], size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.purple[300],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddVibeDialog({String type = 'text'}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddVibeWidget(
        vibeType: type,
        onVibeAdded: (vibe) {
          // Handle vibe addition
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${type.capitalize()} vibe added!'),
              backgroundColor: Colors.purple[300],
            ),
          );
        },
      ),
    );
  }

  void _viewVibe(MyVibe vibe) {
    // Navigate to full screen vibe viewer
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VibeViewerScreen(vibe: vibe),
      ),
    );
  }

  void _reactToVibe(MyVibe vibe) {
    // Handle vibe reaction
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reacted to ${vibe.userName}\'s vibe!'),
        backgroundColor: Colors.pink[300],
      ),
    );
  }
}

class VibeViewerScreen extends StatefulWidget {
  final MyVibe vibe;

  const VibeViewerScreen({super.key, required this.vibe});

  @override
  State<VibeViewerScreen> createState() => _VibeViewerScreenState();
}

class _VibeViewerScreenState extends State<VibeViewerScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background image or gradient
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.purple[900]!,
                  Colors.pink[900]!,
                  Colors.orange[900]!,
                ],
              ),
            ),
          ),
          
          // Vibe content
          SafeArea(
            child: Column(
              children: [
                // Header
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.more_vert, color: Colors.white),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                
                // Vibe content
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (widget.vibe.imageUrl != null)
                          Container(
                            width: 300,
                            height: 400,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: NetworkImage(widget.vibe.imageUrl!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            widget.vibe.content,
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                
                // Bottom actions
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildActionButton(Icons.favorite_border, 'React'),
                      _buildActionButton(Icons.reply, 'Reply'),
                      _buildActionButton(Icons.share, 'Share'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton(IconData icon, String label) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.white, size: 24),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}

