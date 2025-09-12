# 📱 GenZSpace APK Installation Guide

## 🚀 Download the APK

1. **Go to GitHub Actions:**
   - Visit your GenZSpace repository on GitHub
   - Click on **"Actions"** tab
   - Click on the latest successful workflow run (green checkmark)
   - Scroll down to **"Artifacts"** section
   - Download **"genzspace-apk"**

2. **Extract the APK:**
   - The download will be a ZIP file
   - Extract it to get the APK file (`app-release.apk`)

## 📲 Install on Android Device

### Method 1: Direct Installation
1. **Transfer APK to phone:**
   - Copy the APK file to your Android device
   - Use USB cable, cloud storage, or email

2. **Enable Unknown Sources:**
   - Go to **Settings** → **Security** → **Install unknown apps**
   - Enable installation from your file manager or browser

3. **Install:**
   - Tap the APK file
   - Follow installation prompts
   - Launch the app

### Method 2: ADB Installation (for developers)
```bash
adb install app-release.apk
```

## 🔧 Troubleshooting

### If APK won't install:
1. **Check Android version:** Requires Android 5.0+ (API 21+)
2. **Enable Developer Options:**
   - Go to Settings → About Phone
   - Tap "Build Number" 7 times
   - Go back to Settings → Developer Options
   - Enable "USB Debugging" and "Install via USB"

3. **Clear storage:**
   - Go to Settings → Apps → GenZSpace
   - Clear cache and data

### If app crashes on startup:
1. **Check permissions:**
   - Go to Settings → Apps → GenZSpace → Permissions
   - Enable all required permissions

2. **Restart device:**
   - Sometimes a simple restart fixes issues

3. **Reinstall:**
   - Uninstall the app
   - Download fresh APK
   - Install again

## 🔄 Auto-Update Feature

The app now includes an auto-update checker:
- **Checks for updates** when the app starts
- **Shows update dialog** if new version is available
- **Opens download page** when you tap "Download Update"

## 📞 Support

If you're still having issues:
1. Check the GitHub Actions logs for build errors
2. Try downloading a fresh APK
3. Make sure your device meets the requirements

---

**🎉 Enjoy using GenZSpace!**
