import 'package:flutter/material.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {

  late AnimationController _khotwaController;
  late AnimationController _smallStepController;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => IntroScreen()),
      );
    });
    _khotwaController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _smallStepController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    );

    _khotwaController.forward();
    Future.delayed(Duration(milliseconds: 800), () {
      _smallStepController.forward();
    });
  }

  @override
  void dispose() {
    _khotwaController.dispose();
    _smallStepController.dispose();
    super.dispose();
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

              Center(
                child: Image.asset(
                  'assets/images/خطوة.png',
                  width: 230,
                ),
              ),

              const Spacer(),

              AnimatedBuilder(
                animation: _khotwaController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _khotwaController.value,
                    child: Transform.translate(
                      offset: Offset(0, 40 * (1 - _khotwaController.value)),
                      child: Transform.scale(
                        scale: 0.8 + (0.2 * _khotwaController.value),
                        child: child,
                      ),
                    ),
                  );
                },
                child: Text(
                  "khotwa for change",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: '._Acumin Variable Concept ',
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.2,
                  ),
                ),
              ),

              const Spacer(),

              AnimatedBuilder(
                animation: _smallStepController,
                builder: (context, child) {
                  return Opacity(
                    opacity: _smallStepController.value,
                    child: Transform.translate(
                      offset: Offset(0, 20 * (1 - _smallStepController.value)),
                      child: child,
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 90),
                  child: Text(
                    "...خطوة صغيرة بتعمل أثر كبير",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'DG Heaven',
                      color: Color(0xFFDDA15E),
                      fontSize: 23,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
