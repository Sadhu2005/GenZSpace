# GenZSpace Firebase CI/CD Setup Guide

This guide will help you set up a complete CI/CD pipeline for GenZSpace, including Firebase deployment and Google Play Store internal testing.

## 🎯 Overview

The CI/CD pipeline includes:
- **Flutter App Build & Test** - Automated building and testing
- **Firebase Services Deployment** - Firestore, Storage, Hosting, Functions
- **App Distribution** - Firebase App Distribution for internal testing
- **Google Play Store** - Internal testing track uploads
- **Security Scanning** - Code quality and security checks
- **Notifications** - Discord/Slack notifications for deployment status

## 📋 Prerequisites

Before setting up the CI/CD pipeline, ensure you have:

1. **GitHub Repository** - Your code hosted on GitHub
2. **Firebase Project** - `genzspace` project configured
3. **Google Play Console** - App registered for internal testing
4. **Service Accounts** - For Firebase and Google Play Console API access

## 🚀 Step 1: Firebase Service Account Setup

### 1.1 Create Firebase Service Account

1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Select your Firebase project: **genzspace**
3. Go to **IAM & Admin** → **Service Accounts**
4. Click **Create Service Account**
5. Name: `firebase-ci-service-account`
6. Description: `Firebase CI/CD Service Account`
7. Click **Create and Continue**

### 1.2 Assign Required Roles

Assign these roles to the service account:
- **Firebase Admin**
- **Cloud Functions Admin**
- **Firebase Rules Admin**
- **Firebase Storage Admin**
- **Firebase Hosting Admin**
- **Firebase App Distribution Admin**

### 1.3 Generate Service Account Key

1. Click on the created service account
2. Go to **Keys** tab
3. Click **Add Key** → **Create new key**
4. Choose **JSON** format
5. Download the JSON file
6. Save it as `firebase-service-account.json`

## 🎮 Step 2: Google Play Console Setup

### 2.1 Enable Google Play Console API

1. Go to [Google Play Console](https://play.google.com/console/)
2. Select your app: **GenZSpace**
3. Go to **Setup** → **API access**
4. Link your Google Cloud project: **genzspace**
5. Accept the terms and conditions

### 2.2 Create Service Account for Play Store

1. In Google Play Console, go to **Setup** → **API access**
2. Click **Create new service account**
3. Follow the link to Google Cloud Console
4. Create a new service account with these details:
   - Name: `play-store-ci-service-account`
   - Description: `Google Play Store CI/CD Service Account`
   - Role: **Release Manager**

### 2.3 Grant Permissions

1. Go back to Google Play Console
2. In **API access**, find your service account
3. Click **Grant access**
4. Assign **Release Manager** role
5. Click **Invite user**

### 2.4 Download Service Account Key

1. Go to Google Cloud Console
2. Find your service account
3. Go to **Keys** tab
4. Create a new JSON key
5. Download and save as `google-play-service-account.json`

## 🔐 Step 3: GitHub Secrets Configuration

### 3.1 Add Firebase Service Account Secret

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret**
4. Name: `FIREBASE_SERVICE_ACCOUNT_KEY`
5. Value: Copy the entire contents of `firebase-service-account.json`

### 3.2 Add Google Play Service Account Secret

1. Click **New repository secret**
2. Name: `GOOGLE_PLAY_SERVICE_ACCOUNT_KEY`
3. Value: Copy the entire contents of `google-play-service-account.json`

### 3.3 Add Optional Notification Secrets

1. Click **New repository secret**
2. Name: `DISCORD_WEBHOOK_URL`
3. Value: Your Discord webhook URL for notifications

## 🛠️ Step 4: Local Development Setup

### 4.1 Install Required Tools

**For Windows:**
```cmd
# Install Node.js from https://nodejs.org/
# Install Python from https://python.org/

# Install Firebase CLI
npm install -g firebase-tools

# Install Python dependencies
pip install google-api-python-client google-auth-httplib2 google-auth-oauthlib
```

**For macOS/Linux:**
```bash
# Install Node.js
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
nvm install node

# Install Firebase CLI
npm install -g firebase-tools

# Install Python dependencies
pip3 install google-api-python-client google-auth-httplib2 google-auth-oauthlib
```

### 4.2 Firebase CLI Setup

```bash
# Login to Firebase
firebase login

# Initialize Firebase project (if not done)
firebase init

# Test Firebase deployment
firebase deploy --dry-run
```

### 4.3 Test Local Deployment

```bash
# Test Firebase deployment
firebase deploy --only firestore:rules
firebase deploy --only firestore:indexes
firebase deploy --only storage
firebase deploy --only hosting

# Test app distribution (if you have APK)
firebase appdistribution:distribute \
  path/to/your/app.apk \
  --app 1:839050117776:android:ceadd7043e4cc3aafbce15 \
  --groups "internal,testers" \
  --release-notes "Test release"
```

## 🔄 Step 5: CI/CD Pipeline Workflow

### 5.1 Workflow Triggers

The pipeline triggers on:
- Push to `main` or `master` branch
- Push to `develop` branch
- Pull requests to `main` or `master`
- Changes in Flutter code, Android/iOS configs, or Firebase configs

### 5.2 Pipeline Jobs

#### **Job 1: Build and Test Flutter App**
- Checkout code
- Setup Flutter environment
- Install dependencies
- Run code analysis
- Run tests with coverage
- Build Android APK (debug and release)
- Upload artifacts

#### **Job 2: Deploy Firebase Services**
- Deploy Firestore rules
- Deploy Firestore indexes
- Deploy Storage rules
- Deploy Firebase Hosting (website)
- Deploy Firebase Functions (if any)

#### **Job 3: App Distribution**
- Download APK artifacts
- Distribute to Firebase App Distribution
- Upload to Google Play Store Internal Testing
- Send notifications

#### **Job 4: Notifications**
- Send Discord notifications
- Create GitHub releases
- Update deployment status

#### **Job 5: Security Scan**
- Run CodeQL analysis
- Scan for secrets
- Security vulnerability checks

## 🚀 Step 6: Testing the Pipeline

### 6.1 Test Local Setup

```cmd
# Run the setup script (Windows)
scripts\setup-firebase-ci.bat

# Or manually test Firebase
firebase deploy --dry-run
```

### 6.2 Test GitHub Actions

1. Make a small change to your code
2. Commit and push:
   ```bash
   git add .
   git commit -m "Test CI/CD pipeline"
   git push origin main
   ```
3. Go to GitHub → Actions tab to monitor the deployment

### 6.3 Verify Deployments

1. **Firebase Console**: Check that rules and indexes are deployed
2. **Firebase App Distribution**: Verify APK is distributed to testers
3. **Google Play Console**: Check internal testing track
4. **Website**: Verify https://zengspace.in is updated

## 📊 Monitoring and Maintenance

### 6.1 GitHub Actions Monitoring

- Go to **Actions** tab in your GitHub repository
- Monitor deployment logs
- Check for any failures or warnings
- Review security scan results

### 6.2 Firebase Monitoring

- **Firebase Console**: Monitor app performance and usage
- **Firebase Analytics**: Track user engagement
- **Firebase Crashlytics**: Monitor app crashes
- **Firebase Performance**: Monitor app performance

### 6.3 Google Play Console Monitoring

- **Internal Testing**: Monitor tester feedback
- **Release Management**: Track release status
- **App Quality**: Monitor app quality metrics

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. Firebase Authentication Failed
```
Error: Firebase authentication failed
Solution: Check FIREBASE_SERVICE_ACCOUNT_KEY secret
```

#### 2. Google Play Upload Failed
```
Error: 403 Forbidden
Solution: Check GOOGLE_PLAY_SERVICE_ACCOUNT_KEY and permissions
```

#### 3. APK Build Failed
```
Error: Flutter build failed
Solution: Check Flutter version and dependencies
```

#### 4. Firestore Rules Deploy Failed
```
Error: Rules validation failed
Solution: Check firestore.rules syntax
```

### Debug Commands

**Test Firebase CLI:**
```bash
firebase projects:list
firebase use genzspace
firebase deploy --dry-run
```

**Test Google Play API:**
```python
python scripts/upload-to-playstore.py --help
```

**Check GitHub Secrets:**
- Go to repository Settings → Secrets
- Verify all required secrets are present

## 📚 Additional Resources

### Documentation
- [Firebase CLI Documentation](https://firebase.google.com/docs/cli)
- [Google Play Console API](https://developers.google.com/android-publisher)
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Flutter CI/CD Best Practices](https://docs.flutter.dev/deployment/ci)

### Tools and Services
- [Firebase Console](https://console.firebase.google.com/project/genzspace)
- [Google Play Console](https://play.google.com/console/)
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)

## 🎉 Success Checklist

- [ ] Firebase service account created and configured
- [ ] Google Play service account created and configured
- [ ] GitHub secrets configured
- [ ] Firebase CLI installed and authenticated
- [ ] Local deployment test successful
- [ ] GitHub Actions workflow working
- [ ] Firebase services deployed successfully
- [ ] App distributed to internal testers
- [ ] Google Play Store upload working
- [ ] Notifications configured
- [ ] Security scans passing

## 📞 Support

If you encounter any issues:

1. Check the troubleshooting section above
2. Review GitHub Actions logs
3. Verify Firebase and Google Play Console configuration
4. Check service account permissions
5. Contact support:
   - Email: hello@zengspace.in
   - GitHub Issues: Create an issue in your repository

---

**Congratulations!** 🎉 Your GenZSpace app now has a fully automated CI/CD pipeline for Firebase deployment and Google Play Store internal testing!
