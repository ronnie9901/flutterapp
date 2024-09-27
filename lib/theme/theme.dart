import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey[900]!,
    primary: Colors.grey[500]!,
    secondary: Colors.grey[700]!,
    tertiary: Colors.grey[800],
    inversePrimary: Colors.grey[300],
    onSurface: Colors.white,
  ),
);

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey[300]!,
    primary: Colors.grey[500]!,
    secondary: Colors.grey[200]!,
    tertiary: Colors.white,
    inversePrimary: Colors.grey[700],
  ),
);