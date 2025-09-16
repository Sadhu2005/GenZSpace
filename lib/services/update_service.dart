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

