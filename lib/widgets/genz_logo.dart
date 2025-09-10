import 'package:flutter/material.dart';
import 'dart:math' as math;

class GenZLogo extends StatefulWidget {
  final double size;
  final bool animated;
  final Duration animationDuration;

  const GenZLogo({
    super.key,
    this.size = 200.0,
    this.animated = true,
    this.animationDuration = const Duration(seconds: 2),
  });

  @override
  State<GenZLogo> createState() => _GenZLogoState();
}

class _GenZLogoState extends State<GenZLogo>
    with TickerProviderStateMixin {
  late AnimationController _glowController;
  late AnimationController _pulseController;
  late AnimationController _circuitController;
  late Animation<double> _glowAnimation;
  late Animation<double> _pulseAnimation;
  late Animation<double> _circuitAnimation;

  @override
  void initState() {
    super.initState();
    
    _glowController = AnimationController(
      duration: widget.animationDuration,
      vsync: this,
    );
    
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    
    _circuitController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _glowController, curve: Curves.easeInOut),
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _circuitAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _circuitController, curve: Curves.linear),
    );

    if (widget.animated) {
      _glowController.repeat(reverse: true);
      _pulseController.repeat(reverse: true);
      _circuitController.repeat();
    }
  }

  @override
  void dispose() {
    _glowController.dispose();
    _pulseController.dispose();
    _circuitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([_glowAnimation, _pulseAnimation, _circuitAnimation]),
      builder: (context, child) {
        return Transform.scale(
          scale: _pulseAnimation.value,
          child: Container(
            width: widget.size,
            height: widget.size,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Speech bubble background with glow
                _buildSpeechBubble(),
                // India map with circuit pattern
                _buildIndiaMap(),
                // Circuit connections
                _buildCircuitPattern(),
                // Play button in center
                _buildPlayButton(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSpeechBubble() {
    return Container(
      width: widget.size * 0.8,
      height: widget.size * 0.6,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          width: 3,
          color: _getGradientColor(0.0).withOpacity(0.8 + _glowAnimation.value * 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: _getGradientColor(0.0).withOpacity(0.3 + _glowAnimation.value * 0.2),
            blurRadius: 20 + _glowAnimation.value * 10,
            spreadRadius: 2,
          ),
        ],
      ),
    );
  }

  Widget _buildIndiaMap() {
    return CustomPaint(
      size: Size(widget.size * 0.6, widget.size * 0.4),
      painter: IndiaMapPainter(
        progress: _circuitAnimation.value,
        glowIntensity: _glowAnimation.value,
      ),
    );
  }

  Widget _buildCircuitPattern() {
    return CustomPaint(
      size: Size(widget.size * 0.8, widget.size * 0.6),
      painter: CircuitPainter(
        progress: _circuitAnimation.value,
        glowIntensity: _glowAnimation.value,
      ),
    );
  }

  Widget _buildPlayButton() {
    return Container(
      width: widget.size * 0.15,
      height: widget.size * 0.15,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: 2,
          color: _getGradientColor(0.5).withOpacity(0.8 + _glowAnimation.value * 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: _getGradientColor(0.5).withOpacity(0.4 + _glowAnimation.value * 0.2),
            blurRadius: 10 + _glowAnimation.value * 5,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Center(
        child: Icon(
          Icons.play_arrow,
          color: _getGradientColor(0.5),
          size: widget.size * 0.08,
        ),
      ),
    );
  }

  Color _getGradientColor(double position) {
    // Create gradient colors: blue -> purple -> orange -> pink
    if (position < 0.33) {
      return Color.lerp(
        const Color(0xFF00BFFF), // Blue
        const Color(0xFF8A2BE2), // Purple
        position * 3,
      )!;
    } else if (position < 0.66) {
      return Color.lerp(
        const Color(0xFF8A2BE2), // Purple
        const Color(0xFFFF8C00), // Orange
        (position - 0.33) * 3,
      )!;
    } else {
      return Color.lerp(
        const Color(0xFFFF8C00), // Orange
        const Color(0xFFFF69B4), // Pink
        (position - 0.66) * 3,
      )!;
    }
  }
}

class IndiaMapPainter extends CustomPainter {
  final double progress;
  final double glowIntensity;

  IndiaMapPainter({required this.progress, required this.glowIntensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..color = Color.lerp(
        const Color(0xFF00BFFF),
        const Color(0xFFFF69B4),
        progress,
      )!.withOpacity(0.8 + glowIntensity * 0.2);

    final path = Path();
    
    // Simplified India map outline
    path.moveTo(size.width * 0.2, size.height * 0.3);
    path.lineTo(size.width * 0.4, size.height * 0.1);
    path.lineTo(size.width * 0.7, size.height * 0.2);
    path.lineTo(size.width * 0.8, size.height * 0.4);
    path.lineTo(size.width * 0.6, size.height * 0.8);
    path.lineTo(size.width * 0.3, size.height * 0.9);
    path.lineTo(size.width * 0.1, size.height * 0.6);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CircuitPainter extends CustomPainter {
  final double progress;
  final double glowIntensity;

  CircuitPainter({required this.progress, required this.glowIntensity});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5
      ..color = Color.lerp(
        const Color(0xFF00BFFF),
        const Color(0xFFFF69B4),
        progress,
      )!.withOpacity(0.6 + glowIntensity * 0.3);

    // Draw circuit lines
    for (int i = 0; i < 8; i++) {
      final startX = size.width * (0.1 + (i * 0.1));
      final startY = size.height * (0.2 + math.sin(i * 0.5) * 0.3);
      final endX = size.width * (0.2 + (i * 0.1));
      final endY = size.height * (0.3 + math.cos(i * 0.5) * 0.2);

      canvas.drawLine(
        Offset(startX, startY),
        Offset(endX, endY),
        paint,
      );

      // Draw circuit nodes
      canvas.drawCircle(
        Offset(endX, endY),
        2 + glowIntensity * 2,
        Paint()..color = paint.color,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}