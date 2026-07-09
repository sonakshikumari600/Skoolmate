# SkoolMate - School Management System

A comprehensive school management application built with Flutter and Firebase for managing communication and operations between parents, students, and teachers.

## Table of Contents

- [About](#about)
- [Features](#features)
- [Technology Stack](#technology-stack)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Firebase Configuration](#firebase-configuration)
- [Running the Application](#running-the-application)
- [Project Structure](#project-structure)
- [User Roles](#user-roles)
- [Security](#security)
- [Contributing](#contributing)
- [License](#license)

## About

SkoolMate is a cross-platform school management system that provides dedicated interfaces for three user types: Parents, Students, and Teachers. The application facilitates real-time communication, attendance tracking, homework management, and academic performance monitoring.

### Key Highlights

- Cross-platform support (Web, Android, iOS, Windows, macOS)
- Real-time data synchronization using Firebase
- Role-based access control
- Modern, responsive user interface
- Secure authentication and data protection

## Features

### For Parents

- View children's attendance and academic performance
- Track homework assignments and due dates
- Monitor exam schedules and results
- Manage fee payments and history
- Direct messaging with teachers
- Receive notifications for important updates
- Support for multiple children

### For Students

- Access subject information and study materials
- View and submit homework assignments
- Check exam schedules and syllabus
- Monitor attendance records
- Track academic performance with analytics
- View class timetable
- Receive announcements and notifications

### For Teachers

- Mark student attendance (batch processing)
- Create and assign homework
- Manage multiple subjects and classes
- View teaching schedule
- Request substitute teachers
- Approve/reject student leave requests
- Communicate with parents and students
- Track class performance

## Technology Stack

**Frontend:**
- Flutter (Cross-platform UI framework)
- Dart (Programming language)
- Provider (State management)

**Backend:**
- Firebase Authentication
- Cloud Firestore (Database)
- Firebase Storage

**Development Tools:**
- FlutterFire CLI
- Git
- VS Code

## Prerequisites

Before installation, ensure you have:

```bash
Flutter SDK 3.0.0 or higher
Dart SDK 2.17.0 or higher
Git
Firebase CLI
```

Check versions:
```bash
flutter --version
dart --version
git --version
```

## Installation

1. Clone the repository:
```bash
git clone https://github.com/sonakshikumari/skoolmate.git
cd skoolmate
```

2. Install dependencies:
```bash
flutter pub get
```

3. Verify installation:
```bash
flutter doctor
```

## Firebase Configuration

Firebase configuration files are not included in this repository for security reasons. You must set up Firebase:

1. Create a Firebase project at https://console.firebase.google.com/

2. Enable the following services:
   - Authentication (Email/Password)
   - Cloud Firestore
   - Firebase Storage (optional)

3. Install Firebase CLI:
```bash
npm install -g firebase-tools
```

4. Install FlutterFire CLI:
```bash
dart pub global activate flutterfire_cli
```

5. Configure Firebase for your project:
```bash
firebase login
flutterfire configure
```

This will generate the required configuration files:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`

6. Deploy Firestore security rules:
```bash
firebase deploy --only firestore:rules

## Running the Application

**Web:**
```bash
flutter run -d chrome
```

**Android:**
```bash
flutter run -d android
```

**iOS:**
```bash
flutter run -d ios
```

**Windows:**
```bash
flutter run -d windows
```

**Build for production:**
```bash
flutter build apk --release        # Android
flutter build ios --release         # iOS
flutter build web --release         # Web
flutter build windows --release     # Windows
```

## Project Structure

```
skoolmate/
├── lib/
│   ├── main.dart                           # Application entry point
│   ├── auth_service.dart                   # Authentication service
│   ├── database_service.dart               # Database operations
│   ├── user_provider.dart                  # State management
│   ├── parent_dashboard.dart               # Parent interface
│   ├── student_dashboard.dart              # Student interface
│   ├── teacher_dashboard.dart              # Teacher interface
│   ├── student_subject_overview_screen.dart
│   ├── student_subject_detail_screen.dart
│   ├── teacher_attendance_screen.dart
│   ├── teacher_homework_screen.dart
│   ├── teacher_leave_approval_screen.dart
│   ├── teacher_subject_details_screen.dart
│   └── [other screens and components]
├── android/                                 # Android configuration
├── ios/                                     # iOS configuration
├── web/                                     # Web configuration
├── windows/                                 # Windows configuration
├── test/                                    # Tests
├── pubspec.yaml                             # Dependencies
├── firestore.rules                          # Database security rules
└── README.md                                # This file
```

## User Roles

The application supports three user roles with specific permissions:

| Role | Access Level | Permissions |
|------|-------------|-------------|
| Parent | Child Data | View children's information, communicate with teachers |
| Student | Personal Data | View own records, submit assignments, access materials |
| Teacher | Class Data | Manage classes, mark attendance, assign homework, approve leaves |

**Authentication Flow:**
- Users sign up with email and password
- Role is assigned during registration
- Role is stored in Firestore and enforced by security rules
- Each role has a dedicated dashboard interface

## Security

### Data Protection

- Firebase Authentication for secure login
- Role-based Firestore security rules
- HTTPS/TLS encryption for data transmission
- No credentials stored in the codebase

### Important Security Notes

The following files contain sensitive data and are excluded from the repository:
- `lib/firebase_options.dart`
- `android/app/google-services.json`
- `ios/Runner/GoogleService-Info.plist`
- `android/local.properties`

Never commit these files to version control. They are protected by `.gitignore`.

For complete security guidelines, refer to `SECURITY_CHECKLIST.md`

## Contributing

Contributions are welcome! To contribute:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/YourFeature`)
3. Commit your changes (`git commit -m 'Add YourFeature'`)
4. Push to the branch (`git push origin feature/YourFeature`)
5. Open a Pull Request

**Guidelines:**
- Follow Flutter style guidelines
- Write clear commit messages
- Add tests for new features
- Update documentation as needed
- Do not commit sensitive data

## License

This project is licensed under the MIT License. See `LICENSE` file for details.

## Contact

**Project Repository:** https://github.com/sonakshikumari600/skoolmate

**Issues and Support:** https://github.com/sonakshikumari600/skoolmate/issues

## Acknowledgments

- Flutter Team for the framework
- Firebase for backend services
- All contributors to this project

---
Made by the SheShines


**Note:** This project requires Firebase configuration before running. See [Firebase Configuration](#firebase-configuration) section for setup instructions.
