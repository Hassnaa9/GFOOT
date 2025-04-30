GFOOT - Carbon Footprint Tracker
GFOOT is a Flutter-based mobile application designed to help users track, manage, and reduce their carbon footprint. By logging daily activities and analyzing environmental impact, GFOOT provides personalized insights, statistics, and global/local rankings to encourage sustainable living.
Features
![Screenshot 2025-04-30 123355](https://github.com/user-attachments/assets/98702efa-404e-49a9-b990-cd587e4d8e88)
![login_or_regi](https://github.com/user-attachments/assets/665ad23d-14ff-496b-b874-f471806e89d6)
![register1](https://github.com/user-attachments/assets/52138cf8-ad57-43eb-b055-3244adc09d88)
![register2](https://github.com/user-attachments/assets/87518bca-053f-4408-8898-07e1f7ce01e6)

![login](https://github.com/user-attachments/assets/66af6aeb-04cf-444d-8aba-3f17ec1236d6)
![login_loading](https://github.com/user-attachments/assets/5634c7f0-9743-4c1f-899e-aedc533a6a4b)
![home1](https://github.com/user-attachments/assets/67eaa9ea-e2c0-4a8f-84b4-98e6cef5eb3d)
![forgotPass](https://github.com/user-attachments/assets/a443ddaa-b9bd-4281-95c2-cbc1ac532457)
![otp_verif](https://github.com/user-attachments/assets/e598cad9-8492-4557-befe-250aebe85a13)
![create_new_pass](https://github.com/user-attachments/assets/c7984f8f-a8a2-450f-b438-a62dc2cc4698)


Activity Logging: Record daily activities (e.g., transportation, energy use) to calculate your carbon footprint.
![q1](https://github.com/user-attachments/assets/5d7e60a9-6ff5-49f7-9f67-0c71da2b233b)
![q2](https://github.com/user-attachments/assets/7ba33f5b-a71d-45b5-902b-0608d44f55d1)
![q3](https://github.com/user-attachments/assets/18bb9c0a-2a62-4e59-a2a6-9f2f14928416)
![q4](https://github.com/user-attachments/assets/b66d5e55-3da9-4a95-8fcf-29e492fca980)
then the data sent to ml model to calculate the carbon footprint and display to the user 
![home1](https://github.com/user-attachments/assets/14c3fbf8-d2a7-4752-a6bc-11ab91383ef1)
![home_load](https://github.com/user-attachments/assets/2f2c0289-dbbc-4a3c-9ee5-199bdfe749a5)
based on his answer the carbon footprint decrease or increase 
![home2](https://github.com/user-attachments/assets/2b855c3c-4d47-4729-8314-63e552b82c6c)

Statistics Dashboard: Visualize your environmental impact with charts and progress indicators.
![statistics](https://github.com/user-attachments/assets/c7c389e6-41f0-4bec-a52f-7fe1e63d8292)

User Rankings: Compare your carbon footprint with others in your city, country, or globally.
![rank](https://github.com/user-attachments/assets/aa8bd28b-b802-4850-a6a5-301d1deb5203)
Recommendations: we support user with meaningful recommendations based on his usage and daily activities to enable him reduce his carbon footprint
![recom](https://github.com/user-attachments/assets/66fdfc30-81c2-4282-aa46-41758b2f7a35)
![recommError](https://github.com/user-attachments/assets/aeabb1f4-2041-41b7-a9da-508f8f10adc4)
![recom2](https://github.com/user-attachments/assets/82bea6d0-5d40-4c38-a4ae-f1c23d2b085f)

Social Login: Sign in using Google or Facebook via Firebase authentication.
Customizable Settings: Adjust notifications, theme preferences, and units (metric/imperial).
![setting](https://github.com/user-attachments/assets/80c4eb15-356c-4498-ac1d-c141c752c43e)
![profile](https://github.com/user-attachments/assets/fc70ffd7-7c2f-4a97-930f-53ddbf57e57c)
![edit_pro](https://github.com/user-attachments/assets/70628586-6fbb-4094-91dc-a26f43711b0f)

also provide to him learn feature if he is a new user or didn't know what is the carbon footprint is 
![learn](https://github.com/user-attachments/assets/434a7937-f757-4f7b-a9b0-9fd7fa5003fd)

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
