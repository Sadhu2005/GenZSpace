# 🔧 Google Play Console Setup Guide

## 🚨 **If "Setup → API access" is Not Visible**

### **Alternative Method 1: Direct Google Cloud Console Setup**

**This is the most reliable method:**

1. **Go to Google Cloud Console:** https://console.cloud.google.com
2. **Select your project** (the same project linked to your Play Console)
3. **Go to IAM & Admin** → **Service Accounts**
4. **Click "Create Service Account"**
5. **Fill in details:**
   - **Name:** `genzspace-ci-cd`
   - **Description:** `Service account for GenZSpace CI/CD automation`
6. **Click "Create and Continue"**

### **Step 2: Grant Required Permissions**

**Add these roles to your service account:**
- **Service Account User**
- **Storage Object Viewer** (if using Firebase Storage)
- **Firebase Admin** (if using Firebase)

### **Step 3: Create JSON Key**

1. **Click on your created service account**
2. **Go to "Keys" tab**
3. **Click "Add Key"** → **"Create new key"**
4. **Select "JSON" format**
5. **Click "Create"**
6. **Download the JSON file** (keep it secure!)

## 🔑 **Alternative Method 2: Play Console API Setup**

### **If you can find API access:**

1. **Go to Google Play Console:** https://play.google.com/console
2. **Look for these sections:**
   - **Setup** → **API access**
   - **Settings** → **API access**
   - **Developer account** → **API access**
   - **Account** → **API access**

### **If you find it:**
1. **Click "Link project"** if not already linked
2. **Grant access** to your service account
3. **Enable "Release apps to testing tracks"** permission

## 🚀 **Alternative Method 3: Direct Service Account Setup**

### **This method works without Play Console API access:**

1. **Create service account** in Google Cloud Console (as above)
2. **Download JSON key**
3. **Add to GitHub secrets**
4. **Test the CI/CD** - it should work automatically

## 🔍 **Finding the Right Section in Play Console**

### **Look for these sections:**
- **Setup** → **API access**
- **Settings** → **API access** 
- **Developer account** → **API access**
- **Account** → **API access**
- **Users and permissions**
- **API credentials**

### **If you still can't find it:**
- **Your account might not have the right permissions**
- **Try using the direct Google Cloud Console method**
- **The CI/CD should work without Play Console API access**

## 🧪 **Test Without Play Console API Access**

### **You can still test the CI/CD:**

1. **Create service account** in Google Cloud Console
2. **Download JSON key**
3. **Add to GitHub secrets**
4. **Push a test change**
5. **Check if it works**

### **If it doesn't work:**
- **Check the GitHub Actions logs** for specific errors
- **Verify the service account has the right permissions**
- **Make sure the package name matches** (com.anu.GenZSpace)

## 🔧 **Quick Setup Without Play Console**

### **Step 1: Google Cloud Console Only**
1. **Go to:** https://console.cloud.google.com
2. **Select your project**
3. **Create service account** (as described above)
4. **Download JSON key**

### **Step 2: Add to GitHub**
1. **Go to your GitHub repository**
2. **Settings** → **Secrets and variables** → **Actions**
3. **Add secret:** `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
4. **Value:** Copy entire JSON file content

### **Step 3: Test**
1. **Make a small change** to your app
2. **Push to GitHub**
3. **Check GitHub Actions**
4. **See if it uploads to Play Store**

## 🎯 **Expected Results**

### **If it works:**
- ✅ **GitHub Actions** shows green checkmark
- ✅ **App uploads** to Play Store automatically
- ✅ **Your phone** shows update available

### **If it doesn't work:**
- ❌ **Check GitHub Actions logs** for errors
- ❌ **Verify service account permissions**
- ❌ **Check package name** in workflow

## 🚀 **Next Steps**

1. **Try the Google Cloud Console method first**
2. **Add the JSON key to GitHub secrets**
3. **Test with a small change**
4. **Check if it uploads to Play Store**

**Let me know what happens when you try this!** 🎯
