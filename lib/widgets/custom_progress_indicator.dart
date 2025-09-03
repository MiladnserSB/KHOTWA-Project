import 'package:flutter/material.dart';
import 'package:khotwa/shared/constants/colors.dart';

class CustomProgressIndicator extends StatefulWidget {
  const CustomProgressIndicator({Key? key}) : super(key: key);

  @override
  State<CustomProgressIndicator> createState() => _CustomProgressIndicatorState();
}

class _CustomProgressIndicatorState extends State<CustomProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(); // infinite loop
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20), // rounded edges
      child: SizedBox(
        height: 12,
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return ShaderMask(
              shaderCallback: (Rect bounds) {
                return LinearGradient(
                  colors: [
                    secondaryColor.withOpacity(0.9),
                    secondaryColor.withOpacity(0.6),
                    secondaryColor.withOpacity(0.9),
                  ],
                  stops: const [0.1, 0.5, 0.9],
                  begin: Alignment(-1.0 + _controller.value * 2, 0.0),
                  end: const Alignment(1.0, 0.0),
                  tileMode: TileMode.mirror,
                ).createShader(bounds);
              },
              child: LinearProgressIndicator(
                value: _controller.value,
                backgroundColor: secondaryColor.withOpacity(0.15),
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                minHeight: 12,
              ),
            );
          },
        ),
      ),
    );
  }
}
