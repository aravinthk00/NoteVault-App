# 🗂️ NoteVault - Your Personal Notes App

**NoteVault** is a simple Flutter-based app that allows users to:
- ✍️ Create and save notes
- 🗃️ View notes in a list format
- 🌗 Switch between light and dark mode (with persistent state)
- 🔍 Search and view images from the internet via API
- 🔄 Refresh and load more images (pagination)
- ❤️ Mark/unmark favorites (persisted using Hive)
- 📲 Get notified via Firebase Push Notifications

---

## 🚀 Features

- Clean MVVM architecture
- BLoC for state management
- Dio for API integration
- Hive for local storage
- Theming with persistence (SharedPreferences)
- Pull-to-refresh and infinite scroll
- Unit tests for logic verification
- Firebase push notification integration

---

## 🏁 Getting Started

### 🔧 Prerequisites
- Flutter 3.10+
- Dart 3.0+
- Android Studio or VS Code
- Firebase Project (if you want push notifications)

### ⚙️ Installation

git clone https://github.com/your-username/notevault.git
cd notevault
flutter pub get


## 🐝 Run the App
bash
Copy
Edit
flutter run

### 🖼️ Screenshots
Notes View	Image Grid	Dark Mode
![NoteValut APP](https://github.com/user-attachments/assets/d797f02b-de30-4849-9dde-17e4d6f6974c)

**📁 Architecture**
bash
Copy
Edit
lib/
├── data/              # API services, Firebase
├── model/             # Data models (e.g. Note, Photo)
├── bloc/              # State management using BLoC
├── view/              # UI screens and widgets
├── repository/        # Data source handling
├── utils/             # Theme helpers, constants
└── main.dart          # App entry point
**🧪 Testing**
bash
Copy
Edit
flutter test
Unit tests are available for:

Notes repository logic

Theme service

Bloc states and transitions

**📦 Packages Used**
flutter_bloc

dio

hive

firebase_messaging

shared_preferences

**###📬 Contact**
For support or suggestions, reach out at youremail@example.com

Made with ❤️ in Flutter

yaml
Copy
Edit

---

### ✅ Note:
- Place your screenshot images inside `assets/screenshots/`
- Replace `assets/banner.png` with your actual app banner image (1200x400 recommended)
- Update GitHub repo URL and email accordingly
