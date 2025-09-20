# GenZSpace Website CI/CD Setup Guide

This guide will help you set up a complete CI/CD pipeline for your GenZSpace website, enabling automatic deployment from Cursor to GitHub and then to Hostinger.

## 🎯 Overview

The CI/CD pipeline includes:
- **GitHub Actions** for automated deployment
- **FTP/SSH deployment** to Hostinger
- **Environment configuration** management
- **Automated testing** and validation
- **Backup and rollback** capabilities

## 📋 Prerequisites

Before setting up the CI/CD pipeline, ensure you have:

1. **GitHub Repository** - Your code hosted on GitHub
2. **Hostinger Account** - Web hosting service
3. **Domain Name** - zengspace.in configured with Hostinger
4. **FTP/SSH Access** - To your Hostinger hosting account

## 🚀 Step 1: GitHub Repository Setup

### 1.1 Initialize Git Repository (if not already done)

```bash
# In your project root directory
git init
git add .
git commit -m "Initial commit: GenZSpace website with CI/CD setup"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/GenZSpace.git
git push -u origin main
```

### 1.2 Create GitHub Repository

1. Go to [GitHub](https://github.com) and create a new repository
2. Name it `GenZSpace` (or your preferred name)
3. Make it public or private as needed
4. Don't initialize with README (since you already have files)

## 🔧 Step 2: Hostinger Configuration

### 2.1 Get FTP Credentials

1. Log in to your Hostinger control panel
2. Go to **File Manager** or **FTP Accounts**
3. Note down:
   - FTP Host (usually your domain or IP)
   - FTP Username
   - FTP Password
   - Port (usually 21)

### 2.2 Get SSH Credentials (Optional but recommended)

1. In Hostinger control panel, go to **Advanced** → **SSH Access**
2. Enable SSH access if not already enabled
3. Note down:
   - SSH Host
   - SSH Username
   - SSH Port (usually 22)
   - Generate SSH key pair

## 🔐 Step 3: GitHub Secrets Configuration

### 3.1 Add Repository Secrets

1. Go to your GitHub repository
2. Click **Settings** → **Secrets and variables** → **Actions**
3. Click **New repository secret** and add:

```
Name: HOSTINGER_FTP_HOST
Value: your-ftp-host.com
```

```
Name: HOSTINGER_FTP_USERNAME
Value: your_ftp_username
```

```
Name: HOSTINGER_FTP_PASSWORD
Value: your_ftp_password
```

```
Name: HOSTINGER_SSH_HOST
Value: your-ssh-host.com
```

```
Name: HOSTINGER_SSH_USERNAME
Value: your_ssh_username
```

```
Name: HOSTINGER_SSH_KEY
Value: -----BEGIN OPENSSH PRIVATE KEY-----
your_private_key_content_here
-----END OPENSSH PRIVATE KEY-----
```

```
Name: HOSTINGER_SSH_PORT
Value: 22
```

### 3.2 Environment Variables for Local Development

1. Copy `.env.example` to `.env`:
```bash
cp .env.example .env
```

2. Edit `.env` with your actual values:
```bash
# Hostinger FTP Configuration
HOSTINGER_FTP_HOST=your-domain.com
HOSTINGER_FTP_USERNAME=your_ftp_username
HOSTINGER_FTP_PASSWORD=your_ftp_password

# Hostinger SSH Configuration
HOSTINGER_SSH_HOST=your-domain.com
HOSTINGER_SSH_USERNAME=your_ssh_username
HOSTINGER_SSH_KEY=your_private_ssh_key_content
HOSTINGER_SSH_PORT=22
```

## 🛠️ Step 4: Local Development Setup

### 4.1 Install Required Tools

**For Windows:**
- Git Bash or WSL
- FTP client (built into Windows)
- PowerShell or Command Prompt

**For macOS/Linux:**
- Git
- FTP client (`lftp` recommended)
- SSH client

### 4.2 Test Local Deployment

**Using the shell script (macOS/Linux):**
```bash
# Make script executable
chmod +x scripts/deploy-website.sh

# Run deployment
./scripts/deploy-website.sh
```

**Using the batch script (Windows):**
```cmd
# Run deployment
scripts\deploy-website.bat
```

## 🔄 Step 5: GitHub Actions Workflow

The GitHub Actions workflow (`.github/workflows/deploy-website.yml`) will automatically:

1. **Trigger** on push to main/master branch
2. **Build** and validate the website
3. **Deploy** to Hostinger via FTP/SSH
4. **Verify** deployment success
5. **Notify** about deployment status

### 5.1 Workflow Triggers

The workflow triggers on:
- Push to `main` or `master` branch
- Changes in `website/` directory
- Changes in the workflow file itself

### 5.2 Workflow Steps

1. **Checkout code** from repository
2. **Setup Node.js** environment
3. **Install dependencies** (if any)
4. **Build website** (optimize images, minify CSS/JS)
5. **Validate HTML** structure
6. **Create deployment package**
7. **Deploy to Hostinger** via FTP
8. **Verify deployment** by checking website accessibility
9. **Cleanup** temporary files

## 🚀 Step 6: Testing the Pipeline

### 6.1 Test Local Deployment

1. Make a small change to your website (e.g., update a text)
2. Test local deployment:
   ```bash
   ./scripts/deploy-website.sh
   ```

### 6.2 Test GitHub Actions

1. Commit and push changes:
   ```bash
   git add .
   git commit -m "Test CI/CD pipeline"
   git push origin main
   ```

2. Go to GitHub → Actions tab to monitor the deployment

### 6.3 Verify Deployment

1. Check your website: https://zengspace.in
2. Verify all changes are live
3. Check browser console for any errors

## 📊 Step 7: Monitoring and Maintenance

### 7.1 GitHub Actions Monitoring

- Go to **Actions** tab in your GitHub repository
- Monitor deployment logs
- Check for any failures or warnings

### 7.2 Website Monitoring

- Set up uptime monitoring (UptimeRobot, Pingdom)
- Monitor website performance (Google PageSpeed Insights)
- Check analytics for traffic and errors

### 7.3 Backup Strategy

The pipeline includes automatic backups:
- Server-side backups before each deployment
- Git history for code rollbacks
- Database backups (if applicable)

## 🔧 Troubleshooting

### Common Issues and Solutions

#### 1. FTP Connection Failed
```
Error: FTP connection failed
Solution: Check FTP credentials and host settings
```

#### 2. Permission Denied
```
Error: Permission denied
Solution: Ensure SSH key is correctly configured
```

#### 3. Website Not Accessible After Deployment
```
Error: 404 or 500 errors
Solution: Check .htaccess configuration and file permissions
```

#### 4. GitHub Actions Workflow Failed
```
Error: Workflow failed
Solution: Check GitHub secrets configuration
```

### Debug Commands

**Check FTP connection:**
```bash
ftp your-domain.com
# Enter username and password
# Try to list directory contents
```

**Check SSH connection:**
```bash
ssh username@your-domain.com
# Should connect without password if key is configured
```

**Validate HTML:**
```bash
# Install html-validate
npm install -g html-validate
html-validate website/index.html
```

## 📚 Additional Resources

### Documentation
- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Hostinger Help Center](https://www.hostinger.com/help)
- [FTP Deployment Best Practices](https://developer.mozilla.org/en-US/docs/Learn/Getting_started_with_the_web/Publishing_your_website)

### Tools and Services
- [GitHub Actions Marketplace](https://github.com/marketplace?type=actions)
- [FTP Clients](https://filezilla-project.org/)
- [SSH Key Management](https://docs.github.com/en/authentication/connecting-to-github-with-ssh)

## 🎉 Success Checklist

- [ ] GitHub repository created and configured
- [ ] Hostinger FTP/SSH credentials obtained
- [ ] GitHub secrets configured
- [ ] Local deployment script tested
- [ ] GitHub Actions workflow working
- [ ] Website accessible at https://zengspace.in
- [ ] Monitoring and backup systems in place

## 📞 Support

If you encounter any issues:

1. Check the troubleshooting section above
2. Review GitHub Actions logs
3. Verify Hostinger configuration
4. Contact support:
   - Email: hello@zengspace.in
   - GitHub Issues: Create an issue in your repository

---

**Congratulations!** 🎉 Your GenZSpace website now has a fully automated CI/CD pipeline from Cursor to GitHub to Hostinger!
