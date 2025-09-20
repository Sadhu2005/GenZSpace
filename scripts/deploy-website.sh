#!/bin/bash

# GenZSpace Website Deployment Script for Hostinger
# This script automates the deployment process to Hostinger hosting

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Configuration
WEBSITE_DIR="website"
DEPLOY_DIR="deploy"
BACKUP_DIR="backup-$(date +%Y%m%d-%H%M%S)"

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if required tools are installed
check_dependencies() {
    print_status "Checking dependencies..."
    
    local missing_deps=()
    
    # Check for FTP client
    if ! command -v ftp &> /dev/null && ! command -v lftp &> /dev/null; then
        missing_deps+=("ftp or lftp")
    fi
    
    # Check for zip
    if ! command -v zip &> /dev/null; then
        missing_deps+=("zip")
    fi
    
    # Check for curl
    if ! command -v curl &> /dev/null; then
        missing_deps+=("curl")
    fi
    
    if [ ${#missing_deps[@]} -ne 0 ]; then
        print_error "Missing dependencies: ${missing_deps[*]}"
        print_status "Please install the missing tools and try again"
        exit 1
    fi
    
    print_success "All dependencies are available"
}

# Function to validate environment variables
validate_env() {
    print_status "Validating environment variables..."
    
    local required_vars=(
        "HOSTINGER_FTP_HOST"
        "HOSTINGER_FTP_USERNAME" 
        "HOSTINGER_FTP_PASSWORD"
    )
    
    local missing_vars=()
    
    for var in "${required_vars[@]}"; do
        if [ -z "${!var}" ]; then
            missing_vars+=("$var")
        fi
    done
    
    if [ ${#missing_vars[@]} -ne 0 ]; then
        print_error "Missing required environment variables:"
        for var in "${missing_vars[@]}"; do
            echo "  - $var"
        done
        print_status "Please set these variables in your environment or .env file"
        exit 1
    fi
    
    print_success "Environment variables validated"
}

# Function to prepare deployment package
prepare_deployment() {
    print_status "Preparing deployment package..."
    
    # Create deployment directory
    if [ -d "$DEPLOY_DIR" ]; then
        rm -rf "$DEPLOY_DIR"
    fi
    
    mkdir -p "$DEPLOY_DIR"
    
    # Copy website files
    if [ ! -d "$WEBSITE_DIR" ]; then
        print_error "Website directory '$WEBSITE_DIR' not found"
        exit 1
    fi
    
    cp -r "$WEBSITE_DIR"/* "$DEPLOY_DIR/"
    
    # Remove development files
    find "$DEPLOY_DIR" -name "node_modules" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$DEPLOY_DIR" -name ".git" -type d -exec rm -rf {} + 2>/dev/null || true
    find "$DEPLOY_DIR" -name "*.log" -type f -delete 2>/dev/null || true
    find "$DEPLOY_DIR" -name ".DS_Store" -type f -delete 2>/dev/null || true
    find "$DEPLOY_DIR" -name "Thumbs.db" -type f -delete 2>/dev/null || true
    
    # Create .htaccess for better performance
    cat > "$DEPLOY_DIR/.htaccess" << 'EOF'
# GenZSpace Website Configuration

# Enable compression
<IfModule mod_deflate.c>
    AddOutputFilterByType DEFLATE text/plain
    AddOutputFilterByType DEFLATE text/html
    AddOutputFilterByType DEFLATE text/xml
    AddOutputFilterByType DEFLATE text/css
    AddOutputFilterByType DEFLATE application/xml
    AddOutputFilterByType DEFLATE application/xhtml+xml
    AddOutputFilterByType DEFLATE application/rss+xml
    AddOutputFilterByType DEFLATE application/javascript
    AddOutputFilterByType DEFLATE application/x-javascript
</IfModule>

# Enable browser caching
<IfModule mod_expires.c>
    ExpiresActive on
    ExpiresByType text/css "access plus 1 year"
    ExpiresByType application/javascript "access plus 1 year"
    ExpiresByType image/png "access plus 1 year"
    ExpiresByType image/jpg "access plus 1 year"
    ExpiresByType image/jpeg "access plus 1 year"
    ExpiresByType image/gif "access plus 1 year"
    ExpiresByType image/svg+xml "access plus 1 year"
</IfModule>

# Security headers
<IfModule mod_headers.c>
    Header always set X-Content-Type-Options nosniff
    Header always set X-Frame-Options DENY
    Header always set X-XSS-Protection "1; mode=block"
    Header always set Referrer-Policy "strict-origin-when-cross-origin"
</IfModule>

# Redirect to HTTPS
RewriteEngine On
RewriteCond %{HTTPS} off
RewriteRule ^(.*)$ https://%{HTTP_HOST}%{REQUEST_URI} [L,R=301]

# Custom error pages
ErrorDocument 404 /index.html
EOF

    print_success "Deployment package prepared"
}

# Function to create backup on server
create_backup() {
    print_status "Creating backup on server..."
    
    # This would be implemented based on your server setup
    # For now, we'll just log the intention
    print_warning "Backup creation not implemented in this script"
    print_status "Consider implementing server-side backup before deployment"
}

# Function to deploy via FTP
deploy_ftp() {
    print_status "Deploying via FTP..."
    
    # Create FTP script
    cat > ftp_script.txt << EOF
open ${HOSTINGER_FTP_HOST}
user ${HOSTINGER_FTP_USERNAME} ${HOSTINGER_FTP_PASSWORD}
binary
cd public_html
prompt
mdelete *
mput ${DEPLOY_DIR}/*
quit
EOF
    
    # Execute FTP upload
    if command -v lftp &> /dev/null; then
        lftp -f ftp_script.txt
    else
        ftp -n < ftp_script.txt
    fi
    
    # Clean up FTP script
    rm ftp_script.txt
    
    print_success "FTP deployment completed"
}

# Function to deploy via SCP/SSH
deploy_ssh() {
    print_status "Deploying via SSH..."
    
    if [ -z "$HOSTINGER_SSH_HOST" ] || [ -z "$HOSTINGER_SSH_USERNAME" ] || [ -z "$HOSTINGER_SSH_KEY" ]; then
        print_warning "SSH credentials not provided, skipping SSH deployment"
        return
    fi
    
    # Create SSH key file
    echo "$HOSTINGER_SSH_KEY" > ssh_key
    chmod 600 ssh_key
    
    # Copy files to server
    scp -i ssh_key -r "$DEPLOY_DIR"/* "${HOSTINGER_SSH_USERNAME}@${HOSTINGER_SSH_HOST}:/public_html/"
    
    # Clean up SSH key
    rm ssh_key
    
    print_success "SSH deployment completed"
}

# Function to verify deployment
verify_deployment() {
    print_status "Verifying deployment..."
    
    local website_url="https://zengspace.in"
    
    # Wait a moment for the server to process
    sleep 5
    
    # Check if website is accessible
    if curl -s -o /dev/null -w "%{http_code}" "$website_url" | grep -q "200"; then
        print_success "Website is accessible at $website_url"
    else
        print_warning "Website verification failed - please check manually"
    fi
}

# Function to cleanup
cleanup() {
    print_status "Cleaning up temporary files..."
    
    if [ -d "$DEPLOY_DIR" ]; then
        rm -rf "$DEPLOY_DIR"
    fi
    
    print_success "Cleanup completed"
}

# Function to show deployment summary
show_summary() {
    echo
    print_success "=== DEPLOYMENT SUMMARY ==="
    echo "Website: GenZSpace"
    echo "URL: https://zengspace.in"
    echo "Deployment time: $(date)"
    echo "Status: Success"
    echo
}

# Main deployment function
main() {
    echo "🚀 GenZSpace Website Deployment to Hostinger"
    echo "=============================================="
    echo
    
    # Load environment variables from .env if it exists
    if [ -f ".env" ]; then
        print_status "Loading environment variables from .env file"
        export $(cat .env | grep -v '^#' | xargs)
    fi
    
    check_dependencies
    validate_env
    prepare_deployment
    create_backup
    deploy_ftp
    deploy_ssh
    verify_deployment
    cleanup
    show_summary
}

# Handle script interruption
trap cleanup EXIT

# Run main function
main "$@"
