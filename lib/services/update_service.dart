import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:firebase_app_distribution/firebase_app_distribution.dart';
import '../config/app_config.dart';

class UpdateService {
  static Future<void> checkForUpdates(BuildContext context) async {
    try {
      // Check for updates using Firebase App Distribution
      final bool isUpdateAvailable = await FirebaseAppDistribution.checkForUpdate();
      
      if (isUpdateAvailable) {
        _showUpdateDialog(context);
      } else {
        debugPrint('App is up to date');
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
      // Fallback to manual check
      _checkManualUpdate(context);
    }
  }
  
  static void _checkManualUpdate(BuildContext context) {
    // You can implement a custom version check here
    // For now, we'll show a simple update dialog
    _showUpdateDialog(context);
  }
  
  static void _showUpdateDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          title: const Text(
            '🚀 Update Available',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: const Text(
            'A new version of GenZSpace is available! Download the latest version to get new features and improvements.',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Later',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  // Try to update using Firebase App Distribution
                  await FirebaseAppDistribution.updateApp();
                } catch (e) {
                  // Fallback to manual download
                  _openDownloadPage();
                }
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Update Now'),
            ),
          ],
        );
      },
    );
  }
  
  static void _openDownloadPage() async {
    // Open your website for manual download
    const url = 'https://zengspace.in';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
