import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:khotwa/shared/themes/app_theme.dart';
import 'package:khotwa/view/change_password/change_password_page.dart';
import 'package:khotwa/view/intro/Intro_Screen.dart';
import 'package:khotwa/view/profile/profile_page.dart';


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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '',
      theme: AppTheme.light,

      home: ProfilePage(),

    );
  }
}