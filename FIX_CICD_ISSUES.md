# 🔧 Fix CI/CD Issues Guide

## 🚨 **Current Problems**

### **Problem 1: Both Workflows Running**
- ✅ **Fixed**: Added `paths-ignore` to prevent cross-triggering
- ✅ **App CI/CD** now ignores `website/**` changes
- ✅ **Website CI/CD** now ignores `lib/**`, `android/**`, `ios/**` changes

### **Problem 2: Website Deployment Failing**
- ❌ **Issue**: Missing GitHub secrets for Hostinger
- ❌ **Issue**: FTP credentials not configured
- ❌ **Issue**: Deployment failing without showing jobs

## 🎯 **Solution Steps**

### **Step 1: Add GitHub Secrets (Required)**

**Go to GitHub Repository:**
1. Go to your **GenZSpace repository** on GitHub
2. Click **Settings** tab
3. Click **Secrets and variables** → **Actions**
4. Click **New repository secret**

**Add These 3 Secrets:**

**Secret 1: HOSTINGER_USERNAME**
- Name: `HOSTINGER_USERNAME`
- Value: `your_ftp_username`

**Secret 2: HOSTINGER_PASSWORD**
- Name: `HOSTINGER_PASSWORD`
- Value: `your_ftp_password`

**Secret 3: HOSTINGER_HOST**
- Name: `HOSTINGER_HOST`
- Value: `ftp.genzspace.in`

### **Step 2: Test Website-Only Deployment**

**Make a small change to website:**
```bash
echo "<!-- Test update $(date) -->" >> website/index.html
git add website/
git commit -m "Test website deployment"
git push
```

**Expected Result:**
- ✅ **Only website CI/CD** should run
- ✅ **App CI/CD** should NOT run
- ✅ **Website deployment** should succeed

### **Step 3: Test App-Only Deployment**

**Make a small change to app:**
```bash
echo "// Test update $(date)" >> lib/main.dart
git add lib/
git commit -m "Test app deployment"
git push
```

**Expected Result:**
- ✅ **Only app CI/CD** should run
- ✅ **Website CI/CD** should NOT run
- ✅ **App deployment** should succeed

## 🔍 **Troubleshooting**

### **If Website Deployment Still Fails:**

**Check 1: GitHub Secrets**
- Go to **Settings** → **Secrets and variables** → **Actions**
- Verify all 3 secrets are added:
  - `HOSTINGER_USERNAME`
  - `HOSTINGER_PASSWORD`
  - `HOSTINGER_HOST`

**Check 2: FTP Credentials**
- Login to Hostinger hPanel
- Go to **Files** → **FTP Accounts**
- Verify FTP server, username, and password

**Check 3: Workflow Logs**
- Go to **Actions** tab
- Click on failed workflow
- Check the logs for specific error messages

### **If Both Workflows Still Run:**

**Check 1: Path Filters**
- Website changes should only trigger website CI/CD
- App changes should only trigger app CI/CD

**Check 2: Branch**
- Make sure you're pushing to `main` or `master` branch
- Other branches might have different triggers

## 🎯 **Quick Fix Commands**

### **Test Website Deployment:**
```bash
# Make a small change
echo "<!-- Website test $(date) -->" >> website/index.html

# Commit and push
git add website/
git commit -m "Test website deployment"
git push

# Check Actions tab - should see only "Deploy Website to Hostinger"
```

### **Test App Deployment:**
```bash
# Make a small change
echo "// App test $(date)" >> lib/main.dart

# Commit and push
git add lib/
git commit -m "Test app deployment"
git push

# Check Actions tab - should see only "Firebase Deploy & App Distribution"
```

## ✅ **Success Indicators**

### **Website Deployment Success:**
- ✅ GitHub Actions shows green checkmark
- ✅ Website loads at https://genzspace.in
- ✅ Privacy policy accessible
- ✅ No errors in logs

### **App Deployment Success:**
- ✅ GitHub Actions shows green checkmark
- ✅ Firebase shows new build
- ✅ Google Play Console shows new version
- ✅ App updates on your phone

## 🚀 **Next Steps**

1. **Add the 3 GitHub secrets** for Hostinger
2. **Test website deployment** with a small change
3. **Verify only website CI/CD** runs
4. **Check live website** for updates
5. **Enjoy automatic deployments!**

---

**The main issue is missing GitHub secrets for Hostinger!** 🔐
