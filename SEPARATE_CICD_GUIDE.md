# 🎯 Separate CI/CD Triggers Guide

## 🚀 **How to Use Separate CI/CD Triggers**

### **Automatic Triggers (Smart Detection)**

**Website CI/CD** triggers automatically when you push changes to:
- `website/` folder
- `website/index.html`
- `website/privacy.html`
- `website/404.html`
- `website/assets/` folder

**App CI/CD** triggers automatically when you push changes to:
- `lib/` folder (Flutter app code)
- `android/` folder (Android specific)
- `ios/` folder (iOS specific)
- `firebase.json`
- `firestore.rules`
- `firestore.indexes.json`

### **Manual Triggers (You Choose)**

## 🎯 **Manual Trigger Options**

### **Option 1: Run Website CI/CD Only**

1. **Go to GitHub Actions**
   - Go to your repository
   - Click **Actions** tab
   - Find **"Deploy Website to Hostinger"**

2. **Run Manually**
   - Click **"Run workflow"** button
   - Select branch (usually `main`)
   - Click **"Run workflow"**

3. **What it does:**
   - Deploys only your website
   - Updates https://genzspace.in
   - Updates privacy policy
   - Does NOT touch your app

### **Option 2: Run App CI/CD Only**

1. **Go to GitHub Actions**
   - Go to your repository
   - Click **Actions** tab
   - Find **"Firebase Deploy & App Distribution"**

2. **Run Manually**
   - Click **"Run workflow"** button
   - Select branch (usually `main`)
   - Click **"Run workflow"**

3. **What it does:**
   - Builds your Flutter app
   - Deploys to Firebase
   - Uploads to Google Play Store
   - Does NOT touch your website

## 🔄 **Smart Automatic Triggers**

### **When Website CI/CD Runs Automatically:**
```
✅ You edit website/index.html
✅ You edit website/privacy.html
✅ You add new images to website/assets/
✅ You edit website/404.html
✅ You update website/robots.txt
```

### **When App CI/CD Runs Automatically:**
```
✅ You edit lib/main.dart
✅ You edit lib/screens/home_screen.dart
✅ You add new features to lib/
✅ You update firebase.json
✅ You change app configuration
```

### **When Both Run (Rare):**
```
⚠️ You edit both website/ and lib/ in same commit
⚠️ You edit root files like README.md
```

## 🎯 **Best Practices**

### **For Website Updates:**
1. **Edit only files in `website/` folder**
2. **Commit and push**
3. **Website CI/CD runs automatically**
4. **App CI/CD stays quiet**

### **For App Updates:**
1. **Edit only files in `lib/` folder**
2. **Commit and push**
3. **App CI/CD runs automatically**
4. **Website CI/CD stays quiet**

### **For Both Updates:**
1. **Make separate commits**
2. **First commit: website changes**
3. **Second commit: app changes**
4. **Each triggers its own CI/CD**

## 🚀 **Quick Commands**

### **Test Website Only:**
```bash
# Make a small change to website
echo "<!-- Test update -->" >> website/index.html
git add website/
git commit -m "Test website update"
git push
# Only website CI/CD will run
```

### **Test App Only:**
```bash
# Make a small change to app
echo "// Test update" >> lib/main.dart
git add lib/
git commit -m "Test app update"
git push
# Only app CI/CD will run
```

## 📱 **Monitoring Your Deployments**

### **Check Website Deployment:**
- **GitHub Actions**: Look for "Deploy Website to Hostinger"
- **Live Site**: https://genzspace.in
- **Privacy Policy**: https://genzspace.in/privacy.html

### **Check App Deployment:**
- **GitHub Actions**: Look for "Firebase Deploy & App Distribution"
- **Firebase Console**: Check App Distribution
- **Google Play Console**: Check Internal Testing

## 🎉 **Success Indicators**

### **Website Success:**
- ✅ GitHub Actions shows green checkmark
- ✅ Website loads at https://genzspace.in
- ✅ Privacy policy accessible
- ✅ No errors in logs

### **App Success:**
- ✅ GitHub Actions shows green checkmark
- ✅ Firebase shows new build
- ✅ Google Play Console shows new version
- ✅ App updates on your phone

---

**Now you have full control over which CI/CD runs!** 🎯
