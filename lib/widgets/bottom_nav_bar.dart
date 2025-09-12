import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.black.withOpacity(0.95),
            Colors.black,
          ],
        ),
        border: Border(
          top: BorderSide(
            color: Colors.grey[800]!.withOpacity(0.3),
            width: 0.5,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(0, Icons.home_outlined, Icons.home, 'Feed'),
              _buildNavItem(1, Icons.auto_awesome_outlined, Icons.auto_awesome, 'Vibes'),
              _buildNavItem(2, Icons.chat_bubble_outline, Icons.chat_bubble, 'Chat'),
              _buildNavItem(3, Icons.swap_horiz_outlined, Icons.swap_horiz, 'Swap'),
              _buildNavItem(4, Icons.school_outlined, Icons.school, 'Academic'),
              _buildNavItem(5, Icons.search_outlined, Icons.search, 'Search'),
              _buildNavItem(6, Icons.person_outline, Icons.person, 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, IconData activeIcon, String label) {
    final isSelected = currentIndex == index;
    
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: isSelected ? LinearGradient(
            colors: [
              _getGradientColor(index).withOpacity(0.2),
              _getGradientColor(index).withOpacity(0.1),
            ],
          ) : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? _getGradientColor(index).withOpacity(0.2) : null,
              ),
              child: Icon(
                isSelected ? activeIcon : icon,
                color: isSelected ? _getGradientColor(index) : Colors.grey[600],
                size: isSelected ? 24 : 22,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                color: isSelected ? _getGradientColor(index) : Colors.grey[600],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getGradientColor(int index) {
    switch (index) {
      case 0: return const Color(0xFF00BFFF); // Blue
      case 1: return const Color(0xFF8A2BE2); // Purple
      case 2: return const Color(0xFFFF8C00); // Orange
      case 3: return const Color(0xFFFF69B4); // Pink
      case 4: return const Color(0xFF4CC9F0); // Cyan
      case 5: return const Color(0xFFF72585); // Magenta
      case 6: return const Color(0xFF7209B7); // Deep Purple
      default: return const Color(0xFF00BFFF);
    }
  }
}