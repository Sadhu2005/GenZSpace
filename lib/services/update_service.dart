import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../config/app_config.dart';

class UpdateService {
  static Future<void> checkForUpdates(BuildContext context) async {
    try {
      // For now, we'll show a simple update dialog
      // In a real app, you would check against a remote API
      // and compare with the current app version
      _showUpdateDialog(context);
    } catch (e) {
      debugPrint('Error checking for updates: $e');
    }
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
              onPressed: () {
                Navigator.of(context).pop();
                _openDownloadPage();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
              ),
              child: const Text('Download Update'),
            ),
          ],
        );
      },
    );
  }
  
  static void _openDownloadPage() async {
    // In a real app, this would open your app store or download page
    // For now, we'll open the GitHub repository
    const url = 'https://github.com/yourusername/GenZSpace';
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }
}
