# 🔑 Service Account JSON Setup Steps

## ✅ **Great! You Found Your Service Accounts**

From your Google Cloud Console, I can see you have:
- ✅ `genzspace-ci-cd@genzspace.iam.gserviceaccount.com`
- ✅ `genzspace-play-store@genzspace.iam.gserviceaccount.com`

## 📝 **Get the Right JSON Key**

### **Use this service account:** `genzspace-play-store@genzspace.iam.gserviceaccount.com`

**Steps to download JSON:**

1. **In Google Cloud Console (where you are now)**
2. **Click the 3-dot menu** (Actions column) next to `genzspace-play-store`
3. **Select "Manage keys"**
4. **Click "ADD KEY" → "Create new key"**
5. **Select "JSON" format** → Click **CREATE**
6. **File will download automatically** (save it!)

## 🚀 **Add JSON to GitHub Secrets**

### **Step 1: Get JSON Content**
- Open the downloaded JSON file
- **Copy the ENTIRE content** (including all curly braces `{}`)

### **Step 2: Add to GitHub**
1. **Go to your GenZSpace GitHub repository**
2. **Click Settings tab** (top menu)
3. **Left sidebar: "Secrets and variables" → "Actions"**
4. **Click "New repository secret"**
5. **Name:** `GOOGLE_PLAY_SERVICE_ACCOUNT_JSON`
6. **Secret:** Paste your entire JSON content
7. **Save**

## 🔍 **JSON Should Look Like This:**

```json
{
  "type": "service_account",
  "project_id": "genzspace",
  "private_key_id": "...",
  "private_key": "-----BEGIN PRIVATE KEY-----\\n...",
  "client_email": "genzspace-play-store@genzspace.iam.gserviceaccount.com",
  "client_id": "...",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "...",
  "client_x509_cert_url": "..."
}
```

## ⚠️ **Important Notes:**

- **Don't share this JSON publicly** 
- **Use exactly this service account name**
- **Include the entire JSON content in GitHub secret**
- **Check that service account has Play Console permissions**

## 🎯 **Next Steps:**

1. **Get JSON key from `genzspace-play-store` account**
2. **Add it to GitHub repository secrets**  
3. **Run CI/CD again**
4. **Check logs for successful authentication**

**Your GenZSpace project should work perfectly after this setup!**
