# 🚀 Hostinger CI/CD Setup Guide

## 📋 **Step-by-Step Setup**

### **Step 1: Get Hostinger FTP Credentials**

1. **Login to Hostinger** → **hPanel**
2. Go to **Files** → **File Manager**
3. Click **FTP Accounts** or **FTP Access**
4. Note down these details:
   - **FTP Server**: `ftp.genzspace.in` (or your domain)
   - **FTP Username**: Your FTP username
   - **FTP Password**: Your FTP password
   - **FTP Port**: `21` (usually)

### **Step 2: Add GitHub Secrets**

1. Go to your **GenZSpace repository** on GitHub
2. Click **Settings** tab
3. Click **Secrets and variables** → **Actions**
4. Click **New repository secret**

#### **Add These 3 Secrets:**

**Secret 1: HOSTINGER_USERNAME**
- Name: `HOSTINGER_USERNAME`
- Value: `your_ftp_username`

**Secret 2: HOSTINGER_PASSWORD**
- Name: `HOSTINGER_PASSWORD`
- Value: `your_ftp_password`

**Secret 3: HOSTINGER_HOST**
- Name: `HOSTINGER_HOST`
- Value: `ftp.genzspace.in`

### **Step 3: Test the Setup**

1. **Make a small change** to any file in `website/` folder
2. **Commit and push** to GitHub
3. **Check Actions tab** to see if deployment works
4. **Visit your website** to verify it's updated

## 🎯 **How to Use Separate CI/CD Triggers**

### **Option 1: Automatic Triggers**

**Website CI/CD** (triggers automatically when):
- You push changes to `website/` folder
- You push to `main` or `master` branch

**App CI/CD** (triggers automatically when):
- You push changes to `lib/` folder
- You push to `main` or `master` branch

### **Option 2: Manual Triggers**

**To run Website CI/CD manually:**
1. Go to **Actions** tab in GitHub
2. Click **Deploy Website to Hostinger**
3. Click **Run workflow**
4. Select branch and click **Run workflow**

**To run App CI/CD manually:**
1. Go to **Actions** tab in GitHub
2. Click **Firebase Deploy**
3. Click **Run workflow**
4. Select branch and click **Run workflow**

## 🔧 **Troubleshooting**

### **Common Issues:**

**Issue 1: FTP Connection Failed**
- Check if FTP credentials are correct
- Verify FTP server address
- Ensure FTP account is active

**Issue 2: Permission Denied**
- Check if FTP user has write permissions
- Verify server directory path

**Issue 3: Files Not Uploading**
- Check if files are in correct directory
- Verify file permissions

### **Test Commands:**

```bash
# Test FTP connection
ftp ftp.genzspace.in

# Test file upload
echo "test" > test.txt
```

## 📱 **Quick Setup Script**

Run this script to set up everything:

```bash
# Run the setup script
./scripts/setup-hostinger-deployment.bat
```

## 🎉 **Success Indicators**

When everything works, you'll see:
- ✅ **GitHub Actions** showing successful deployment
- ✅ **Website** updated at https://genzspace.in
- ✅ **Privacy Policy** accessible at https://genzspace.in/privacy.html
- ✅ **No errors** in the deployment logs

## 🚀 **Next Steps**

1. **Add the secrets** to GitHub
2. **Test with a small change**
3. **Verify website updates**
4. **Enjoy automatic deployments!**

---

**Need help?** Check the GitHub Actions logs for detailed error messages.
