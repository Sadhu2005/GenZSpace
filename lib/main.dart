import 'package:flutter/material.dart';
import 'screens/boot_screen.dart';
import 'theme/app_theme.dart';

void main() {
  runApp(const GenZSpaceApp());
}

class GenZSpaceApp extends StatelessWidget {
  const GenZSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GenZ Space',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const BootScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}