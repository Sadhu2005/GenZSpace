import 'package:flutter/material.dart';
import 'screens/boot_screen.dart';
import 'theme/app_theme.dart';
import 'config/app_config.dart';

void main() {
  // Print configuration status
  AppConfig.printConfig();
  
  runApp(const GenZSpaceApp());
}

class GenZSpaceApp extends StatelessWidget {
  const GenZSpaceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConfig.appName,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home: const BootScreen(),
      debugShowCheckedModeBanner: AppConfig.isDebugMode,
    );
  }
}