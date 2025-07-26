import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:khotwa/bindings/splash_binding.dart';
import 'package:khotwa/bindings/initial_binding.dart'; // ✅ You forgot this import
import 'package:khotwa/shared/constants/app_routes.dart';
import 'package:khotwa/shared/themes/app_theme.dart';
import 'package:khotwa/view/change_password/change_password_page.dart';
import 'package:khotwa/view/event/event_details_page.dart';

import 'package:khotwa/view/intro/Splash_Screen.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';
import 'package:khotwa/view/Home_Page/Home_Page_Volunteer.dart';
import 'package:khotwa/view/login/login_page.dart';
import 'package:khotwa/view/profile/profile_page.dart';
import 'package:khotwa/view/verify_email/verify_email_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Khotwa',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light,
      initialBinding: InitialBinding(),
      // initialRoute: AppRoutes.login,
      // getPages: [
      //   GetPage(
      //     name: AppRoutes.splash,
      //     page: () => const SplashScreen(),
      //     binding: SplashBinding(),
      //   ),
      //   GetPage(name: AppRoutes.intro, page: () => const IntroScreen()),
      //   GetPage(name: AppRoutes.login, page: () => LoginPage()),
      //     GetPage(name: AppRoutes.verifyEmail, page: () =>  VerifyEmailPage()), // ✅ added
      //   GetPage(name: AppRoutes.homeVolunteer, page: () => HomePageVoulunteer()),
      //   GetPage(name: AppRoutes.changePassword, page: () => ChangingPasswordPage()),
      // ],
      home: ProfilePage(),
    );
  }
}
