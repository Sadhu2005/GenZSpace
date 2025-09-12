# 🚀 GenZSpace CI/CD Deployment Guide

This guide will help you set up a complete CI/CD pipeline for GenZSpace using GitHub Actions.

## 📋 Prerequisites

- GitHub repository with GenZSpace code
- Firebase project created
- Android/iOS app registered in Firebase

## 🔧 Setup Steps

### 1. Firebase Console Setup

1. **Go to Firebase Console:**
   - Visit [Firebase Console](https://console.firebase.google.com/)
   - Select your GenZSpace project

2. **Get App IDs:**
   - Go to **Project Settings** → **General**
   - Copy your **Android App ID** and **iOS App ID**
   - Note down your **Project ID**

### 2. Update Configuration Files

1. **Update `firebase.json`:**
   - Replace `YOUR_FIREBASE_PROJECT_ID` with your actual project ID
   - Replace `YOUR_ANDROID_APP_ID` with your Android app ID
   - Replace `YOUR_EMAIL@gmail.com` with your email address

2. **Update `lib/firebase_options.dart`:**
   - Replace all placeholder values with your actual Firebase configuration
   - Get these values from Firebase Console → Project Settings → General

### 3. Test the Pipeline

1. **Make a Test Change:**
   - Edit any file (e.g., add a comment)
   - Commit and push to `main` or `develop` branch

2. **Monitor the Build:**
   - Go to **Actions** tab in GitHub
   - Watch the workflow run
   - Check for any errors

3. **Download Build Artifacts:**
   - Go to the completed workflow run
   - Download the APK or App Bundle from the Artifacts section

## 📱 Testing on Device

### Android Testing

1. **Download APK:**
   - Go to GitHub Actions → Completed workflow
   - Download the `genzspace-apk` artifact
   - Extract the APK file

2. **Install on Device:**
   - Enable "Install from unknown sources" in Android settings
   - Install the APK
   - Test all features

### iOS Testing

1. **Download iOS Build:**
   - Go to GitHub Actions → Completed workflow
   - Download the `genzspace-ios` artifact
   - Extract the iOS build

2. **Install on Device:**
   - Use Xcode or TestFlight for installation
   - Test all features

## 🔄 Continuous Deployment

Once set up, the pipeline will automatically:

- ✅ Build the app on every push to `main` or `develop`
- ✅ Run tests to ensure code quality
- ✅ Create release APK and App Bundle
- ✅ Upload build artifacts for download
- ✅ Send notifications on build status

## 🛠️ Troubleshooting

### Common Issues

1. **Build Fails:**
   - Check Flutter version compatibility
   - Verify all dependencies are correct
   - Check GitHub Actions logs for specific errors

2. **APK Installation Fails:**
   - Check Android version compatibility
   - Verify APK is not corrupted
   - Enable unknown sources installation

### Getting Help

- Check GitHub Actions logs for detailed error messages
- Verify Firebase Console for any configuration issues
- Test locally with `flutter build apk --release`

## 📚 Next Steps

After successful CI/CD setup:

1. **Backend Integration:**
   - Start implementing Firebase backend features
   - Test with real data

2. **Feature Development:**
   - Add new features incrementally
   - Test each feature through the pipeline

3. **Production Deployment:**
   - Set up production Firebase project
   - Configure app store deployment

---

**🎉 Congratulations!** Your GenZSpace app now has a complete CI/CD pipeline for rapid development and testing!