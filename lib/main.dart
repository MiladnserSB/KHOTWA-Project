import 'package:flutter/material.dart';
import 'package:khotwa/shared/themes/app_theme.dart';
import 'package:khotwa/view/change_password/change_password_page.dart';


void main() async {
  runApp(const MyApp());
}

//TODO: Milad we didn't use the hive in auth_repo_impl and also in auth_api in the remote

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Clean Architecture Login',
      theme: AppTheme.light,
      home: ChangingPasswordPage(),
    );
  }
}