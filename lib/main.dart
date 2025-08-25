import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khotwa/Localizations/ArabicLocalization.dart';
import 'package:khotwa/Localizations/EnglishLocalization.dart';
import 'package:khotwa/bindings/splash_binding.dart';
import 'package:khotwa/controller/Settings_Lang_Controller.dart';
import 'package:khotwa/controller/theme_controller.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Donor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Visitor.dart';
import 'package:khotwa/view/Home_Page/Animted_bottom/Animated_Bottom_Bar_Volunteer.dart';
import 'package:khotwa/view/donner/donate/donate_page.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox('authBox');

  // Controllers
  Get.put(ThemeController());
  Get.put(SettingsLangController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeController = Get.find<ThemeController>();
    final settingsController = Get.find<SettingsLangController>();

    return Obx(() {
      return GetMaterialApp(
        // initialBinding: SplashBinding(),
        debugShowCheckedModeBanner: false,
        translations: MyTranslations(),
        locale: settingsController.locale.value, 
        fallbackLocale: const Locale('en'),
        title: 'Khotwa App',

        // 🌞 Theme Light
        theme: ThemeData.light().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            elevation: 1,
          ),
          scaffoldBackgroundColor: Colors.white,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.black),
          ),
        ),

        // 🌑 Theme Dark
        darkTheme: ThemeData.dark().copyWith(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
            elevation: 1,
          ),
          scaffoldBackgroundColor: Colors.black,
          textTheme: const TextTheme(
            bodyMedium: TextStyle(color: Colors.white),
          ),
        ),

        themeMode: themeController.themeMode, 
        home: AnimatedBottomBarPageVisitor(),
      );
    });
  }
}

class MyTranslations extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        ...EnglishLocalization().keys,
        ...ArabicLocalization().keys,
      };
}








// initialRoute: AppRoutes.login,
//       getPages: [
//         GetPage(
//           name: AppRoutes.splash,
//           page: () => const SplashScreen(),
//           binding: SplashBinding(),
//         ),
//         GetPage(name: AppRoutes.intro, page: () => const IntroScreen()),
//         GetPage(name: AppRoutes.login, page: () => LoginPage()),
//           GetPage(name: AppRoutes.verifyEmail, page: () =>  VerifyEmailPage()),
//         GetPage(name: AppRoutes.homeVolunteer, page: () => HomePageVoulunteer()),
//         GetPage(name: AppRoutes.changePassword, page: () => ChangingPasswordPage()),
//       ],
      