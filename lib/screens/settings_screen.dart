import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = true;
  bool _locationEnabled = false;
  bool _dataSaverEnabled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Account Section
            _buildSectionHeader('Account'),
            _buildSettingsCard([
              _buildSettingsTile(
                Icons.person_outline,
                'Edit Profile',
                'Update your personal information',
                () => _navigateToEditProfile(),
              ),
              _buildSettingsTile(
                Icons.security_outlined,
                'Privacy & Security',
                'Manage your privacy settings',
                () => _navigateToPrivacySettings(),
              ),
              _buildSettingsTile(
                Icons.verified_user_outlined,
                'Verification',
                'Verify your student identity',
                () => _navigateToVerification(),
              ),
            ]),
            
            const SizedBox(height: 24),
            
            // Preferences Section
            _buildSectionHeader('Preferences'),
            _buildSettingsCard([
              _buildSwitchTile(
                Icons.notifications_outlined,
                'Push Notifications',
                'Receive notifications for activities',
                _notificationsEnabled,
                (value) => setState(() => _notificationsEnabled = value),
              ),
              _buildSwitchTile(
                Icons.dark_mode_outlined,
                'Dark Mode',
                'Use dark theme',
                _darkModeEnabled,
                (value) => setState(() => _darkModeEnabled = value),
              ),
              _buildSwitchTile(
                Icons.location_on_outlined,
                'Location Services',
                'Allow location-based features',
                _locationEnabled,
                (value) => setState(() => _locationEnabled = value),
              ),
              _buildSwitchTile(
                Icons.data_saver_off_outlined,
                'Data Saver',
                'Reduce data usage',
                _dataSaverEnabled,
                (value) => setState(() => _dataSaverEnabled = value),
              ),
            ]),
            
            const SizedBox(height: 24),
            
            // App Section
            _buildSectionHeader('App'),
            _buildSettingsCard([
              _buildSettingsTile(
                Icons.language_outlined,
                'Language',
                'English',
                () => _showLanguageDialog(),
              ),
              _buildSettingsTile(
                Icons.storage_outlined,
                'Storage',
                'Manage app storage',
                () => _navigateToStorage(),
              ),
              _buildSettingsTile(
                Icons.update_outlined,
                'App Version',
                'v1.0.0',
                () => _checkForUpdates(),
              ),
            ]),
            
            const SizedBox(height: 24),
            
            // Support Section
            _buildSectionHeader('Support'),
            _buildSettingsCard([
              _buildSettingsTile(
                Icons.help_outline,
                'Help Center',
                'Get help and support',
                () => _navigateToHelp(),
              ),
              _buildSettingsTile(
                Icons.feedback_outlined,
                'Send Feedback',
                'Share your thoughts',
                () => _sendFeedback(),
              ),
              _buildSettingsTile(
                Icons.bug_report_outlined,
                'Report Bug',
                'Report technical issues',
                () => _reportBug(),
              ),
              _buildSettingsTile(
                Icons.info_outline,
                'About',
                'Learn more about GenZSpace',
                () => _showAboutDialog(),
              ),
            ]),
            
            const SizedBox(height: 24),
            
            // Legal Section
            _buildSectionHeader('Legal'),
            _buildSettingsCard([
              _buildSettingsTile(
                Icons.description_outlined,
                'Terms of Service',
                'Read our terms and conditions',
                () => _navigateToTerms(),
              ),
              _buildSettingsTile(
                Icons.privacy_tip_outlined,
                'Privacy Policy',
                'How we protect your data',
                () => _navigateToPrivacy(),
              ),
              _buildSettingsTile(
                Icons.copyright_outlined,
                'Licenses',
                'Open source licenses',
                () => _navigateToLicenses(),
              ),
            ]),
            
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildSettingsCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[900],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey[700]!,
          width: 1,
        ),
      ),
      child: Column(
        children: children,
      ),
    );
  }

  Widget _buildSettingsTile(
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFFF72585).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFFF72585),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        color: Colors.grey[500],
        size: 16,
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(
    IconData icon,
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: const Color(0xFF7209B7).withOpacity(0.2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(
          icon,
          color: const Color(0xFF7209B7),
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          color: Colors.grey[400],
          fontSize: 14,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: const Color(0xFFF72585),
        activeTrackColor: const Color(0xFFF72585).withOpacity(0.3),
        inactiveThumbColor: Colors.grey[600],
        inactiveTrackColor: Colors.grey[800],
      ),
    );
  }

  // Navigation methods
  void _navigateToEditProfile() {
    // Navigate to edit profile screen
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Edit Profile feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _navigateToPrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Privacy Settings feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _navigateToVerification() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Verification feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _showLanguageDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Select Language',
          style: TextStyle(color: Colors.white),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildLanguageOption('English', true),
            _buildLanguageOption('Hindi', false),
            _buildLanguageOption('Tamil', false),
            _buildLanguageOption('Telugu', false),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF72585),
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Widget _buildLanguageOption(String language, bool isSelected) {
    return ListTile(
      title: Text(
        language,
        style: TextStyle(
          color: isSelected ? const Color(0xFFF72585) : Colors.white,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: isSelected
          ? const Icon(Icons.check, color: Color(0xFFF72585))
          : null,
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Language changed to $language'),
            backgroundColor: const Color(0xFFF72585),
          ),
        );
      },
    );
  }

  void _navigateToStorage() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Storage management feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _checkForUpdates() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('You are using the latest version!'),
        backgroundColor: Color(0xFF4CAF50),
      ),
    );
  }

  void _navigateToHelp() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Help Center feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _sendFeedback() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'Send Feedback',
          style: TextStyle(color: Colors.white),
        ),
        content: const TextField(
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Share your thoughts...',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(),
          ),
          maxLines: 4,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback sent successfully!'),
                  backgroundColor: Color(0xFF4CAF50),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF72585),
            ),
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _reportBug() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Bug reporting feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: const Text(
          'About GenZSpace',
          style: TextStyle(color: Colors.white),
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Version: 1.0.0',
              style: TextStyle(color: Colors.grey),
            ),
            SizedBox(height: 8),
            Text(
              'GenZSpace is a comprehensive social platform designed for students to connect, learn, and grow together.',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            Text(
              '© 2024 GenZSpace. All rights reserved.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFF72585),
            ),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _navigateToTerms() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Terms of Service feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _navigateToPrivacy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Privacy Policy feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }

  void _navigateToLicenses() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Licenses feature coming soon!'),
        backgroundColor: Color(0xFFF72585),
      ),
    );
  }
}
