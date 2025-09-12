# 🚀 GenZSpace CI/CD Deployment Guide

This guide will help you set up a complete CI/CD pipeline for GenZSpace app testing and deployment.

## 📋 Prerequisites

1. **GitHub Repository** (already have)
2. **Firebase Project** (already created)
3. **Android Studio** (for local testing)
4. **Xcode** (for iOS testing, Mac only)

## 🔧 Setup Steps

### Step 1: Firebase App Distribution Setup

1. **Go to Firebase Console**
   - Visit: https://console.firebase.google.com
   - Select your GenZSpace project

2. **Enable App Distribution**
   - Go to "App Distribution" in left sidebar
   - Click "Get Started"
   - Add your Android app (if not already added)

3. **Get Firebase App ID**
   - Go to Project Settings → General
   - Copy your Android App ID (format: `1:123456789:android:abcdef123456`)
   - Copy your iOS App ID (if you have iOS app)

4. **Create Firebase Token**
   - Go to Project Settings → Service Accounts
   - Click "Generate New Private Key"
   - Download the JSON file
   - Extract the token from the JSON

### Step 2: GitHub Secrets Setup

1. **Go to your GitHub repository**
2. **Navigate to Settings → Secrets and Variables → Actions**
3. **Add these secrets:**

```
FIREBASE_TOKEN = your_firebase_token_here
FIREBASE_APP_ID = 1:123456789:android:abcdef123456
FIREBASE_IOS_APP_ID = 1:123456789:ios:abcdef123456 (if iOS)
```

### Step 3: Update Firebase Configuration

1. **Update `firebase.json`**
   - Replace `"genzspace-app"` with your actual Firebase project ID
   - Replace the app ID with your actual Android app ID
   - Add your email to the testers list

2. **Update App Configuration**
   - Add your Firebase project configuration to the app

### Step 4: Test the Pipeline

1. **Make a small change** to your app (like updating a text)
2. **Commit and push** to `main` or `develop` branch
3. **Check GitHub Actions** tab in your repository
4. **Wait for build** to complete (5-10 minutes)
5. **Check your email** for Firebase App Distribution link

## 📱 Installing Test Builds

### Android
1. **Check your email** for Firebase App Distribution notification
2. **Click the link** in the email
3. **Download the APK** directly to your phone
4. **Install the APK** (enable "Install from unknown sources" if needed)

### iOS (if you have iOS app)
1. **Check your email** for Firebase App Distribution notification
2. **Click the link** in the email
3. **Install via TestFlight** or direct installation

## 🔄 Workflow Process

### Automatic Triggers
- **Push to `main`**: Creates production build
- **Push to `develop`**: Creates development build
- **Pull Request**: Runs tests only

### Manual Triggers
- **Go to Actions tab** in GitHub
- **Select "Build and Distribute GenZSpace"**
- **Click "Run workflow"**

## 📊 Monitoring Builds

### GitHub Actions
- **Go to Actions tab** in your repository
- **View build logs** and status
- **Check for errors** and fix them

### Firebase App Distribution
- **Go to Firebase Console → App Distribution**
- **View build history**
- **Manage testers**
- **Check crash reports**

## 🛠️ Troubleshooting

### Common Issues

1. **Build Fails**
   - Check Flutter version compatibility
   - Verify all dependencies are correct
   - Check for syntax errors

2. **Firebase Upload Fails**
   - Verify Firebase token is correct
   - Check app ID matches Firebase project
   - Ensure Firebase project has App Distribution enabled

3. **APK Won't Install**
   - Enable "Install from unknown sources"
   - Uninstall previous version first
   - Check Android version compatibility

### Getting Help
- Check GitHub Actions logs for detailed error messages
- Verify Firebase configuration
- Test locally with `flutter run` first

## 🎯 Next Steps

Once CI/CD is working:

1. **Test the pipeline** with small changes
2. **Add more testers** to Firebase App Distribution
3. **Set up Firebase backend** integration
4. **Implement real-time features**
5. **Prepare for app store submission**

## 📞 Support

If you encounter issues:
1. Check the GitHub Actions logs
2. Verify Firebase configuration
3. Test locally first
4. Check Flutter and Firebase documentation

---

**Happy Testing! 🚀**

Your app will now automatically build and distribute to your phone whenever you push changes!
