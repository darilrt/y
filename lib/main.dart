import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'firebase_options.dart';
import 'main/pages/home_page.dart';
import 'main/pages/login_page.dart';
import 'main/pages/register_page.dart';
import 'themes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseDatabase.instance.setPersistenceEnabled(true);

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
        "/login": (context) => LoginPage(),
        "/register": (context) => const RegisterPage(),
      },
    );
  }
}
