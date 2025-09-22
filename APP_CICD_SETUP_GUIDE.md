# 📱 App CI/CD Setup Guide for Google Play Store Internal Testing

## 🎯 **Goal: Automatic App Updates to Your Phone**

### **What This Achieves:**
- ✅ **Automatic builds** when you push code changes
- ✅ **Automatic uploads** to Google Play Store Internal Testing
- ✅ **Automatic updates** on your phone (no reinstalling needed)
- ✅ **Test new features** immediately after development

## 🔧 **Setup Requirements**

### **Step 1: Google Play Console Service Account**

**You need to create a service account for automated uploads:**

1. **Go to Google Cloud Console:** https://console.cloud.google.com
2. **Select your project** (the same one linked to your Play Console)
3. **Go to IAM & Admin** → **Service Accounts**
4. **Click "Create Service Account"**
5. **Name:** `genzspace-ci-cd`
6. **Description:** `Service account for GenZSpace CI/CD automation`
7. **Click "Create and Continue"**

### **Step 2: Grant Permissions**

**Add these roles to your service account:**
- **Service Account User**
- **Storage Object Viewer** (if using Firebase Storage)

### **Step 3: Create and Download JSON Key**

1. **Click on your service account**
2. **Go to "Keys" tab**
3. **Click "Add Key"** → **"Create new key"**
4. **Select "JSON"** format
5. **Download the JSON file**
6. **Keep it secure** - this is your private key

### **Step 4: Link Service Account to Play Console**

1. **Go to Google Play Console:** https://play.google.com/console
2. **Go to Setup** → **API access**
3. **Click "Link project"** if not already linked
4. **Grant access** to your service account
5. **Enable "Release apps to testing tracks"** permission

## 🔑 **GitHub Secrets Setup**

### **Add This Secret to GitHub:**

1. **Go to your GitHub repository**
2. **Settings** → **Secrets and variables** → **Actions**
3. **Click "New repository secret"**
4. **Name:** `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
5. **Value:** Copy the entire content of your downloaded JSON file
6. **Click "Add secret"**

## 🚀 **How the CI/CD Works**

### **Automatic Triggers:**
- **Push to main/master/develop** with changes to:
  - `lib/` folder (Flutter app code)
  - `android/` folder (Android specific)
  - `ios/` folder (iOS specific)
  - `firebase.json`
  - `firestore.rules`
  - `firestore.indexes.json`
  - `storage.rules`

### **What Happens:**
1. **Code is pushed** to GitHub
2. **GitHub Actions** automatically starts
3. **Flutter app is built** (AAB file)
4. **App is uploaded** to Google Play Store Internal Testing
5. **You get notified** on your phone
6. **You can update** the app without reinstalling

## 🧪 **Test the Setup**

### **Step 1: Make a Small Change**
```bash
# Make a small change to your app
echo "// Test update $(date)" >> lib/main.dart

# Commit and push
git add lib/
git commit -m "Test automatic app deployment"
git push
```

### **Step 2: Check GitHub Actions**
1. **Go to Actions tab** in GitHub
2. **Look for "📱 Deploy App to Google Play Store Internal Testing"**
3. **Wait for completion** (usually 5-10 minutes)
4. **Check for green checkmark**

### **Step 3: Check Google Play Console**
1. **Go to Google Play Console**
2. **Go to Testing** → **Internal testing**
3. **Look for your new build**
4. **Check the release notes**

### **Step 4: Update on Your Phone**
1. **Open Google Play Store** on your phone
2. **Search for "GenZSpace"** or go to "My apps & games"
3. **Look for "Update" button**
4. **Tap "Update"** (no reinstalling needed!)
5. **Test your new features**

## 📱 **Expected Results**

### **After Successful Setup:**
- ✅ **Automatic builds** on every push
- ✅ **Automatic uploads** to Play Store
- ✅ **Automatic updates** on your phone
- ✅ **No more manual reinstalling**
- ✅ **Test features immediately**

### **Timeline:**
- **Push code** → **2-3 minutes** → **Build complete**
- **Build complete** → **2-3 minutes** → **Upload to Play Store**
- **Upload complete** → **5-10 minutes** → **Available for update**

## 🔍 **Troubleshooting**

### **Common Issues:**

**Issue 1: Service Account JSON Error**
- **Check:** JSON file is correctly added to GitHub secrets
- **Check:** Service account has proper permissions
- **Check:** Package name matches (com.anu.GenZSpace)

**Issue 2: Upload Permission Denied**
- **Check:** Service account is linked to Play Console
- **Check:** "Release apps to testing tracks" permission is enabled
- **Check:** App is already created in Play Console

**Issue 3: Build Fails**
- **Check:** Flutter version compatibility
- **Check:** Android SDK version
- **Check:** Dependencies in pubspec.yaml

### **Debug Steps:**
1. **Check GitHub Actions logs** for specific errors
2. **Verify service account JSON** is valid
3. **Test manual upload** to Play Console first
4. **Check Play Console permissions**

## 🎉 **Success Indicators**

### **You'll know it's working when:**
- ✅ **GitHub Actions** shows green checkmark
- ✅ **Google Play Console** shows new build
- ✅ **Your phone** shows update available
- ✅ **App updates** without reinstalling

## 🚀 **Next Steps After Setup**

1. **Test with a small change** to your app
2. **Verify automatic build** and upload
3. **Update app on your phone**
4. **Test new features**
5. **Enjoy automatic updates!**

## 📊 **Monitoring Your CI/CD**

### **GitHub Actions:**
- **Check build status** in Actions tab
- **View detailed logs** for debugging
- **Monitor build times** and performance

### **Google Play Console:**
- **Check upload status** in Internal Testing
- **Monitor app performance** and crashes
- **Review user feedback** from testers

---

**Once set up, you'll have automatic app updates to your phone!** 🎯

**No more reinstalling - just push code and test immediately!** 🚀
