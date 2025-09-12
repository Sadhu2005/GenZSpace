import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../widgets/genz_logo.dart';
import '../services/update_service.dart';

class BootScreen extends StatefulWidget {
  const BootScreen({super.key});

  @override
  State<BootScreen> createState() => _BootScreenState();
}

class _BootScreenState extends State<BootScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  
  final List<String> _codeLines = [];
  final ScrollController _scrollController = ScrollController();
  bool _showLogo = false;
  bool _bootingComplete = false;

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000), // Shorter duration
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeIn),
      ),
    );
    
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.6, 1.0, curve: Curves.elasticOut),
      ),
    );
    
    _startBootSequence();
    
    _controller.forward().then((_) {
      setState(() {
        _bootingComplete = true;
      });
      
      // Check for updates
      UpdateService.checkForUpdates(context);
      
      Future.delayed(const Duration(milliseconds: 300), () {
        try {
          Navigator.pushReplacement(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => const LoginScreen(),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                return FadeTransition(
                  opacity: animation,
                  child: child,
                );
              },
              transitionDuration: const Duration(milliseconds: 500),
            ),
          );
        } catch (e) {
          print('❌ Navigation error: $e');
        }
      });
    });
  }

  void _startBootSequence() {
    _addCodeLineWithDelay("> Initializing GenZ Space OS...", 300);
    _addCodeLineWithDelay("> Loading social modules...", 600);
    _addCodeLineWithDelay("> Establishing secure connections...", 900);
    _addCodeLineWithDelay("> Verifying student credentials...", 1200);
    _addCodeLineWithDelay("> Loading community features...", 1500);
    _addCodeLineWithDelay("> System ready. Welcome to GenZ Space!", 1800);
    
    Future.delayed(const Duration(milliseconds: 2400), () {
      setState(() {
        _showLogo = true;
      });
    });
  }

  void _addCodeLineWithDelay(String line, int delay) {
    Future.delayed(Duration(milliseconds: delay), () {
      _addCodeLine(line);
    });
  }

  void _addCodeLine(String line) {
    setState(() {
      _codeLines.add(line);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Colors.blueGrey[900]!,
                ],
              ),
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _codeLines.length,
              itemBuilder: (context, index) {
                return Text(
                  _codeLines[index],
                  style: TextStyle(
                    color: Colors.green[400],
                    fontFamily: 'Courier',
                    fontSize: 16,
                    height: 1.5,
                  ),
                );
              },
            ),
          ),
          
          if (_showLogo)
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ScaleTransition(
                  scale: _scaleAnimation,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Animated GenZSpace Logo
                      GenZLogo(
                        size: 180,
                        animated: true,
                      ),
                      const SizedBox(height: 20),
                      // App name with gradient text
                      ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            const Color(0xFF00BFFF), // Blue
                            const Color(0xFF8A2BE2), // Purple
                            const Color(0xFFFF8C00), // Orange
                            const Color(0xFFFF69B4), // Pink
                          ],
                        ).createShader(bounds),
                        child: Text(
                          'GenZSpace',
                          style: TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Connect.Share.Grow',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withOpacity(0.8),
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Student-Only Social Network',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withOpacity(0.7),
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (_bootingComplete) ...[
                        const SizedBox(height: 20),
                        const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          strokeWidth: 2,
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}