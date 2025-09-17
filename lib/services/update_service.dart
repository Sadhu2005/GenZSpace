import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:package_info_plus/package_info_plus.dart';

class UpdateService {
  static const String _playStoreUrl = 'https://play.google.com/store/apps/details?id=com.anu.GenZSpace';
  static const String _playStoreInternalUrl = 'https://play.google.com/apps/internaltest/4699900537351244955';
  
  static Future<void> checkForUpdates(BuildContext context) async {
    try {
      // Get current app version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      
      debugPrint('🔍 Checking for updates... Current version: $currentVersion');
      
      // Simulate update check (in real app, you'd call your API)
      // For now, we'll show update dialog occasionally for testing
      final shouldShowUpdate = _shouldShowUpdateDialog();
      
      if (shouldShowUpdate && context.mounted) {
        await _showUpdateDialog(context, currentVersion);
      } else {
        debugPrint('✅ App is up to date');
      }
      
    } catch (e) {
      debugPrint('❌ Error checking for updates: $e');
    }
  }
  
  static bool _shouldShowUpdateDialog() {
    // Show update dialog 30% of the time for testing
    // In production, this would be based on actual version comparison
    return DateTime.now().millisecond % 3 == 0;
  }
  
  
  static Future<void> _showUpdateDialog(BuildContext context, String currentVersion) async {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF1A1A1A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              const Icon(
                Icons.system_update,
                color: Color(0xFF6366F1),
                size: 28,
              ),
              const SizedBox(width: 12),
              const Text(
                'Update Available',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'A new version of GenZSpace is available!',
                style: TextStyle(
                  color: Colors.grey[300],
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Current Version: $currentVersion',
                      style: const TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'New Version: Available',
                      style: TextStyle(
                        color: Color(0xFF6366F1),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                '✨ What\'s New:',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                '• Automatic updates via Google Play Store\n'
                '• Enhanced user experience\n'
                '• Bug fixes and performance improvements\n'
                '• New features and UI enhancements',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text(
                'Later',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _openPlayStore();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6366F1),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
              child: const Text(
                'Update Now',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  
  static Future<void> _openPlayStore() async {
    try {
      // Try to open the app in Play Store
      final Uri playStoreUrl = Uri.parse(_playStoreUrl);
      
      if (await canLaunchUrl(playStoreUrl)) {
        await launchUrl(
          playStoreUrl,
          mode: LaunchMode.externalApplication,
        );
        debugPrint('🚀 Opened Play Store for update');
      } else {
        debugPrint('❌ Could not open Play Store');
      }
    } catch (e) {
      debugPrint('❌ Error opening Play Store: $e');
    }
  }
  
  static Future<void> downloadUpdate(BuildContext context) async {
    await _openPlayStore();
  }
}

