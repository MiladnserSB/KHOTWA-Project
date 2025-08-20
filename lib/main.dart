import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:khotwa/bindings/splash_binding.dart';
import 'package:khotwa/bindings/initial_binding.dart';
import 'package:khotwa/controller/theme_controller.dart';
import 'package:khotwa/shared/constants/app_routes.dart';
import 'package:khotwa/shared/themes/app_theme.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Donor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Supervisor.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Donor.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Visitor.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_page_Supervisor.dart';
import 'package:khotwa/view/change_password/change_password_page.dart';
import 'package:khotwa/view/event_and_projects/event_details/event_details_page.dart';
import 'package:khotwa/view/event_and_projects/events_and_projects_page.dart';
import 'package:khotwa/view/event_and_projects/my_events_page.dart';
import 'package:khotwa/view/event_and_projects/project_details/project_details_page.dart';

import 'package:khotwa/view/intro/Splash_Screen.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';
import 'package:khotwa/view/Home_Page/Home_Page/Home_Page_Volunteer.dart';
import 'package:khotwa/view/login/login_page.dart';
import 'package:khotwa/view/profile/profile_page.dart';
import 'package:khotwa/view/settings/settings_page.dart';
import 'package:khotwa/view/supervisor/attendence/attendence_page.dart';
import 'package:khotwa/view/supervisor/attendence/show_qr_in_page.dart';
import 'package:khotwa/view/supervisor/feedback/feedback_page.dart';
import 'package:khotwa/view/tasks/tasks_page.dart';
import 'package:khotwa/view/verify_email/verify_email_page.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Visitor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Volunteer.dart';

void main() async {
  Get.put(ThemeController());
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
    const MyApp({super.key});



  @override
  Widget build(BuildContext context) {
      final themeController = Get.find<ThemeController>();

  return Obx(() {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Khotwa App',
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black),
          ),
        ),
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),
        themeMode: themeController.themeMode,
        home:  AnimatedBottomBarPageSupervisor(),
      );
    });
  }
}
// initialRoute: AppRoutes.login,
      // getPages: [
      //   GetPage(
      //     name: AppRoutes.splash,
      //     page: () => const SplashScreen(),
      //     binding: SplashBinding(),
      //   ),
      //   GetPage(name: AppRoutes.intro, page: () => const IntroScreen()),
      //   GetPage(name: AppRoutes.login, page: () => LoginPage()),
      //     GetPage(name: AppRoutes.verifyEmail, page: () =>  VerifyEmailPage()),
      //   GetPage(name: AppRoutes.homeVolunteer, page: () => HomePageVoulunteer()),
      //   GetPage(name: AppRoutes.changePassword, page: () => ChangingPasswordPage()),
      // ],