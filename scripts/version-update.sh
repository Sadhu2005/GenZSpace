#!/bin/bash

# GenZSpace Version Update Script
# This script helps you update the app version and trigger CI/CD pipeline

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

# Function to get current version
get_current_version() {
    grep 'version:' pubspec.yaml | sed 's/version: //' | cut -d'+' -f1
}

# Function to get current build number
get_current_build() {
    grep 'version:' pubspec.yaml | sed 's/version: //' | cut -d'+' -f2
}

# Function to update version
update_version() {
    local new_version=$1
    local new_build=$2
    
    print_status "Updating version to $new_version (build: $new_build)"
    
    # Update pubspec.yaml
    sed -i "s/version: .*/version: $new_version+$new_build/" pubspec.yaml
    
    print_success "Version updated in pubspec.yaml"
}

# Function to create git tag
create_tag() {
    local version=$1
    
    print_status "Creating git tag v$version"
    git tag "v$version"
    print_success "Git tag v$version created"
}

# Function to push changes
push_changes() {
    local version=$1
    local build=$2
    
    print_status "Pushing changes to repository"
    
    # Add and commit changes
    git add pubspec.yaml
    git commit -m "🚀 Bump version to $version+$build"
    
    # Push changes
    git push origin main
    
    # Push tag
    git push origin "v$version"
    
    print_success "Changes pushed to repository"
    print_success "CI/CD pipeline will be triggered automatically"
}

# Function to show help
show_help() {
    echo "GenZSpace Version Update Script"
    echo ""
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -v, --version VERSION    Set the new version (e.g., 1.0.2)"
    echo "  -b, --build BUILD       Set the new build number (e.g., 3)"
    echo "  -a, --auto              Auto-increment build number"
    echo "  -t, --tag               Create git tag for release"
    echo "  -p, --push              Push changes to repository"
    echo "  -h, --help              Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 -v 1.0.2 -b 3 -t -p    # Update to version 1.0.2, build 3, create tag, and push"
    echo "  $0 -a -t -p               # Auto-increment build, create tag, and push"
    echo "  $0 -v 1.1.0 -b 1 -t -p    # New minor version release"
}

# Main script logic
main() {
    local new_version=""
    local new_build=""
    local auto_increment=false
    local create_tag_flag=false
    local push_flag=false
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            -v|--version)
                new_version="$2"
                shift 2
                ;;
            -b|--build)
                new_build="$2"
                shift 2
                ;;
            -a|--auto)
                auto_increment=true
                shift
                ;;
            -t|--tag)
                create_tag_flag=true
                shift
                ;;
            -p|--push)
                push_flag=true
                shift
                ;;
            -h|--help)
                show_help
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                show_help
                exit 1
                ;;
        esac
    done
    
    # Get current version info
    local current_version=$(get_current_version)
    local current_build=$(get_current_build)
    
    print_status "Current version: $current_version (build: $current_build)"
    
    # Handle auto-increment
    if [ "$auto_increment" = true ]; then
        if [ -z "$new_build" ]; then
            new_build=$((current_build + 1))
        fi
        if [ -z "$new_version" ]; then
            new_version=$current_version
        fi
    fi
    
    # Validate inputs
    if [ -z "$new_version" ] || [ -z "$new_build" ]; then
        print_error "Version and build number are required"
        show_help
        exit 1
    fi
    
    # Update version
    update_version "$new_version" "$new_build"
    
    # Create tag if requested
    if [ "$create_tag_flag" = true ]; then
        create_tag "$new_version"
    fi
    
    # Push changes if requested
    if [ "$push_flag" = true ]; then
        push_changes "$new_version" "$new_build"
    fi
    
    print_success "Version update completed!"
    print_status "New version: $new_version (build: $new_build)"
    
    if [ "$push_flag" = true ]; then
        print_status "CI/CD pipeline is now running..."
        print_status "Check GitHub Actions for build progress"
        print_status "Firebase App Distribution will be updated automatically"
    fi
}

# Run main function
main "$@"
