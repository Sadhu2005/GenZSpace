# 🚀 Google Play Console Internal Testing Setup

## 🎯 **Goal: Automatic Updates on Your Phone**

You want to:
1. **Push code** to GitHub
2. **Automatic deployment** to Google Play Console
3. **Install from Play Store** on your phone
4. **Get automatic updates** when you push new code

---

## 📋 **Step-by-Step Setup**

### **Step 1: Create Google Play Console Account**

1. **Go to**: [Google Play Console](https://play.google.com/console)
2. **Sign in** with your Google account
3. **Pay $25** one-time registration fee
4. **Complete** developer account setup

### **Step 2: Create Your App**

1. **Click** "Create app"
2. **Fill in**:
   - **App name**: `GenZSpace`
   - **Default language**: English (United States)
   - **App or game**: App
   - **Free or paid**: Free
3. **Click** "Create app"

### **Step 3: Set Up App Signing**

1. **Go to**: Release > Setup > App signing
2. **Choose**: "Let Google manage and protect your app signing key"
3. **Click** "Accept"

### **Step 4: Create Service Account (For CI/CD)**

1. **Go to**: [Google Cloud Console](https://console.cloud.google.com/)
2. **Select** your project (or create one)
3. **Go to**: IAM & Admin > Service Accounts
4. **Click** "Create Service Account"
5. **Fill in**:
   - **Name**: `genzspace-ci`
   - **Description**: `CI/CD service account for GenZSpace`
6. **Click** "Create and Continue"
7. **Add role**: `Editor` or `Owner`
8. **Click** "Done"

### **Step 5: Generate Service Account Key**

1. **Click** on your service account
2. **Go to** "Keys" tab
3. **Click** "Add Key" > "Create new key"
4. **Choose** JSON format
5. **Download** the JSON file
6. **Keep this file secure!**

### **Step 6: Configure GitHub Secrets**

1. **Go to** your GitHub repository
2. **Click** Settings > Secrets and variables > Actions
3. **Click** "New repository secret"
4. **Name**: `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
5. **Value**: Copy the entire content of the JSON file
6. **Click** "Add secret"

### **Step 7: Set Up Internal Testing**

1. **In Google Play Console**, go to Release > Testing > Internal testing
2. **Click** "Create new release"
3. **Upload** your first AAB file (this will be done automatically by CI/CD)
4. **Add release notes**: "Initial release for internal testing"
5. **Click** "Save"

### **Step 8: Add Testers**

1. **Go to** Release > Testing > Internal testing
2. **Click** "Testers" tab
3. **Add** your email address
4. **Copy** the "Opt-in URL"
5. **Open** this URL on your phone
6. **Click** "Become a tester"

### **Step 9: Test the CI/CD Pipeline**

1. **Make a small change** to your code
2. **Commit and push** to `main` branch
3. **The workflow will automatically**:
   - Build the app
   - Increment version
   - Upload to Google Play Console
   - Release to internal testing

### **Step 10: Install on Your Phone**

1. **Open** the Opt-in URL on your phone
2. **Click** "Become a tester"
3. **Go to** Google Play Store
4. **Search** for "GenZSpace"
5. **Install** the app
6. **You're done!** 🎉

---

## 🔄 **How Updates Work**

### **Automatic Updates:**
- **Every time** you push code to `main` branch
- **CI/CD automatically** builds and uploads new version
- **Google Play Store** will notify you of updates
- **You can update** directly from Play Store (no reinstall needed)

### **Your Development Flow:**
1. **Code locally** ✅
2. **Test on web** (Chrome) ✅
3. **Commit and push** to GitHub
4. **Wait 5-10 minutes** for build to complete
5. **Check your phone** for update notification
6. **Update from Play Store** ✅

---

## 🛠️ **Troubleshooting**

### **Common Issues:**

#### **1. Service Account JSON:**
- **Make sure** it's properly formatted
- **Check** all permissions are correct
- **Verify** the JSON is complete

#### **2. Package Name:**
- **Must match** `com.anu.GenZSpace`
- **Check** in `android/app/build.gradle.kts`

#### **3. Signing:**
- **Let Google manage** your signing key
- **Don't upload** your own keystore

#### **4. Permissions:**
- **Service account** needs proper permissions
- **Check** IAM roles in Google Cloud Console

### **Check Workflow Status:**
1. **Go to** GitHub repository
2. **Click** "Actions" tab
3. **Check** the latest workflow run
4. **Look for** any error messages

---

## 📱 **Your Testing Workflow**

### **Daily Development:**
1. **Code locally** ✅
2. **Test on web** (Chrome) ✅
3. **Commit and push** to GitHub
4. **Wait for CI/CD** to complete
5. **Update on phone** from Play Store
6. **Test on real device** ✅

### **Weekly Releases:**
1. **Make changes** to your code
2. **Push to GitHub**
3. **Wait 5-10 minutes**
4. **Update on phone**
5. **Test all features**

---

## 🎯 **Next Steps**

1. **Follow** the setup steps above
2. **Set up** Google Play Console (30-60 minutes)
3. **Configure** GitHub secrets (5 minutes)
4. **Test** the pipeline (5-10 minutes)
5. **Install** on your phone
6. **Enjoy** automatic updates! 🎉

---

**🚀 You'll have automatic updates on your phone in about 1 hour!**
