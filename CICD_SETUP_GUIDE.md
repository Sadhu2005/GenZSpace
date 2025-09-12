# 🚀 GenZSpace CI/CD Pipeline Setup Guide

This guide will help you set up a complete end-to-end CI/CD pipeline for your GenZSpace Flutter app with automatic updates through Firebase App Distribution.

## 📋 Prerequisites

1. **GitHub Repository** with your Flutter project
2. **Firebase Project** with App Distribution enabled
3. **Google Play Console** account (for production releases)
4. **GitHub Secrets** configured

## 🔧 Setup Steps

### 1. Firebase App Distribution Setup

#### Enable Firebase App Distribution
```bash
# Install Firebase CLI
npm install -g firebase-tools

# Login to Firebase
firebase login

# Initialize App Distribution
firebase appdistribution:apps:list
```

#### Configure App Distribution Groups
1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project → App Distribution
3. Create tester groups:
   - `testers` - For testing releases
   - `beta` - For beta testing
   - `internal` - For internal testing

### 2. GitHub Secrets Configuration

Go to your GitHub repository → Settings → Secrets and variables → Actions

Add these secrets:

#### Required Secrets:
- `FIREBASE_APP_ID`: Your Firebase app ID (from firebase.json)
- `FIREBASE_TOKEN`: Firebase CI token

#### Optional Secrets (for Google Play Store):
- `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`: Service account JSON for Play Store uploads

#### How to get Firebase Token:
```bash
# Generate Firebase CI token
firebase login:ci
# Copy the token and add it as FIREBASE_TOKEN secret
```

### 3. Version Management

#### Using the Version Update Script
```bash
# Make the script executable
chmod +x scripts/version-update.sh

# Auto-increment build number and push
./scripts/version-update.sh -a -t -p

# Update to specific version
./scripts/version-update.sh -v 1.0.2 -b 3 -t -p
```

#### Manual Version Updates
Edit `pubspec.yaml`:
```yaml
version: 1.0.2+3  # version+build_number
```

### 4. CI/CD Pipeline Workflow

The pipeline automatically:

1. **Build & Test** - Runs on every push/PR
2. **Distribute** - Sends to Firebase App Distribution on main/develop branches
3. **Deploy** - Publishes to Google Play Store on version tags
4. **Notify** - Provides build status updates

#### Trigger Conditions:
- **Build & Test**: Every push/PR
- **Firebase Distribution**: main/develop branches or version tags
- **Google Play Store**: Version tags only (v1.0.0, v1.0.1, etc.)

## 🎯 Usage Examples

### Development Workflow

1. **Make changes** to your code
2. **Commit and push** to develop branch
3. **Automatic build** and distribution to testers
4. **Test** the distributed app
5. **Merge** to main when ready

### Release Workflow

1. **Update version** using the script:
   ```bash
   ./scripts/version-update.sh -v 1.1.0 -b 1 -t -p
   ```

2. **Automatic deployment** to:
   - Firebase App Distribution (for testing)
   - Google Play Store (for production)

### Testing Workflow

1. **Push to develop** → Firebase App Distribution
2. **Test with beta group**
3. **Push to main** → Firebase App Distribution
4. **Create version tag** → Google Play Store

## 📱 App Update Integration

Your app already has automatic update detection:

```dart
// In your app, call this to check for updates
await UpdateService.checkForUpdates(context);
```

The update service will:
1. Check for new versions via Firebase App Distribution
2. Show update dialog if available
3. Allow users to update directly from the app

## 🔍 Monitoring & Debugging

### GitHub Actions
- Check build status in Actions tab
- View detailed logs for each step
- Monitor artifact uploads

### Firebase Console
- View distribution history
- Monitor download statistics
- Manage tester groups

### Build Artifacts
- APK files for testing
- App Bundle files for Play Store
- 30-day retention period

## 🚨 Troubleshooting

### Common Issues:

1. **Build Fails**
   - Check Flutter version compatibility
   - Verify dependencies in pubspec.yaml
   - Review build logs in GitHub Actions

2. **Firebase Distribution Fails**
   - Verify FIREBASE_APP_ID and FIREBASE_TOKEN secrets
   - Check Firebase project permissions
   - Ensure app is registered in Firebase

3. **Google Play Store Upload Fails**
   - Verify service account JSON
   - Check package name matches
   - Ensure app is published in Play Console

### Debug Commands:
```bash
# Test Firebase connection
firebase appdistribution:apps:list

# Check Flutter version
flutter --version

# Test build locally
flutter build apk --release
```

## 📊 Pipeline Status

The pipeline provides detailed status updates:

- ✅ **Build and Test**: Code compilation and testing
- ✅ **Firebase Distribution**: App distribution to testers
- ✅ **Google Play Store**: Production deployment
- ⏭️ **Skipped**: Conditions not met (e.g., not a release tag)

## 🔄 Automatic Updates

Your app will automatically:
1. **Check for updates** on app launch
2. **Notify users** when updates are available
3. **Download and install** updates seamlessly
4. **Fallback to manual** download if needed

## 📈 Best Practices

1. **Version Management**
   - Use semantic versioning (1.0.0, 1.0.1, 1.1.0)
   - Increment build numbers for each release
   - Use version tags for production releases

2. **Testing Strategy**
   - Test on develop branch first
   - Use beta group for extensive testing
   - Release to main when stable

3. **Release Notes**
   - Update release notes in CI/CD workflow
   - Document new features and bug fixes
   - Keep users informed about updates

## 🎉 Success!

Your CI/CD pipeline is now set up! Every time you push code or create a version tag, your app will be automatically built, tested, and distributed to your users.

### Next Steps:
1. Test the pipeline with a small change
2. Add more testers to your Firebase groups
3. Set up monitoring and analytics
4. Configure additional deployment targets if needed

---

**Need Help?** Check the GitHub Actions logs or Firebase Console for detailed error messages.
