GFOOT - Carbon Footprint Tracker
GFOOT is a Flutter-based mobile application designed to help users track, manage, and reduce their carbon footprint. By logging daily activities and analyzing environmental impact, GFOOT provides personalized insights, statistics, and global/local rankings to encourage sustainable living.
Features

Activity Logging: Record daily activities (e.g., transportation, energy use) to calculate your carbon footprint.
Statistics Dashboard: Visualize your environmental impact with charts and progress indicators.
User Rankings: Compare your carbon footprint with others in your city, country, or globally.
Social Login: Sign in using Google or Facebook via Firebase authentication.
Customizable Settings: Adjust notifications, theme preferences, and units (metric/imperial).
API Integration: Fetches real-time data to provide accurate carbon footprint calculations.

Prerequisites
Before setting up the project, ensure you have the following installed:

Flutter SDK (version 3.0.0 or higher)
Dart SDK (included with Flutter)
Android Studio or VS Code with Flutter plugins
Firebase CLI (for Firebase setup)
A compatible device or emulator (Android 6.0+ or iOS 12.0+)

Installation

Clone the Repository:git clone https://github.com/Hassnaa9/GFOOT.git
cd GFOOT


Install Dependencies:Run the following command to fetch Flutter packages:flutter pub get


Set Up Firebase:
Create a Firebase project at console.firebase.google.com.
Add Android and iOS apps to your Firebase project.
Download google-services.json (Android) and GoogleService-Info.plist (iOS) and place them in the respective directories:
Android: android/app/
iOS: ios/Runner/


Enable Google and Facebook authentication in Firebase.
Update android/build.gradle and android/app/build.gradle with the required Firebase dependencies (see pubspec.yaml).


Configure API:
Set up the backend API for carbon footprint data (replace API_URL in lib/config/api_config.dart with your server endpoint).
Ensure the API supports endpoints for activity logging, rankings, and statistics.


Build and Run:
Connect a device or start an emulator.
Build and run the app:flutter run


To create a release APK:flutter build apk --release





Usage

Sign In: Use Google or Facebook to authenticate.
Log Activities: Navigate to the home screen to input daily activities (e.g., miles driven, energy consumed).
View Statistics: Check the statistics screen for charts and progress indicators showing your carbon footprint.
Check Rankings: Visit the rankings screen to see your position locally and globally.
Customize Settings: Adjust preferences like notifications or theme in the settings screen.

Project Structure

lib/: Contains the main Dart source code.
config/: Configuration files (e.g., API settings).
cubit/: State management using Cubit for home, auth, and rankings.
screens/: UI screens (e.g., HomeViewBody, RankViewBody, StatisticsViewBody).
widgets/: Reusable widgets (e.g., QuestionCard, CircularPercentIndicator).


android/: Android-specific configuration.
ios/: iOS-specific configuration.
assets/: Images, fonts, and other static resources.

License
This project is licensed under the MIT License. See the LICENSE file for details.
Contact
For questions or support, contact the project maintainer at [your-email@example.com] or open an issue on GitHub.
