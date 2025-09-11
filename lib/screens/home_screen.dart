import 'package:flutter/material.dart';
import 'feed_screen.dart';
import 'academic_feed_screen.dart';
import 'search_screen.dart';
import 'profile_screen.dart';
import 'my_vibes_screen.dart';
import 'study_chat_screen.dart';
import 'study_swap_screen.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const FeedScreen(),
    const MyVibesScreen(),
    const StudyChatScreen(),
    const StudySwapScreen(),
    const AcademicFeedScreen(),
    const SearchScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}