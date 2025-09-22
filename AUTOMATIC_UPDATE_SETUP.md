# 🚀 GenZSpace - Automatic Update Setup Guide

## 🎯 **What You'll Get**

✅ **Automatic app builds** when you push code changes  
✅ **Automatic Play Store uploads** to internal testing  
✅ **Automatic update notifications** on your phone  
✅ **No more manual installation** needed  
✅ **Test new features immediately** on your phone  

---

## 📱 **Complete Setup Process**

### **Step 1: Google Play Console Setup**

1. **Go to Google Play Console**
   - Visit: https://play.google.com/console/
   - Sign in with: `sadhuj2005@gmail.com`
   - Pay the $25 registration fee (one-time)

2. **Create Your App**
   - Click "Create app"
   - **App name**: `GenZSpace`
   - **Default language**: English (United States)
   - **App or game**: App
   - **Free or paid**: Free
   - Click "Create app"

3. **Complete App Setup**
   - **Main store listing**: Add description, screenshots, app icon
   - **App content**: Complete all required sections, set content rating
   - **Pricing & distribution**: Set as free, select countries

4. **Set Up Internal Testing**
   - Go to "Testing" → "Internal testing"
   - Click "Create new release"
   - Upload will be automatic via CI/CD

5. **Add Yourself as Tester**
   - Go to "Testers" tab
   - Add your email: `sadhuj2005@gmail.com`
   - Copy the testing link

---

### **Step 2: Google Cloud Service Account**

1. **Go to Google Cloud Console**
   - Visit: https://console.cloud.google.com/
   - Create/select project: `GenZSpace`

2. **Create Service Account**
   - Go to "APIs & Services" → "Credentials"
   - Click "Create Credentials" → "Service Account"
   - **Name**: `genzspace-play-store`
   - **Role**: `Service Account User`
   - Click "Create and Continue"

3. **Download Service Account Key**
   - Click on your service account
   - Go to "Keys" tab
   - Click "Add Key" → "Create new key"
   - **Type**: JSON
   - **Download the JSON file** (keep it safe!)

4. **Link to Play Console**
   - Go to Play Console → "Setup" → "API access"
   - Click "Link project"
   - Select your Google Cloud project
   - Click "Link"

5. **Grant Permissions**
   - Find your service account in the list
   - Click "Grant access"
   - Select these permissions:
     - ✅ View app information and download bulk reports
     - ✅ View financial data, orders, and cancellation survey responses
     - ✅ Manage orders and subscriptions
     - ✅ Create, edit, and delete draft apps
     - ✅ Release apps to testing tracks
     - ✅ Release apps to production
   - Click "Invite user"

---

### **Step 3: GitHub Secrets Configuration**

1. **Go to GitHub Repository**
   - Visit: https://github.com/Sadhu2005/GenZSpace
   - Go to "Settings" → "Secrets and variables" → "Actions"

2. **Add Required Secrets**
   - Click "New repository secret" for each:

   **Secret 1: FIREBASE_APP_ID**
   - Name: `FIREBASE_APP_ID`
   - Value: `1:839050117776:android:ceadd7043e4cc3aafbce15`

   **Secret 2: FIREBASE_SERVICE_ACCOUNT_KEY**
   - Name: `FIREBASE_SERVICE_ACCOUNT_KEY`
   - Value: [Copy entire content of your Firebase service account JSON file]
   - Get from: Firebase Console → Project Settings → Service Accounts → Generate new private key

   **Secret 3: GOOGLE_PLAY_SERVICE_ACCOUNT_JSON**
   - Name: `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
   - Value: [Copy entire content of your Google Cloud service account JSON file]

   **Secret 4: DISCORD_WEBHOOK_URL (Optional)**
   - Name: `DISCORD_WEBHOOK_URL`
   - Value: [Your Discord webhook URL for notifications]

---

### **Step 4: Test the Complete Pipeline**

1. **Make a Test Change**
   ```bash
   # Open lib/main.dart and add a comment
   echo "// Test change - $(Get-Date)" >> lib/main.dart
   ```

2. **Commit and Push**
   ```bash
   git add .
   git commit -m "Test automatic update - $(Get-Date)"
   git push origin main
   ```

3. **Monitor the Process**
   - **GitHub Actions**: https://github.com/Sadhu2005/GenZSpace/actions
   - **Firebase Console**: https://console.firebase.google.com/project/genzspace
   - **Play Console**: https://play.google.com/console/

4. **Check Your Phone**
   - Open Google Play Store
   - Go to "My apps & games" → "Updates"
   - Look for GenZSpace update
   - Tap "Update" to get latest version

---

## 🔄 **How It Works**

### **Daily Development Workflow:**

1. **Code in Cursor AI** - Make your changes
2. **Commit and Push** - `git add . && git commit -m "New feature" && git push`
3. **Wait 5-10 minutes** - GitHub Actions builds and uploads
4. **Check your phone** - Get update notification
5. **Tap "Update"** - Get latest version automatically

### **What Happens Automatically:**

✅ **Code Analysis** - Flutter analyze and tests  
✅ **App Building** - APK and AAB generation  
✅ **Firebase Upload** - App Distribution to testers  
✅ **Play Store Upload** - Internal testing track  
✅ **Website Update** - Firebase Hosting deployment  
✅ **Notifications** - Discord/Slack messages  
✅ **GitHub Release** - Automatic release creation  

---

## 🧪 **Testing Your Setup**

### **Quick Test Script:**
```bash
# Run this to test your setup
scripts\test-automatic-update.bat
```

### **Manual Test:**
1. Make a small change in your code
2. Commit and push to GitHub
3. Wait 5-10 minutes
4. Check your phone for update notification
5. Tap "Update" to get latest version

---

## 🎯 **Success Indicators**

### **✅ Everything Working:**
- GitHub Actions workflow completes successfully
- Firebase App Distribution shows new release
- Play Store shows new internal testing release
- Your phone gets update notification
- App updates without manual installation

### **❌ Troubleshooting:**
- **No update appears**: Check Play Console, ensure release is "Rolled out to testers"
- **GitHub Actions fails**: Check secrets configuration
- **Play Store upload fails**: Verify service account permissions
- **No notification**: Check phone settings, ensure auto-update is enabled

---

## 📱 **Phone Settings**

### **Enable Automatic Updates:**
1. Go to **Settings** → **Apps** → **Google Play Store**
2. Make sure **"Auto-update apps"** is enabled
3. Or set to **"Auto-update apps over Wi-Fi only"**

### **Check for Updates:**
1. Open **Google Play Store**
2. Go to **"My apps & games"** → **"Updates"**
3. Look for **GenZSpace** update
4. Tap **"Update"** to get latest version

---

## 🚀 **Ready for Backend Development!**

Once your automatic update system is working:

1. **Start implementing backend features**
2. **Push changes to GitHub**
3. **Get automatic updates on your phone**
4. **Test features immediately**
5. **No more manual installation needed!**

---

## 📞 **Need Help?**

### **Setup Scripts:**
- `scripts\setup-automatic-updates.bat` - Complete setup
- `scripts\test-automatic-update.bat` - Test your setup
- `scripts\verify-phone-updates.bat` - Verify phone updates

### **Support:**
- Email: hello@zengspace.in
- GitHub Issues: Create issues for bugs and feature requests
- Firebase Console: Monitor app performance and usage

---

## 🎉 **Congratulations!**

You now have a **professional app distribution pipeline** that:
- ✅ Builds automatically when you push code
- ✅ Uploads to Play Store automatically
- ✅ Notifies you of updates on your phone
- ✅ Updates without manual installation
- ✅ Lets you test new features immediately

**🚀 Ready to start backend development with automatic testing!**
