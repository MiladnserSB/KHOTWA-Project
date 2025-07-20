import 'package:flutter/material.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> with TickerProviderStateMixin {
  late AnimationController _loginController;
  late AnimationController _orController;
  late AnimationController _guestController;

  @override
  void initState() {
    super.initState();

    _loginController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _orController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _guestController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _loginController.forward();
    Future.delayed(Duration(milliseconds: 300), () => _orController.forward());
    Future.delayed(Duration(milliseconds: 600), () => _guestController.forward());
  }

  @override
  void dispose() {
    _loginController.dispose();
    _orController.dispose();
    _guestController.dispose();
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Column(
              children: [
                Image.asset(
                  'assets/images/خطوة.png',
                  width: 230,
                ),

                const Spacer(flex: 15),

                // login button with scale + fade
                ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 1.0).animate(CurvedAnimation(
                    parent: _loginController,
                    curve: Curves.easeOutBack,
                  )),
                  child: FadeTransition(
                    opacity: _loginController,
                    child: SizedBox(
                      width: 400,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFDDA15E),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text("login", style: TextStyle(
                          fontFamily: '._Acumin Variable Concept',
                          fontSize: 18,
                        )),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // OR fade + move slightly
                FadeTransition(
                  opacity: _orController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0.2, 0),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _orController,
                      curve: Curves.easeOut,
                    )),
                    child: Row(
                      children: [
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "OR",
                            style: TextStyle(
                              fontFamily: '._Acumin Variable Concept',
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const Expanded(
                          child: Divider(
                            color: Colors.white,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Guest button with slide up and fade
                FadeTransition(
                  opacity: _guestController,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: Offset(0, 0.3),
                      end: Offset.zero,
                    ).animate(CurvedAnimation(
                      parent: _guestController,
                      curve: Curves.easeOut,
                    )),
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        "continue as a guest",
                        style: TextStyle(
                          fontFamily: '._Acumin Variable Concept',
                          color: Color(0xFFDDA15E),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),

                const Spacer(flex: 2),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
