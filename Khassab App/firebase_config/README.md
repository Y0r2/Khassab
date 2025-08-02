# Firebase Configuration Templates

This directory contains template files for Firebase configuration. 

## Setup Instructions:

### 1. Android Configuration
- Copy `google-services.template.json` to `google-services.json`
- Replace the placeholder values with your actual Firebase project data
- Make sure the package name matches your app's package name

### 2. iOS Configuration  
- Download `GoogleService-Info.plist` from Firebase Console
- Place it in the `ios/Runner/` directory

### 3. Firebase Options
- Update `lib/firebase_options.dart` with your project's configuration
- You can generate this file using FlutterFire CLI:
  ```bash
  firebase projects:list
  flutterfire configure
  ```

## Important Notes:
- Never commit the actual `google-services.json` file to version control
- Keep your API keys and project IDs secure
- Use different Firebase projects for development and production
