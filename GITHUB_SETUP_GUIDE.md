# 🔐 GitHub Secrets Setup Guide

## Required GitHub Secrets

You need to add these secrets to your GitHub repository for the CI/CD pipeline to work.

### 1. Go to GitHub Repository Settings

1. Open your GitHub repository: `https://github.com/[your-username]/GenZSpace`
2. Click on **Settings** tab
3. In the left sidebar, click **Secrets and variables** → **Actions**
4. Click **New repository secret**

### 2. Add Required Secrets

#### Secret 1: FIREBASE_APP_ID
- **Name**: `FIREBASE_APP_ID`
- **Value**: `1:839050117776:android:ceadd7043e4cc3aafbce15`
- **Description**: Your Firebase app ID from firebase.json

#### Secret 2: FIREBASE_TOKEN
- **Name**: `FIREBASE_TOKEN`
- **Value**: [Get this from Firebase CLI]
- **Description**: Firebase CI token for authentication

### 3. Get Firebase Token

Run these commands in your terminal:

```bash
# Install Firebase CLI (if not already installed)
npm install -g firebase-tools

# Login to Firebase
firebase login

# Generate CI token
firebase login:ci
```

Copy the token that appears and add it as `FIREBASE_TOKEN` secret.

### 4. Optional: Google Play Store Secrets

If you want to deploy to Google Play Store:

#### Secret 3: GOOGLE_PLAY_SERVICE_ACCOUNT_JSON
- **Name**: `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
- **Value**: [Service account JSON from Google Play Console]
- **Description**: Service account for Play Store uploads

## Verification

After adding secrets, your GitHub repository should have:
- ✅ FIREBASE_APP_ID
- ✅ FIREBASE_TOKEN
- ✅ GOOGLE_PLAY_SERVICE_ACCOUNT_JSON (optional)

## Next Steps

1. Test the pipeline by pushing to develop branch
2. Check GitHub Actions for build status
3. Verify Firebase App Distribution receives the build
