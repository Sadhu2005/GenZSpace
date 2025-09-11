# 🚀 GenZSpace - Student-Only Social Network

<div align="center">
  <img src="https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white" alt="Flutter">
  <img src="https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white" alt="Dart">
  <img src="https://img.shields.io/badge/Firebase-FFCA28?style=for-the-badge&logo=firebase&logoColor=black" alt="Firebase">
</div>

## 🌟 Overview

**GenZSpace** is a revolutionary student-only social networking platform designed exclusively for Indian students. It combines the best features of modern social media with academic-focused tools, creating a unique ecosystem where students can connect, share, learn, and grow together.

### 🎯 Mission
**"Connect.Share.Grow"** - Empowering the next generation of Indian students through technology, community, and collaboration.

## ✨ Key Features

### 🔥 Core Features

#### 📱 **My Vibes** (Stories System)
- **24-hour disappearing content** with beautiful animations
- **Multiple content types**: Text, Images, Videos, Polls
- **Interactive reactions** and view tracking
- **Gradient themes** and neon-style UI matching your brand
- **Expiry indicators** and time-based content management

#### 💬 **Study Chat** (Messaging System)
- **Real-time messaging** with beautiful chat bubbles
- **Multiple chat types**: Direct messages, Group chats, Study groups
- **Rich media support**: Images, Videos, Files, Voice messages
- **Message reactions** and reply functionality
- **Online status** and read receipts
- **Study room creation** for collaborative learning

#### 🔄 **Study Swap** (Marketplace)
- **Student-to-student trading** of books, notes, equipment, and services
- **Category-based organization**: Books, Notes, Equipment, Services
- **Advanced filtering** by price, condition, location, and category
- **Image galleries** with multiple photos per item
- **Interest tracking** and seller communication
- **Location-based discovery** for easy meetups

#### 📚 **Academic Feed**
- **Dual feed system**: Fun posts and Academic content
- **College-specific content** with institution tagging
- **Study material sharing** and resource discovery
- **Academic discussions** and Q&A threads
- **Achievement sharing** and milestone celebrations

#### 🔍 **Student Radar** (Discovery)
- **Advanced search** by college, branch, year, interests
- **Smart filtering** and recommendation system
- **Interest-based matching** for study partners
- **College leaderboards** and achievement tracking
- **Skill showcase** and portfolio features

### 🎨 Design & UX

#### 🌈 **Neon Gradient Theme**
- **Custom animated logo** with India map and circuit patterns
- **Gradient color schemes** (Blue → Purple → Orange → Pink)
- **Glowing animations** and neon-style UI elements
- **Dark theme optimized** for modern user preferences
- **Smooth transitions** and micro-interactions

#### 📱 **Modern UI/UX**
- **Material Design 3** principles with custom styling
- **Google Fonts (Inter)** for premium typography
- **Responsive design** for all screen sizes
- **Accessibility features** and inclusive design
- **Gesture-based navigation** and intuitive interactions

## 🏗️ Technical Architecture

### 📦 **Dependencies**
```yaml
dependencies:
  flutter: sdk
  google_fonts: ^6.1.0          # Premium typography
  firebase_core: ^2.24.2        # Backend infrastructure
  firebase_auth: ^4.15.3        # Authentication
  cloud_firestore: ^4.13.6      # Database
  image_picker: ^1.0.4          # Media handling
  cached_network_image: ^3.3.0  # Image optimization
  flutter_staggered_animations: ^1.1.1  # Smooth animations
  lottie: ^2.7.0                # Advanced animations
  shimmer: ^3.0.0               # Loading states
  intl: ^0.18.1                 # Internationalization
  url_launcher: ^6.2.1          # External links
  share_plus: ^7.2.1            # Content sharing
  permission_handler: ^11.0.1   # Device permissions
```

### 🏛️ **Project Structure**
```
lib/
├── main.dart                    # App entry point
├── models/                      # Data models
│   ├── user_model.dart         # User & related models
│   └── post_model.dart         # Post & content models
├── screens/                     # UI screens
│   ├── boot_screen.dart        # Animated startup
│   ├── login_screen.dart       # Authentication
│   ├── home_screen.dart        # Main navigation
│   ├── my_vibes_screen.dart    # Stories system
│   ├── study_chat_screen.dart  # Messaging
│   ├── study_swap_screen.dart  # Marketplace
│   └── ...
├── widgets/                     # Reusable components
│   ├── genz_logo.dart          # Animated logo
│   ├── vibe_story_widget.dart  # Story components
│   ├── chat_bubble_widget.dart # Chat UI
│   └── ...
├── services/                    # Business logic
│   ├── auth_service.dart       # Authentication
│   └── database_service.dart   # Data management
└── theme/                       # App theming
    └── app_theme.dart          # Design system
```

### 🔧 **Key Components**

#### 🎭 **Animated Logo Widget**
- **Custom painted** India map with circuit patterns
- **Gradient animations** and glow effects
- **Responsive scaling** and smooth transitions
- **Brand consistency** across all screens

#### 💫 **Story System**
- **VibeStoryWidget**: Individual story display
- **AddVibeWidget**: Content creation interface
- **VibeViewerScreen**: Full-screen story viewing
- **Expiry management** and automatic cleanup

#### 💬 **Chat System**
- **ChatBubbleWidget**: Message display with animations
- **ChatInputWidget**: Rich input with media support
- **StudyChatScreen**: Chat list and management
- **Real-time updates** and message threading

#### 🛒 **Marketplace**
- **SwapItemCard**: Product display with animations
- **AddSwapItemWidget**: Item listing interface
- **Category filtering** and search functionality
- **Image galleries** and condition indicators

## 🚀 Getting Started

### 📋 **Prerequisites**
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code
- Firebase project setup

### ⚙️ **Installation**

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/genzspace.git
   cd genzspace
   ```

2. **Environment Setup**
   
   **Windows:**
   ```bash
   setup_env.bat
   ```
   
   **Linux/Mac:**
   ```bash
   chmod +x setup_env.sh
   ./setup_env.sh
   ```

3. **Configure Environment Variables**
   - Edit `.env` file with your Firebase credentials
   - Edit `lib/config/secrets.dart` with your actual values
   - **Never commit these files to Git!**

4. **Install dependencies**
   ```bash
   flutter pub get
   ```

5. **Configure Firebase**
   - Download `google-services.json` from Firebase Console
   - Place it in `android/app/google-services.json`
   - Download `GoogleService-Info.plist` from Firebase Console
   - Place it in `ios/Runner/GoogleService-Info.plist`

6. **Run the app**
   ```bash
   flutter run
   ```

### 🔐 **Security Setup**
- See `SECURITY.md` for detailed security guidelines
- Environment variables are automatically ignored by Git
- Use different credentials for development and production

### 🔥 **Firebase Setup**

1. **Create Firebase Project**
   - Go to [Firebase Console](https://console.firebase.google.com/)
   - Create a new project
   - Enable Authentication and Firestore

2. **Configure Authentication**
   - Enable Phone Authentication
   - Set up OTP verification
   - Configure student verification

3. **Setup Firestore Database**
   - Create collections: `users`, `posts`, `chats`, `marketplace`
   - Set up security rules
   - Configure indexes for queries

## 🎨 Design System

### 🌈 **Color Palette**
```dart
// Primary Colors
primaryColor: #4361EE (Blue)
secondaryColor: #3A0CA3 (Purple)
accentColor: #7209B7 (Magenta)

// Gradient Colors
gradientBlue: #00BFFF
gradientPurple: #8A2BE2
gradientOrange: #FF8C00
gradientPink: #FF69B4

// Background Colors
lightBackground: #F8F9FA
darkBackground: #212529
```

### 📝 **Typography**
- **Primary Font**: Inter (Google Fonts)
- **Weights**: 400, 500, 600, 700, 900
- **Responsive sizing** with Material Design scale

### 🎭 **Animations**
- **Staggered animations** for list items
- **Scale and fade** transitions
- **Glow effects** and neon styling
- **Smooth page transitions**

## 🔮 Future Features

### 📅 **Campus Connect** (Events)
- Event creation and management
- RSVP system and attendance tracking
- Calendar integration
- Location-based event discovery

### 👥 **Study Squads** (Groups)
- Study group creation and management
- Collaborative features
- Group challenges and competitions
- Progress tracking

### 🔔 **Campus Alerts** (Notifications)
- Push notification system
- Academic alerts and reminders
- Emergency notifications
- Personalized content delivery

### 🎯 **Advanced Features**
- AI-powered content recommendations
- Study analytics and insights
- Gamification and achievements
- Integration with learning management systems

## 🤝 Contributing

We welcome contributions from the community! Please read our [Contributing Guidelines](CONTRIBUTING.md) before submitting pull requests.

### 🐛 **Bug Reports**
Please use the [GitHub Issues](https://github.com/yourusername/genzspace/issues) to report bugs and feature requests.

### 💡 **Feature Requests**
Have an idea? We'd love to hear it! Please create an issue with the `enhancement` label.

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- **Flutter Team** for the amazing framework
- **Firebase** for backend infrastructure
- **Google Fonts** for beautiful typography
- **Material Design** for design principles
- **Indian Student Community** for inspiration

## 📞 Contact

- **Project Lead**: [ Sadhu J](mailto:sadhuj2005@gmail.com)
- **Website**: [genzspace.com](https://genzspace.com)
- **Twitter**: [@GenZSpace](https://twitter.com/genzspace)
- **Discord**: [Join our community](https://discord.gg/genzspace)

---

<div align="center">
  <p>Made with ❤️ for Indian Students</p>
  <p>© 2024 GenZSpace. All rights reserved.</p>
</div>
