import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/user_model.dart';

class VibeStoryWidget extends StatefulWidget {
  final MyVibe vibe;
  final VoidCallback onTap;
  final VoidCallback onReact;

  const VibeStoryWidget({
    super.key,
    required this.vibe,
    required this.onTap,
    required this.onReact,
  });

  @override
  State<VibeStoryWidget> createState() => _VibeStoryWidgetState();
}

class _VibeStoryWidgetState extends State<VibeStoryWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    
    _controller.repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: _getVibeGradient(),
                  boxShadow: [
                    BoxShadow(
                      color: _getVibeColor().withOpacity(0.3 + _glowAnimation.value * 0.2),
                      blurRadius: 15 + _glowAnimation.value * 10,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Stack(
                  children: [
                    // Background image or pattern
                    if (widget.vibe.imageUrl != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: CachedNetworkImage(
                          imageUrl: widget.vibe.imageUrl!,
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                          placeholder: (context, url) => Container(
                            color: _getVibeColor().withOpacity(0.3),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: _getVibeColor(),
                              ),
                            ),
                          ),
                          errorWidget: (context, url, error) => Container(
                            color: _getVibeColor().withOpacity(0.3),
                            child: Icon(
                              Icons.image,
                              color: _getVibeColor(),
                              size: 50,
                            ),
                          ),
                        ),
                      ),
                    
                    // Gradient overlay
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                    
                    // Content
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // User info
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 20,
                                backgroundColor: _getVibeColor(),
                                child: Text(
                                  widget.vibe.userName[0].toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.vibe.userName,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      _getTimeAgo(),
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // Vibe type indicator
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: _getVibeColor().withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      _getVibeIcon(),
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                    const SizedBox(width: 4),
                                    Text(
                                      widget.vibe.vibeType.toUpperCase(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          
                          const Spacer(),
                          
                          // Vibe content
                          Text(
                            widget.vibe.content,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Bottom row
                          Row(
                            children: [
                              // View count
                              Icon(
                                Icons.visibility,
                                color: Colors.white.withOpacity(0.8),
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.vibe.viewedBy.length}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 16),
                              
                              // Reaction count
                              Icon(
                                Icons.favorite,
                                color: Colors.pink[300],
                                size: 16,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                '${widget.vibe.reactedBy.length}',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 12,
                                ),
                              ),
                              const Spacer(),
                              
                              // Expiry indicator
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  _getExpiryTime(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    
                    // Tap to view overlay
                    Positioned.fill(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(20),
                          onTap: widget.onTap,
                          onLongPress: widget.onReact,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  LinearGradient _getVibeGradient() {
    switch (widget.vibe.vibeType) {
      case 'text':
        return LinearGradient(
          colors: [
            Colors.purple[600]!,
            Colors.pink[600]!,
          ],
        );
      case 'image':
        return LinearGradient(
          colors: [
            Colors.blue[600]!,
            Colors.purple[600]!,
          ],
        );
      case 'video':
        return LinearGradient(
          colors: [
            Colors.orange[600]!,
            Colors.red[600]!,
          ],
        );
      default:
        return LinearGradient(
          colors: [
            Colors.purple[600]!,
            Colors.pink[600]!,
          ],
        );
    }
  }

  Color _getVibeColor() {
    switch (widget.vibe.vibeType) {
      case 'text':
        return Colors.purple[300]!;
      case 'image':
        return Colors.blue[300]!;
      case 'video':
        return Colors.orange[300]!;
      default:
        return Colors.purple[300]!;
    }
  }

  IconData _getVibeIcon() {
    switch (widget.vibe.vibeType) {
      case 'text':
        return Icons.text_fields;
      case 'image':
        return Icons.image;
      case 'video':
        return Icons.videocam;
      default:
        return Icons.auto_awesome;
    }
  }

  String _getTimeAgo() {
    final now = DateTime.now();
    final difference = now.difference(widget.vibe.createdAt);
    
    if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  String _getExpiryTime() {
    final now = DateTime.now();
    final difference = widget.vibe.expiresAt.difference(now);
    
    if (difference.inHours > 0) {
      return '${difference.inHours}h left';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m left';
    } else {
      return 'Expired';
    }
  }
}
