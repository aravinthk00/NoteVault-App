
import 'package:flutter/material.dart';

class AppTheme{

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.purple.shade100,
    appBarTheme: AppBarTheme(
      color: Colors.purple.shade400,
      titleTextStyle: TextStyle(
        fontSize: 18,
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontStyle: FontStyle.italic)
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.purple.shade400,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.purpleAccent.shade100
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.purple
    ),
    colorScheme: ColorScheme.light(
        background: Colors.white,
        primary: Colors.white,
        secondary: Colors.white));

  static ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.deepPurple,
      appBarTheme: AppBarTheme(
          color: Colors.deepPurple.shade400,
          titleTextStyle: TextStyle(
              fontSize: 18,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic)
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.deepPurpleAccent.shade100
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.deepPurple,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.deepPurpleAccent.shade100
      ),
      colorScheme: ColorScheme.dark(
          background: Colors.white,
          primary: Colors.white,
          secondary: Colors.black)
  );
}