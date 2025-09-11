#!/bin/bash

# GenZSpace Environment Setup Script
# This script helps set up environment variables and configuration files

echo "🚀 Setting up GenZSpace environment..."

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "📝 Creating .env file from template..."
    cp env.example .env
    echo "✅ .env file created! Please edit it with your actual values."
else
    echo "⚠️ .env file already exists. Skipping creation."
fi

# Create secrets.dart file if it doesn't exist
if [ ! -f lib/config/secrets.dart ]; then
    echo "📝 Creating secrets.dart file from template..."
    cp lib/config/secrets_template.dart lib/config/secrets.dart
    echo "✅ secrets.dart file created! Please edit it with your actual values."
else
    echo "⚠️ secrets.dart file already exists. Skipping creation."
fi

# Check if Firebase files exist
if [ ! -f android/app/google-services.json ]; then
    echo "⚠️ android/app/google-services.json not found!"
    echo "   Please download it from Firebase Console and place it in android/app/"
fi

if [ ! -f ios/Runner/GoogleService-Info.plist ]; then
    echo "⚠️ ios/Runner/GoogleService-Info.plist not found!"
    echo "   Please download it from Firebase Console and place it in ios/Runner/"
fi

echo ""
echo "🔧 Next steps:"
echo "1. Edit .env file with your Firebase API keys"
echo "2. Edit lib/config/secrets.dart with your actual values"
echo "3. Download Firebase configuration files:"
echo "   - android/app/google-services.json"
echo "   - ios/Runner/GoogleService-Info.plist"
echo "4. Run 'flutter pub get' to install dependencies"
echo "5. Run 'flutter run' to start the app"
echo ""
echo "🔐 Security reminder:"
echo "   - Never commit .env or secrets.dart to Git"
echo "   - These files are already in .gitignore"
echo ""
echo "✅ Setup complete!"
