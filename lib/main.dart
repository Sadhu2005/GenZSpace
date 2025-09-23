import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'screens/boot_screen.dart';
import 'theme/app_theme.dart';
import 'config/app_config.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Firebase is currently disabled
  print('ℹ️ Firebase is disabled - running without backend services');

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
      builder: (context, child) {
        // Add error boundary
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(textScaler: const TextScaler.linear(1.0)),
          child: child!,
        );
      },
    );
  }
}