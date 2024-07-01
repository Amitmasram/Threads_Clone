import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
    useMaterial3: true,
    appBarTheme: const AppBarTheme(
        backgroundColor: Colors.black,
        elevation: 0.0,
        surfaceTintColor: Colors.black),
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      brightness: Brightness.dark,
      background: Colors.black,
      onBackground: Colors.white,
      surfaceTint: Colors.black12,
      primary: Colors.white,
      onPrimary: Colors.black,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.black),
            backgroundColor: MaterialStateProperty.all(Colors.white))),
    navigationBarTheme: NavigationBarThemeData(
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.transparent,
        backgroundColor: Colors.black,
        height: 55,
        iconTheme: MaterialStateProperty.all(
            const IconThemeData(color: Colors.white, size: 30))));
