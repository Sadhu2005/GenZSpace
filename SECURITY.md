# 🔐 Security Guidelines for GenZSpace

## Environment Variables & API Keys

### ⚠️ **IMPORTANT: Never commit sensitive data to Git!**

This project uses environment variables and configuration files to manage sensitive information like API keys and credentials.

## 📁 Files to Keep Private

### Never commit these files:
- `.env` - Contains actual API keys and secrets
- `lib/config/secrets.dart` - Contains actual API keys and secrets
- `android/app/google-services.json` - Firebase configuration
- `ios/Runner/GoogleService-Info.plist` - Firebase configuration
- `android/local.properties` - Local Android configuration

### Safe to commit:
- `env.example` - Template with placeholder values
- `lib/config/secrets_template.dart` - Template with placeholder values
- `lib/config/app_config.dart` - Configuration management class
- `.gitignore` - Ensures sensitive files are ignored

## 🚀 Setup Instructions

### 1. Environment Variables
```bash
# Copy the example file
cp env.example .env

# Edit .env with your actual values
# Fill in your Firebase API keys and other credentials
```

### 2. Secrets Configuration
```bash
# Copy the template
cp lib/config/secrets_template.dart lib/config/secrets.dart

# Edit secrets.dart with your actual values
# Fill in your Firebase configuration and API keys
```

### 3. Firebase Configuration
- Download `google-services.json` from Firebase Console
- Place it in `android/app/google-services.json`
- Download `GoogleService-Info.plist` from Firebase Console
- Place it in `ios/Runner/GoogleService-Info.plist`

## 🔧 Configuration Options

### Option 1: Environment Variables (Recommended)
Use the `AppConfig` class which reads from environment variables:
```dart
import 'package:genzspace/config/app_config.dart';

// Access configuration
String apiKey = AppConfig.firebaseApiKey;
bool isConfigured = AppConfig.isFirebaseConfigured;
```

### Option 2: Secrets File
Use the `Secrets` class for direct access:
```dart
import 'package:genzspace/config/secrets.dart';

// Access secrets
String apiKey = Secrets.firebaseApiKey;
```

## 🛡️ Security Best Practices

1. **Never commit sensitive files** - Use `.gitignore` to exclude them
2. **Use environment variables** - For production deployments
3. **Rotate API keys regularly** - Update credentials periodically
4. **Use different keys for different environments** - Dev, staging, production
5. **Monitor API usage** - Set up alerts for unusual activity

## 🚨 If You Accidentally Commit Secrets

1. **Immediately rotate the exposed keys** in your service providers
2. **Remove the file from Git history**:
   ```bash
   git filter-branch --force --index-filter \
   'git rm --cached --ignore-unmatch path/to/sensitive/file' \
   --prune-empty --tag-name-filter cat -- --all
   ```
3. **Force push to update remote repository**:
   ```bash
   git push origin --force --all
   ```

## 📋 Checklist Before Committing

- [ ] No `.env` file in repository
- [ ] No `secrets.dart` file in repository
- [ ] No `google-services.json` in repository
- [ ] No `GoogleService-Info.plist` in repository
- [ ] All API keys are placeholders in committed files
- [ ] `.gitignore` includes all sensitive file patterns

## 🔍 Verification

Run this command to check for accidentally committed secrets:
```bash
# Check for common API key patterns
grep -r "AIza[0-9A-Za-z_-]" . --exclude-dir=.git
grep -r "sk-[0-9A-Za-z_-]" . --exclude-dir=.git
grep -r "pk_[0-9A-Za-z_-]" . --exclude-dir=.git
```

## 📞 Support

If you have questions about security configuration, please:
1. Check this documentation first
2. Review the example files
3. Contact the development team

---

**Remember: Security is everyone's responsibility! 🔐**
