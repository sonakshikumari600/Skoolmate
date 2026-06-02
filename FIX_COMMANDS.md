# 🔥 Fix Firebase Connection - Simple Commands

## ⚡ Quick Fix (Run These Commands)

### Step 1: Install Tools

Open Command Prompt (Windows) or Terminal (Mac/Linux) and run:

```bash
npm install -g firebase-tools
```

Wait for it to complete, then run:

```bash
dart pub global activate flutterfire_cli
```

### Step 2: Login to Firebase

```bash
firebase login
```

This will open your browser. Login with your Google account (the one you used for Firebase).

### Step 3: Navigate to Your Project

```bash
cd "d:\New folder\skoolmate\skoolmate"
```

### Step 4: Configure Firebase (MOST IMPORTANT)

```bash
flutterfire configure
```

**Follow the prompts:**
- Select your Firebase project: **skoolmate** (or whatever you named it)
- Select platforms: **android** (press space to select, enter to confirm)
- It will auto-detect package name: `com.example.skoolmate`

**This command will:**
- ✅ Create proper `firebase_options.dart` with real credentials
- ✅ Download `google-services.json` automatically
- ✅ Place files in correct locations
- ✅ Fix all connection issues

### Step 5: Get Dependencies

```bash
flutter pub get
```

### Step 6: Clean Build

```bash
flutter clean
```

### Step 7: Run Your App

```bash
flutter run
```

---

## ✅ Verification

After running the app, try to sign up with:
- Email: test@test.com
- Password: test123

Then check Firebase Console:
- Go to Authentication → Users
- You should see the new user! ✅

---

## 🎯 All Commands in One Block

Copy and paste these one by one:

```bash
npm install -g firebase-tools
dart pub global activate flutterfire_cli
firebase login
cd "d:\New folder\skoolmate\skoolmate"
flutterfire configure
flutter pub get
flutter clean
flutter run
```

---

## 🐛 If Commands Don't Work

### "npm is not recognized"
**Fix:** Install Node.js from https://nodejs.org

### "dart is not recognized"
**Fix:** Make sure Flutter is installed and in PATH

### "firebase login" doesn't open browser
**Fix:** Run `firebase login --no-localhost`

### "flutterfire configure" fails
**Fix:** Make sure you're in the correct project folder

---

## 📱 Alternative: Manual Setup

If CLI doesn't work, follow these steps:

### 1. Download google-services.json

1. Go to: https://console.firebase.google.com
2. Select your project
3. Click Settings (gear icon) → Project settings
4. Scroll to "Your apps"
5. Click your Android app
6. Click "Download google-services.json"
7. Save it

### 2. Place the File

Move `google-services.json` to:
```
d:\New folder\skoolmate\skoolmate\android\app\google-services.json
```

### 3. Get Configuration Values

In Firebase Console → Project Settings → Your Android app, you'll see:

```
API Key: AIzaSy...
App ID: 1:123456789:android:abc123
Project ID: skoolmate-xxxxx
Messaging Sender ID: 123456789
Storage Bucket: skoolmate-xxxxx.appspot.com
```

### 4. Update firebase_options.dart

Open `lib/firebase_options.dart` and replace the android section:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIzaSy...',  // Paste your API Key
  appId: '1:123456789:android:abc123',  // Paste your App ID
  messagingSenderId: '123456789',  // Paste your Sender ID
  projectId: 'skoolmate-xxxxx',  // Paste your Project ID
  storageBucket: 'skoolmate-xxxxx.appspot.com',  // Paste your Bucket
);
```

### 5. Rebuild

```bash
flutter clean
flutter pub get
flutter run
```

---

## 🎉 Success!

Once configured, your app will:
- ✅ Connect to Firebase
- ✅ Save users to Authentication
- ✅ Save data to Firestore
- ✅ Sync in real-time

---

## 📞 Still Not Working?

Check these:

1. **Firebase Console:**
   - Authentication enabled? ✅
   - Firestore database created? ✅
   - Android app registered? ✅

2. **Files:**
   - `google-services.json` in `android/app/`? ✅
   - `firebase_options.dart` has real values (not YOUR_API_KEY)? ✅

3. **Console Output:**
   - Look for "[firebase_core] Successfully initialized" ✅
   - No errors about Firebase? ✅

---

**Recommended:** Use `flutterfire configure` - it's the easiest and most reliable method! 🚀
