import 'package:flutter/material.dart';

class YThemes {
  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 20, 23, 25),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: Colors.lightBlue,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(
              color: Color.fromARGB(213, 255, 255, 255),
              width: 2,
            ),
            backgroundColor: const Color.fromARGB(255, 20, 23, 25),
            minimumSize: const Size(150, 40),
          ),
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.white,
          selectionColor: Colors.white,
          selectionHandleColor: Colors.white,
        ),
        colorScheme: const ColorScheme.dark(
          primary: Color.fromARGB(255, 20, 28, 30),
          secondary: Color.fromARGB(255, 66, 66, 66),
          background: Colors.black,
          surface: Colors.black,
          onPrimary: Colors.white,
          onSecondary: Color.fromARGB(255, 103, 103, 103),
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
      );
}
