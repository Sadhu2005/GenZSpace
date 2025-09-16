import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/post_model.dart';

class PostCard extends StatefulWidget {
  final PostModel post;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const PostCard({
    super.key,
    required this.post,
    required this.onLike,
    required this.onComment,
    required this.onShare,
  });

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> with TickerProviderStateMixin {
  bool _isLiked = false;
  bool _isExpanded = false;
  late AnimationController _likeController;
  late Animation<double> _likeAnimation;

  @override
  void initState() {
    super.initState();
    _isLiked = widget.post.likedBy.isNotEmpty;
    _likeController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _likeAnimation = Tween<double>(begin: 1.0, end: 1.3).animate(
      CurvedAnimation(parent: _likeController, curve: Curves.elasticOut),
    );
  }

  @override
  void dispose() {
    _likeController.dispose();
    super.dispose();
  }

  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    _likeController.forward().then((_) {
      _likeController.reverse();
    });
    widget.onLike();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[800]!,
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with user info
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // Profile picture with gradient border
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [
                        _getGradientColor(widget.post.userId.hashCode),
                        _getGradientColor(widget.post.userId.hashCode).withOpacity(0.7),
                      ],
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: CircleAvatar(
                    radius: 20,
                    backgroundColor: Colors.grey[800],
                    child: Text(
                      widget.post.userName[0].toUpperCase(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.post.userName,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                              color: Colors.white,
                            ),
                          ),
                          if (widget.post.isAcademic) ...[
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CC9F0).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color: const Color(0xFF4CC9F0).withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: const Text(
                                'Academic',
                                style: TextStyle(
                                  color: Color(0xFF4CC9F0),
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            widget.post.userCollege,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '•',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 12.0,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            _formatTime(widget.post.timestamp),
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: 12.0,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.more_vert,
                    color: Colors.grey[400],
                  ),
                  onPressed: () => _showPostOptions(),
                ),
              ],
            ),
          ),
          
          // Post content with expandable text
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: GestureDetector(
              onTap: _toggleExpand,
              child: Text(
                widget.post.content,
                maxLines: _isExpanded ? null : 3,
                overflow: _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  height: 1.4,
                ),
              ),
            ),
          ),
          
          if (widget.post.imageUrl != null) ...[
            const SizedBox(height: 12.0),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                  imageUrl: widget.post.imageUrl!,
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    height: 250,
                    color: Colors.grey[800],
                    child: const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF00BFFF),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    height: 250,
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.error,
                      color: Colors.grey,
                      size: 50,
                    ),
                  ),
                ),
              ),
            ),
          ],
          
          const SizedBox(height: 16.0),
          
          // Like, comment, share stats
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                AnimatedBuilder(
                  animation: _likeAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _likeAnimation.value,
                      child: Icon(
                        Icons.favorite,
                        size: 16,
                        color: _isLiked ? const Color(0xFFF72585) : Colors.grey[600],
                      ),
                    );
                  },
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.post.likes}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 16),
                Icon(
                  Icons.comment_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  '${widget.post.comments.length}',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Spacer(),
                Icon(
                  Icons.share_outlined,
                  size: 16,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 4),
                Text(
                  'Share',
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 12.0),
          Container(
            height: 0.5,
            color: Colors.grey[800],
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
          ),
          const SizedBox(height: 8.0),
          
          // Action buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _ActionButton(
                  icon: _isLiked ? Icons.favorite : Icons.favorite_border,
                  label: 'Like',
                  color: _isLiked ? const Color(0xFFF72585) : Colors.grey[400]!,
                  onPressed: _toggleLike,
                ),
                _ActionButton(
                  icon: Icons.comment_outlined,
                  label: 'Comment',
                  color: Colors.grey[400]!,
                  onPressed: widget.onComment,
                ),
                _ActionButton(
                  icon: Icons.share_outlined,
                  label: 'Share',
                  color: Colors.grey[400]!,
                  onPressed: widget.onShare,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16.0),
        ],
      ),
    );
  }

  Color _getGradientColor(int seed) {
    final colors = [
      const Color(0xFF00BFFF),
      const Color(0xFF8A2BE2),
      const Color(0xFFFF8C00),
      const Color(0xFFFF69B4),
      const Color(0xFF4CC9F0),
      const Color(0xFFF72585),
      const Color(0xFF7209B7),
    ];
    return colors[seed.abs() % colors.length];
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d';
    } else {
      return '${timestamp.day}/${timestamp.month}';
    }
  }

  void _showPostOptions() {
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
            _buildOptionItem(Icons.bookmark_outline, 'Save Post', () {}),
            _buildOptionItem(Icons.link, 'Copy Link', () {}),
            _buildOptionItem(Icons.report_outlined, 'Report', () {}),
            _buildOptionItem(Icons.block, 'Block User', () {}),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.grey[400]),
      title: Text(
        title,
        style: const TextStyle(color: Colors.white),
      ),
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.color = Colors.grey,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 6),
                Text(
                  label,
                  style: TextStyle(
                    color: color,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}