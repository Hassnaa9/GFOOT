GFOOT - Carbon Footprint Tracker
GFOOT is a Flutter-based mobile application designed to help users track, manage, and reduce their carbon footprint. By logging daily activities and analyzing environmental impact, GFOOT provides personalized insights, statistics, and global/local rankings to encourage sustainable living.
Features


Activity Logging: Record daily activities (e.g., transportation, energy use) to calculate your carbon footprint.
then the data sent to ml model to calculate the carbon footprint and display to the user 
based on his answer the carbon footprint decrease or increase 
Statistics Dashboard: Visualize your environmental impact with charts and progress indicators.
User Rankings: Compare your carbon footprint with others in your city, country, or globally.
Recommendations: we support user with meaningful recommendations based on his usage and daily activities to enable him reduce his carbon footprint
Social Login: Sign in using Google or Facebook via Firebase authentication.
Customizable Settings: Adjust notifications, theme preferences, and units (metric/imperial).
also provide to him learn feature if he is a new user or didn't know what is the carbon footprint is 
API Integration: Fetches real-time data to provide accurate carbon footprint calculations.

here is a full demo to enjoy with our smoothy app :) 


https://github.com/user-attachments/assets/1189c5eb-5d09-4799-82ee-1b9be23d5ca1


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
Core/: Configuration files (e.g., API settings,error models, utils).
Cubit/: State management using Cubit for home, auth, and rankings.
views/: UI screens (e.g., HomeViewBody, RankViewBody, StatisticsViewBody).
widgets/: Reusable widgets (e.g., QuestionCard, CircularPercentIndicator).
Data/: for repositories and remote, local data

android/: Android-specific configuration.
ios/: iOS-specific configuration.
assets/: Images, fonts, and other static resources.

License
This project is licensed under the MIT License. See the LICENSE file for details.
Contact
For questions or support, contact the project maintainer at [mhassna727@gmail.com]  or open an issue on GitHub.
