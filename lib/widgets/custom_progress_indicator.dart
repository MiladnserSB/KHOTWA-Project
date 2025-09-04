import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';


class CustomProgressIndicator extends StatefulWidget {
  final double size;
  final Duration duration;

  const CustomProgressIndicator({
    Key? key,
    this.size = 80,
    this.duration = const Duration(seconds: 2),
  }) : super(key: key);

  @override
  State<CustomProgressIndicator> createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;
  late Animation<double> _scale;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();

    _rotation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );

    _scale = Tween<double>(begin: 0.7, end: 1.2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (_, child) {
          return Transform.scale(
            scale: _scale.value,
            child: RotationTransition(
              turns: _rotation,
              child: CustomPaint(
                size: Size(widget.size, widget.size),
                painter: _SpiralPainter(),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _SpiralPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width/2, size.height/2);
    final radius = size.width/2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeCap = StrokeCap.round;

    // رسم الشرائط المتدرجة
    for (int i = 0; i < 12; i++) {
      final startAngle = i * 30.0 * 3.1416 / 180;
      final sweepAngle = 20 * 3.1416 / 180;

      paint.color = secondaryColor.withOpacity((i+1)/12);

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
