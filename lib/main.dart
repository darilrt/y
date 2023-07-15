import 'package:flutter/material.dart';
import 'pages/home_page.dart';
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
      home: const HomePage(title: 'Y'),
    );
  }
}
