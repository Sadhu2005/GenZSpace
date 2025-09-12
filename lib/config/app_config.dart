import 'package:flutter/foundation.dart';

/// App Configuration Class
/// Manages environment variables and app settings
class AppConfig {
  static const String _defaultApiKey = 'your_firebase_api_key_here';
  static const String _defaultProjectId = 'your_project_id';
  
  // Firebase Configuration
  static String get firebaseApiKey => 
      const String.fromEnvironment('FIREBASE_API_KEY', defaultValue: _defaultApiKey);
  
  static String get firebaseAuthDomain => 
      const String.fromEnvironment('FIREBASE_AUTH_DOMAIN', defaultValue: '${_defaultProjectId}.firebaseapp.com');
  
  static String get firebaseProjectId => 
      const String.fromEnvironment('FIREBASE_PROJECT_ID', defaultValue: _defaultProjectId);
  
  static String get firebaseStorageBucket => 
      const String.fromEnvironment('FIREBASE_STORAGE_BUCKET', defaultValue: '${_defaultProjectId}.appspot.com');
  
  static String get firebaseMessagingSenderId => 
      const String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID', defaultValue: 'your_sender_id');
  
  static String get firebaseAppId => 
      const String.fromEnvironment('FIREBASE_APP_ID', defaultValue: 'your_app_id');
  
  // App Configuration
  static String get appName => 
      const String.fromEnvironment('APP_NAME', defaultValue: 'GenZSpace 🚀');
  
  static String get appVersion => 
      const String.fromEnvironment('APP_VERSION', defaultValue: '1.0.1');
  
  static String get buildNumber => 
      const String.fromEnvironment('BUILD_NUMBER', defaultValue: '1');
  
  static bool get isDebugMode => 
      const bool.fromEnvironment('DEBUG_MODE', defaultValue: kDebugMode);
  
  // API Keys for external services
  static String get openAiApiKey => 
      const String.fromEnvironment('OPENAI_API_KEY', defaultValue: '');
  
  static String get stripePublishableKey => 
      const String.fromEnvironment('STRIPE_PUBLISHABLE_KEY', defaultValue: '');
  
  static String get mapsApiKey => 
      const String.fromEnvironment('MAPS_API_KEY', defaultValue: '');
  
  /// Check if Firebase is properly configured
  static bool get isFirebaseConfigured {
    return firebaseApiKey != _defaultApiKey && 
           firebaseProjectId != _defaultProjectId;
  }
  
  /// Get Firebase configuration map
  static Map<String, String> get firebaseConfig {
    return {
      'apiKey': firebaseApiKey,
      'authDomain': firebaseAuthDomain,
      'projectId': firebaseProjectId,
      'storageBucket': firebaseStorageBucket,
      'messagingSenderId': firebaseMessagingSenderId,
      'appId': firebaseAppId,
    };
  }
  
  /// Print configuration status (for debugging)
  static void printConfig() {
    if (kDebugMode) {
      print('🔧 App Configuration:');
      print('   App Name: $appName');
      print('   App Version: $appVersion');
      print('   Debug Mode: $isDebugMode');
      print('   Firebase Configured: $isFirebaseConfigured');
      if (isFirebaseConfigured) {
        print('   Firebase Project: $firebaseProjectId');
      }
    }
  }
}
