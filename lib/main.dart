import 'package:flutter/material.dart';
import 'main/pages/home_page.dart';
import 'main/pages/login_page.dart';
import 'main/pages/register_page.dart';
import 'themes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Project Y',
      theme: YThemes.dark(),
      initialRoute: "/login",
      routes: {
        "/home": (context) => const HomePage(),
        "/login": (context) => const LoginPage(),
        "/register": (context) => const RegisterPage(),
      },
    );
  }
}
