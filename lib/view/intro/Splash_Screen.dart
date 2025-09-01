import 'package:flutter/material.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const IntroScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
              'assets/images/Intro.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Center(
                child: Image.asset(
                  'assets/images/خطوة.png',
                  width: 230,
                ),
              ),
              const Spacer(),
              const FadeInTextAnimation(
                text: "خطوة صغيرة بتعمل أثر كبير",
                fontSize: 23,
                color: Color(0xFFDDA15E),
                delay: 800,
              ),
              const SizedBox(height: 90),
            ],
          ),
        ],
      ),
    );
  }
}

class FadeInTextAnimation extends StatefulWidget {
  final String text;
  final double fontSize;
  final Color color;
  final int delay;

  const FadeInTextAnimation({
    super.key,
    required this.text,
    required this.fontSize,
    this.color = Colors.white,
    this.delay = 0,
  });

  @override
  State<FadeInTextAnimation> createState() => _FadeInTextAnimationState();
}

class _FadeInTextAnimationState extends State<FadeInTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<double> translate;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    opacity = Tween<double>(begin: 0, end: 1).animate(controller);
    translate = Tween<double>(begin: 40, end: 0).animate(controller);
    scale = Tween<double>(begin: 0.8, end: 1).animate(controller);

    Future.delayed(Duration(milliseconds: widget.delay), () {
      controller.forward();
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Opacity(
          opacity: opacity.value,
          child: Transform.translate(
            offset: Offset(0, translate.value),
            child: Transform.scale(
              scale: scale.value,
              child: Text(
                widget.text,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'DG Heaven',
                  fontSize: widget.fontSize,
                  fontWeight: FontWeight.w600,
                  color: widget.color,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
