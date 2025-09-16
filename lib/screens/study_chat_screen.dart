import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import '../models/user_model.dart';
import '../widgets/chat_bubble_widget.dart';
import '../widgets/chat_input_widget.dart';

class StudyChatScreen extends StatefulWidget {
  const StudyChatScreen({super.key});

  @override
  State<StudyChatScreen> createState() => _StudyChatScreenState();
}

class _StudyChatScreenState extends State<StudyChatScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final ScrollController _scrollController = ScrollController();

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
    _scrollController.dispose();
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
              Icons.chat_bubble_outline,
              color: Colors.blue[300],
              size: 28,
            ),
            const SizedBox(width: 8),
            ShaderMask(
              shaderCallback: (bounds) => LinearGradient(
                colors: [
                  Colors.blue[300]!,
                  Colors.purple[300]!,
                ],
              ).createShader(bounds),
              child: const Text(
                'Study Chat',
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
            icon: Icon(Icons.add, color: Colors.blue[300]),
            onPressed: () => _showNewChatDialog(),
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: _buildChatList(),
      ),
    );
  }

  Widget _buildChatList() {
    // Mock data for demonstration
    final List<StudyChat> chats = [
      StudyChat(
        id: '1',
        name: 'CS Study Group',
        description: 'Data Structures & Algorithms',
        participants: ['user1', 'user2', 'user3'],
        lastMessage: 'Hey, anyone solved the binary tree problem?',
        lastMessageTime: DateTime.now().subtract(const Duration(minutes: 5)),
        lastMessageSender: 'Rahul',
        unreadCount: 3,
        chatType: 'study_group',
        imageUrl: 'https://picsum.photos/100/100?random=1',
      ),
      StudyChat(
        id: '2',
        name: 'Priya Patel',
        description: null,
        participants: ['user1', 'user2'],
        lastMessage: 'Thanks for the notes! 📚',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 2)),
        lastMessageSender: 'Priya',
        unreadCount: 0,
        chatType: 'direct',
        imageUrl: 'https://picsum.photos/100/100?random=2',
      ),
      StudyChat(
        id: '3',
        name: 'Project Team Alpha',
        description: 'Mobile App Development',
        participants: ['user1', 'user2', 'user3', 'user4'],
        lastMessage: 'Meeting at 3 PM today',
        lastMessageTime: DateTime.now().subtract(const Duration(hours: 4)),
        lastMessageSender: 'Amit',
        unreadCount: 1,
        chatType: 'group',
        imageUrl: 'https://picsum.photos/100/100?random=3',
      ),
    ];

    return Column(
      children: [
        // Quick actions
        _buildQuickActions(),
        
        // Chat list
        Expanded(
          child: AnimationLimiter(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: chats.length,
              itemBuilder: (context, index) {
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 600),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: _buildChatItem(chats[index]),
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

  Widget _buildQuickActions() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.blue[800]!.withOpacity(0.3),
            Colors.purple[800]!.withOpacity(0.3),
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.blue[300]!.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildQuickActionButton(
            icon: Icons.group_add,
            label: 'New Group',
            onTap: () => _showNewGroupDialog(),
          ),
          _buildQuickActionButton(
            icon: Icons.person_add,
            label: 'New Chat',
            onTap: () => _showNewChatDialog(),
          ),
          _buildQuickActionButton(
            icon: Icons.school,
            label: 'Study Room',
            onTap: () => _showStudyRoomDialog(),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.blue[300]!.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: Colors.blue[300]!.withOpacity(0.5),
            width: 1,
          ),
        ),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue[300], size: 24),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: Colors.blue[300],
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatItem(StudyChat chat) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: Colors.blue[300],
              backgroundImage: chat.imageUrl != null
                  ? NetworkImage(chat.imageUrl!)
                  : null,
              child: chat.imageUrl == null
                  ? Text(
                      chat.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )
                  : null,
            ),
            if (chat.unreadCount > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 20,
                    minHeight: 20,
                  ),
                  child: Text(
                    '${chat.unreadCount}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
          ],
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                chat.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            if (chat.chatType == 'study_group')
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green[300]!.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  'Study',
                  style: TextStyle(
                    color: Colors.green[300],
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (chat.description != null) ...[
              Text(
                chat.description!,
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 4),
            ],
            Row(
              children: [
                Expanded(
                  child: Text(
                    chat.lastMessage,
                    style: TextStyle(
                      color: Colors.grey[300],
                      fontSize: 14,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _getTimeAgo(chat.lastMessageTime),
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        onTap: () => _openChat(chat),
      ),
    );
  }

  String _getTimeAgo(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else {
      return '${difference.inDays}d';
    }
  }

  void _showNewChatDialog() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildNewChatDialog(),
    );
  }

  Widget _buildNewChatDialog() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.6,
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[600],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Start New Chat',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              children: [
                _buildNewChatOption(
                  icon: Icons.person,
                  title: 'Direct Message',
                  subtitle: 'Chat with a friend',
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to contact selection
                  },
                ),
                _buildNewChatOption(
                  icon: Icons.group,
                  title: 'Create Group',
                  subtitle: 'Start a group chat',
                  onTap: () {
                    Navigator.pop(context);
                    _showNewGroupDialog();
                  },
                ),
                _buildNewChatOption(
                  icon: Icons.school,
                  title: 'Study Group',
                  subtitle: 'Create a study group',
                  onTap: () {
                    Navigator.pop(context);
                    _showStudyGroupDialog();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewChatOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.blue[300]!.withOpacity(0.2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: Colors.blue[300], size: 24),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
      ),
      onTap: onTap,
    );
  }

  void _showNewGroupDialog() {
    // Implementation for new group dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('New Group feature coming soon!'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  void _showStudyRoomDialog() {
    // Implementation for study room dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Study Room feature coming soon!'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showStudyGroupDialog() {
    // Implementation for study group dialog
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Study Group feature coming soon!'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _openChat(StudyChat chat) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatDetailScreen(chat: chat),
      ),
    );
  }
}

class ChatDetailScreen extends StatefulWidget {
  final StudyChat chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            CircleAvatar(
              radius: 18,
              backgroundColor: Colors.blue[300],
              backgroundImage: widget.chat.imageUrl != null
                  ? NetworkImage(widget.chat.imageUrl!)
                  : null,
              child: widget.chat.imageUrl == null
                  ? Text(
                      widget.chat.name[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (widget.chat.description != null)
                    Text(
                      widget.chat.description!,
                      style: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: _getMockMessages().length,
              itemBuilder: (context, index) {
                final message = _getMockMessages()[index];
                return ChatBubbleWidget(
                  message: message,
                  isMe: message.senderId == 'current_user',
                );
              },
            ),
          ),
          
          // Message input
          ChatInputWidget(
            controller: _messageController,
            onSend: _sendMessage,
          ),
        ],
      ),
    );
  }

  List<ChatMessage> _getMockMessages() {
    return [
      ChatMessage(
        id: '1',
        chatId: widget.chat.id,
        senderId: 'user1',
        senderName: 'Rahul',
        content: 'Hey everyone! How\'s the preparation going?',
        messageType: 'text',
        timestamp: DateTime.now().subtract(const Duration(hours: 2)),
      ),
      ChatMessage(
        id: '2',
        chatId: widget.chat.id,
        senderId: 'current_user',
        senderName: 'You',
        content: 'Going well! Just finished the binary tree problems',
        messageType: 'text',
        timestamp: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      ChatMessage(
        id: '3',
        chatId: widget.chat.id,
        senderId: 'user2',
        senderName: 'Priya',
        content: 'Great! Can you share your solution?',
        messageType: 'text',
        timestamp: DateTime.now().subtract(const Duration(minutes: 30)),
      ),
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    ChatMessage(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      chatId: widget.chat.id,
      senderId: 'current_user',
      senderName: 'You',
      content: _messageController.text.trim(),
      messageType: 'text',
      timestamp: DateTime.now(),
    );

    _messageController.clear();
    
    // Scroll to bottom
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
