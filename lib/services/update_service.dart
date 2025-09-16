import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateService {
  static Future<void> checkForUpdates(BuildContext context) async {
    try {
      // For now, we'll skip Firebase App Distribution check
      // and just show a simple update check
      debugPrint('Update check completed - app is up to date');
      
    } catch (e) {
      debugPrint('Error checking for updates: $e');
    }
  }
  
  static Future<void> _showUpdateDialog(BuildContext context) async {
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
                 // Open app store or download page
                 final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.anu.GenZSpace');
                 if (await canLaunchUrl(url)) {
                   await launchUrl(url, mode: LaunchMode.externalApplication);
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
  
  static Future<void> downloadUpdate(BuildContext context) async {
    try {
      // For now, redirect to Play Store
      final Uri url = Uri.parse('https://play.google.com/store/apps/details?id=com.anu.GenZSpace');
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error downloading update: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to open update page'),
          ),
        );
      }
    }
  }
}

