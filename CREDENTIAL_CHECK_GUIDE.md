# 🔐 GitHub Secrets Setup Guide for GenZSpace CI/CD

## 📋 **Check Current Secrets**

### **How to View/Manage Secrets in GitHub:**

1. **Go to your repository:**
   - Navigate to: `https://github.com/[your-username]/GenZSpace`
   
2. **Access Repository Settings:**
   - Click **Settings** tab (top navigation)
   - Look for **Secrets and variables** in left sidebar
   - Click **Actions**

3. **Check Existing Secrets:**
   ```
   Required Secrets:
   ✅ GOOGLE_PLAY_SERVICE_ACCOUNT_JSON  ← Most Important!
   
   Optional Secrets:
   ✅ GITHUB_TOKEN  ← Usually auto-provided
   ```

## 🔑 **Google Play Service Account JSON Setup**

### **Step 1: Download Service Account JSON**
1. **Go to Google Cloud Console:** https://console.cloud.google.com/
2. **Select your project:** GenZSpace
3. **Navigate to IAM & Admin → Service Accounts**
4. **Find your service account** or create a new one
5. **Click Actions → Manage Keys**
6. **Add Key → Create new key → JSON**
7. **Download the JSON file**

### **Step 2: Add to GitHub Secrets**
1. **Copy entire JSON content** from downloaded file
2. **Go to GitHub repository → Settings → Secrets and variables → Actions**
3. **Click "New repository secret"**
4. **Name:** `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
5. **Value:** Paste the entire JSON content
6. **Save**

### **📄 Expected JSON Format:**
```json
{
  "type": "service_account",
  "project_id": "genzspace",
  "private_key_id": "...",
  "private_key": "-----BEGIN PRIVATE KEY-----\n...\n-----END PRIVATE KEY-----\n",
  "client_email": "your-service-account@project.iam.gserviceaccount.com",
  "client_id": "...",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "...",
  "client_x509_cert_url": "..."
}
```

## 🔍 **Verification Checklist**

### **GitHub Secrets Setup:**
```
✅ Repository secrets are set
✅ GOOGLE_PLAY_SERVICE_ACCOUNT_JSON exists
✅ JSON is valid and not truncated
✅ Key has correct permissions on Google Play Console
```

### **Google Play Console Setup:**
```
✅ App is created with package name: com.anu.GenZSpace
✅ Internal testing track exists
✅ Service account has "Release manager" or "Owner" permissions
```

## 🔧 **Quick Test**

### **1. Manual Credential Test:**
Go to repository → Actions tab → Run workflow manually and check logs for:
```
✅ Google Play credentials found
✅ AAB file verified successfully
✅ Upload starts without errors
```

### **2. Common Issues & Solutions:**

**❌ "Invalid Service Account"**
- → Check: JSON is complete and valid
- → Check: Key has Play Console permissions

**❌ "Package name mismatch"**  
- → Check: JSON project matches your Play Console project
- → Check: `com.anu.GenZSpace` matches exactly

**❌ "File not found"**
- → Check: AAB build completed successfully
- → Check: File path in logs

## 🚀 **What to Do Next**

1. **Verify secrets are set correctly**
2. **Run the workflow again** 
3. **Check new logs for any credential issues**
4. **Update service account permissions if needed**

---

**🔑 All credential issues should be resolved if JSON is properly set in GitHub Secrets!**
