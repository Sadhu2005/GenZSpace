# 📱 GenZSpace Installation & Testing Guide

## 🚀 **How to Install and Test GenZSpace**

### **Step 1: Check Workflow Success**
1. **Go to your GitHub repository Actions tab**
2. **Verify the latest workflow ran successfully** ✅
3. **Check the summary shows:**
   - ✅ GenZSpace Deployed Successfully
   - ✅ Version: 1.0.0 (2)
   - ✅ Status: Ready for testing

### **Step 2: Google Play Console Setup**
1. **Open [Google Play Console](https://play.google.com/console/)**
2. **Navigate to:** GenZSpace app → Testing → Internal testing
3. **Look for:** Your new build (created by CI/CD)
4. **Click:** "Review release" if needed

### **Step 3: Add Internal Testers**
**Option A: Add Testers (Recommended)**
1. **Internal testing → Testers tab**
2. **Add yourself as a tester** by adding your Google account email
3. **Save and close**

**Option B: Use Direct Link**
1. **Copy your internal testing link** from Google Play Console
2. **Share link to install on device**

### **Step 4: Install on Your Phone**

#### **📱 On Your Phone:**
1. **Open Google Play Store app**
2. **Search for "GenZSpace"**
3. **Look for "Internal testing" version**
4. **OR use the direct testing link** (found in Google Play Console)

#### **🔗 Alternative - Direct Link Method:**
1. **Go to GitHub Actions → Latest run → Summary**
2. **Copy the Google Play link if provided**
3. **Open link on your phone's browser**
4. **Follow installation prompts**

### **Step 5: Test GenZSpace Features**

#### **🧪 Internal Testing Checklist:**
- ✅ **App launches successfully**
- ✅ **Login/signup screens working**
- ✅ **Navigation between screens**
- ✅ **Profile setup process**
- ✅ **Social features (My Vibes, Feed, Chat)**
- ✅ **Academic features (Study Swap, Search)**

#### **📋 Test Scenarios:**
1. **First Launch:** Check boot screen → register account
2. **Profile Setup:** Add college, course, interests
3. **Social Features:** Create vibe, post to feed
4. **Study Features:** Browse Study Swap, try searching
5. **General:** Test in-app notifications, settings

### **🔄 Automatic Update Testing:**

#### **For Continuous Testing:**
1. **After making any code changes:**
   ```bash
   git add .
   git commit -m "Feature: Test XYZ"
   git push origin main
   ```
2. **Wait 5-10 minutes**
3. **Check phone for update notification**
4. **Google Play will show "Update" for GenZSpace**
5. **Test new changes immediately**

### **📱 Troubleshooting:**

#### **❌ If App Not Found:**
- **Check Google Play Console** → Testing → Internal testing has your email
- **Try direct link method** from Console
- **Wait 5-10 minutes** after workflow completion

#### **❌ If Update Doesn't Work:**
- **Clear Play Store cache** (Settings → Apps → Play Store → Clear Cache)
- **Sign out and back into Google Play**
- **Check that you're added as internal tester**

#### **❌ If CI/CD Fails:**
- **Check GitHub repository** → Settings → Secrets
- **Verify `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON` is correct**
- **Re-run workflow if needed**

---

## *🎯 Your Testing Workflow*

**Making a change:**
```
Edit Code → git commit → git push → 
5-10 min wait → Find update in Google Play → Test change
```

**🎉 Perfect development-testing cycle!** Your GenZSpace will always be on your device for automated testing during development.
