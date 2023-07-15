import 'package:flutter/material.dart';

class YThemes {
  static ThemeData dark() => ThemeData(
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          primary: Colors.black12,
          secondary: Colors.black26,
          background: Colors.black,
          surface: Colors.black,
          onPrimary: Colors.white,
          onSecondary: Colors.white30,
          onBackground: Colors.white,
          onSurface: Colors.white,
        ),
      );
}
