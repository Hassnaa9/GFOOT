import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'GFoot'**
  String get appTitle;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navLearn.
  ///
  /// In en, this message translates to:
  /// **'Learn'**
  String get navLearn;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @navProfile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get navProfile;

  /// No description provided for @yourCarbonFootprintTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Carbon Footprint'**
  String get yourCarbonFootprintTitle;

  /// No description provided for @whatItIsTitle.
  ///
  /// In en, this message translates to:
  /// **'What It Is'**
  String get whatItIsTitle;

  /// No description provided for @whatItIsDescription.
  ///
  /// In en, this message translates to:
  /// **'Your Carbon Footprint is the total amount of greenhouse gases you produce, including carbon dioxide and methane.'**
  String get whatItIsDescription;

  /// No description provided for @benefitsTitle.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefitsTitle;

  /// No description provided for @benefitsDescription.
  ///
  /// In en, this message translates to:
  /// **'Reducing your Carbon Footprint helps to slow climate change, conserve natural resources, and create a more sustainable future.'**
  String get benefitsDescription;

  /// No description provided for @waysToReduceTitle.
  ///
  /// In en, this message translates to:
  /// **'Ways to Reduce'**
  String get waysToReduceTitle;

  /// No description provided for @waysToReduceDescription.
  ///
  /// In en, this message translates to:
  /// **'You can lower your footprint by saving energy, reducing waste, choosing sustainable transportation, and supporting eco-friendly products.'**
  String get waysToReduceDescription;

  /// No description provided for @seeYourCarbonFootprintToday.
  ///
  /// In en, this message translates to:
  /// **'See your carbon footprint today!'**
  String get seeYourCarbonFootprintToday;

  /// No description provided for @todayLabel.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayLabel;

  /// No description provided for @goodJobMessage.
  ///
  /// In en, this message translates to:
  /// **'Good job!'**
  String get goodJobMessage;

  /// No description provided for @exploreOurServices.
  ///
  /// In en, this message translates to:
  /// **'Explore our services'**
  String get exploreOurServices;

  /// No description provided for @calculationsTile.
  ///
  /// In en, this message translates to:
  /// **'Calculations'**
  String get calculationsTile;

  /// No description provided for @statisticsTile.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statisticsTile;

  /// No description provided for @recommendationTile.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendationTile;

  /// No description provided for @rankTile.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rankTile;

  /// No description provided for @passwordChangedTitle.
  ///
  /// In en, this message translates to:
  /// **'Password Changed!'**
  String get passwordChangedTitle;

  /// No description provided for @passwordChangedSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Your password has been changed successfully!'**
  String get passwordChangedSuccessMessage;

  /// No description provided for @backToLoginButton.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLoginButton;

  /// No description provided for @createNewPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Create New Password'**
  String get createNewPasswordTitle;

  /// No description provided for @newPasswordUniqueHint.
  ///
  /// In en, this message translates to:
  /// **'Your new password must be unique from those previously used!'**
  String get newPasswordUniqueHint;

  /// No description provided for @enterYourPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get enterYourPasswordHint;

  /// No description provided for @confirmYourPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPasswordHint;

  /// No description provided for @resetPasswordButton.
  ///
  /// In en, this message translates to:
  /// **'Reset Password'**
  String get resetPasswordButton;

  /// No description provided for @otpVerificationTitle.
  ///
  /// In en, this message translates to:
  /// **'OTP Verification'**
  String get otpVerificationTitle;

  /// No description provided for @otpSentToEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'Enter the 6-digit code sent to your email'**
  String get otpSentToEmailMessage;

  /// No description provided for @verifyButton.
  ///
  /// In en, this message translates to:
  /// **'Verify'**
  String get verifyButton;

  /// No description provided for @didntReceiveOtp.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the OTP?'**
  String get didntReceiveOtp;

  /// No description provided for @resendOtp.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP'**
  String get resendOtp;

  /// No description provided for @resendOtpCountdown.
  ///
  /// In en, this message translates to:
  /// **'Resend OTP ({seconds} s)'**
  String resendOtpCountdown(int seconds);

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry! It happens. Please enter your email address, and we will send the OTP to your email.'**
  String get forgotPasswordHint;

  /// No description provided for @enterYourEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get enterYourEmailHint;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @enterYourPhoneNumberHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your phone number (e.g., +20123456789)'**
  String get enterYourPhoneNumberHint;

  /// No description provided for @enterYourCountryHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your country'**
  String get enterYourCountryHint;

  /// No description provided for @enterYourCityHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your city'**
  String get enterYourCityHint;

  /// No description provided for @registerButton.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get registerButton;

  /// No description provided for @orRegisterWith.
  ///
  /// In en, this message translates to:
  /// **'Or Register with'**
  String get orRegisterWith;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @loginNowLink.
  ///
  /// In en, this message translates to:
  /// **'Login Now'**
  String get loginNowLink;

  /// No description provided for @helloRegisterToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Hello! Register to get started'**
  String get helloRegisterToGetStarted;

  /// No description provided for @enterYourUsernameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your username'**
  String get enterYourUsernameHint;

  /// No description provided for @enterYourDisplayNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your display name'**
  String get enterYourDisplayNameHint;

  /// No description provided for @individualUserDropdown.
  ///
  /// In en, this message translates to:
  /// **'Individual User'**
  String get individualUserDropdown;

  /// No description provided for @companyUserDropdown.
  ///
  /// In en, this message translates to:
  /// **'Company User'**
  String get companyUserDropdown;

  /// No description provided for @organizationUserDropdown.
  ///
  /// In en, this message translates to:
  /// **'Organization User'**
  String get organizationUserDropdown;

  /// No description provided for @welcomeBackMessage.
  ///
  /// In en, this message translates to:
  /// **'Welcome back! Glad to see you, Again!'**
  String get welcomeBackMessage;

  /// No description provided for @loginButton.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// No description provided for @orLoginWith.
  ///
  /// In en, this message translates to:
  /// **'Or Login with'**
  String get orLoginWith;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @registerNowLink.
  ///
  /// In en, this message translates to:
  /// **'Register Now'**
  String get registerNowLink;

  /// No description provided for @signInButton.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signInButton;

  /// No description provided for @signUpButton.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUpButton;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get enterValidEmail;

  /// No description provided for @passwordMinLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get passwordMinLength;

  /// No description provided for @unknownErrorOccurred.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownErrorOccurred;

  /// No description provided for @emailAlreadyRegistered.
  ///
  /// In en, this message translates to:
  /// **'This email is already registered. Please use a different email.'**
  String get emailAlreadyRegistered;

  /// No description provided for @registrationSuccessVerifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Registration successful! Please verify your email.'**
  String get registrationSuccessVerifyEmail;

  /// No description provided for @requiredField.
  ///
  /// In en, this message translates to:
  /// **'Required field'**
  String get requiredField;

  /// No description provided for @passwordOneUppercase.
  ///
  /// In en, this message translates to:
  /// **'One uppercase letter required'**
  String get passwordOneUppercase;

  /// No description provided for @passwordOneSpecialChar.
  ///
  /// In en, this message translates to:
  /// **'One special character required'**
  String get passwordOneSpecialChar;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @selectUserType.
  ///
  /// In en, this message translates to:
  /// **'Select user type'**
  String get selectUserType;

  /// No description provided for @pleaseSelectUserType.
  ///
  /// In en, this message translates to:
  /// **'Please select a user type'**
  String get pleaseSelectUserType;

  /// No description provided for @invalidPhoneNumberExample.
  ///
  /// In en, this message translates to:
  /// **'Invalid phone (e.g., +20123456789)'**
  String get invalidPhoneNumberExample;

  /// No description provided for @emailVerifiedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Email verified successfully!'**
  String get emailVerifiedSuccessfully;

  /// No description provided for @otpResentSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'OTP resent successfully'**
  String get otpResentSuccessfully;

  /// No description provided for @pleaseEnterValidOtp.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid 6-digit OTP'**
  String get pleaseEnterValidOtp;

  /// No description provided for @completeQuestionnaireMessage.
  ///
  /// In en, this message translates to:
  /// **'Please complete the questionnaire to see your carbon footprint.'**
  String get completeQuestionnaireMessage;

  /// No description provided for @redirectingToLogin.
  ///
  /// In en, this message translates to:
  /// **'Redirecting to login...'**
  String get redirectingToLogin;

  /// No description provided for @errorPrefix.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get errorPrefix;

  /// No description provided for @notificationsSection.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsSection;

  /// No description provided for @enablePushNotifications.
  ///
  /// In en, this message translates to:
  /// **'Enable Push Notifications'**
  String get enablePushNotifications;

  /// No description provided for @appearanceSection.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearanceSection;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @unitsSection.
  ///
  /// In en, this message translates to:
  /// **'Units'**
  String get unitsSection;

  /// No description provided for @useMetricUnits.
  ///
  /// In en, this message translates to:
  /// **'Use Metric Units'**
  String get useMetricUnits;

  /// No description provided for @useMetricUnitsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Switch between metric and imperial units'**
  String get useMetricUnitsSubtitle;

  /// No description provided for @languageSection.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageSection;

  /// No description provided for @toggleLanguage.
  ///
  /// In en, this message translates to:
  /// **'Toggle Language'**
  String get toggleLanguage;

  /// No description provided for @accountSection.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get accountSection;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @logoutButton.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// No description provided for @questionnaireBodyType.
  ///
  /// In en, this message translates to:
  /// **'🏋️‍♀️ What is your body type?'**
  String get questionnaireBodyType;

  /// No description provided for @bodyTypeObese.
  ///
  /// In en, this message translates to:
  /// **'⚖️ Obese'**
  String get bodyTypeObese;

  /// No description provided for @bodyTypeOverweight.
  ///
  /// In en, this message translates to:
  /// **'⚖️ Overweight'**
  String get bodyTypeOverweight;

  /// No description provided for @bodyTypeUnderweight.
  ///
  /// In en, this message translates to:
  /// **'⚖️ Underweight'**
  String get bodyTypeUnderweight;

  /// No description provided for @bodyTypeNormal.
  ///
  /// In en, this message translates to:
  /// **'⚖️ Normal'**
  String get bodyTypeNormal;

  /// No description provided for @questionnaireGender.
  ///
  /// In en, this message translates to:
  /// **'👤 What is your gender?'**
  String get questionnaireGender;

  /// No description provided for @genderFemale.
  ///
  /// In en, this message translates to:
  /// **'♀️ Female'**
  String get genderFemale;

  /// No description provided for @genderMale.
  ///
  /// In en, this message translates to:
  /// **'♂️ Male'**
  String get genderMale;

  /// No description provided for @questionnaireDietType.
  ///
  /// In en, this message translates to:
  /// **'🍽️ What is your diet type?'**
  String get questionnaireDietType;

  /// No description provided for @dietOmnivore.
  ///
  /// In en, this message translates to:
  /// **'🍖 Omnivore'**
  String get dietOmnivore;

  /// No description provided for @dietVegetarian.
  ///
  /// In en, this message translates to:
  /// **'🥗 Vegetarian'**
  String get dietVegetarian;

  /// No description provided for @dietVegan.
  ///
  /// In en, this message translates to:
  /// **'🌱 Vegan'**
  String get dietVegan;

  /// No description provided for @dietPescatarian.
  ///
  /// In en, this message translates to:
  /// **'🐟 Pescatarian'**
  String get dietPescatarian;

  /// No description provided for @questionnaireShowerFrequency.
  ///
  /// In en, this message translates to:
  /// **'🚿 How frequently do you shower?'**
  String get questionnaireShowerFrequency;

  /// No description provided for @showerTwiceDaily.
  ///
  /// In en, this message translates to:
  /// **'🕒 Twice a day'**
  String get showerTwiceDaily;

  /// No description provided for @showerDaily.
  ///
  /// In en, this message translates to:
  /// **'📅 Daily'**
  String get showerDaily;

  /// No description provided for @showerLessFrequently.
  ///
  /// In en, this message translates to:
  /// **'⏳ Less frequently'**
  String get showerLessFrequently;

  /// No description provided for @showerMoreFrequently.
  ///
  /// In en, this message translates to:
  /// **'⏰ More frequently'**
  String get showerMoreFrequently;

  /// No description provided for @questionnaireHeatingSource.
  ///
  /// In en, this message translates to:
  /// **'🔥 What is your home’s primary heating energy source?'**
  String get questionnaireHeatingSource;

  /// No description provided for @heatingCoal.
  ///
  /// In en, this message translates to:
  /// **'🪨 Coal'**
  String get heatingCoal;

  /// No description provided for @heatingNaturalGas.
  ///
  /// In en, this message translates to:
  /// **'💨 Natural gas'**
  String get heatingNaturalGas;

  /// No description provided for @heatingWood.
  ///
  /// In en, this message translates to:
  /// **'🪵 Wood'**
  String get heatingWood;

  /// No description provided for @heatingElectricity.
  ///
  /// In en, this message translates to:
  /// **'⚡ Electricity'**
  String get heatingElectricity;

  /// No description provided for @questionnaireTransportation.
  ///
  /// In en, this message translates to:
  /// **'🚗 What is your primary mode of transportation?'**
  String get questionnaireTransportation;

  /// No description provided for @transportPrivate.
  ///
  /// In en, this message translates to:
  /// **'🚘 Private'**
  String get transportPrivate;

  /// No description provided for @transportPublic.
  ///
  /// In en, this message translates to:
  /// **'🚌 Public'**
  String get transportPublic;

  /// No description provided for @transportWalkBicycle.
  ///
  /// In en, this message translates to:
  /// **'🚶‍♂️ Walk/Bicycle'**
  String get transportWalkBicycle;

  /// No description provided for @questionnaireVehicleType.
  ///
  /// In en, this message translates to:
  /// **'🚙 What type of vehicle you use?'**
  String get questionnaireVehicleType;

  /// No description provided for @vehicleHybrid.
  ///
  /// In en, this message translates to:
  /// **'🔋 Hybrid'**
  String get vehicleHybrid;

  /// No description provided for @vehiclePetrol.
  ///
  /// In en, this message translates to:
  /// **'⛽ Petrol'**
  String get vehiclePetrol;

  /// No description provided for @vehicleDiesel.
  ///
  /// In en, this message translates to:
  /// **'🛢️ Diesel'**
  String get vehicleDiesel;

  /// No description provided for @vehicleLPG.
  ///
  /// In en, this message translates to:
  /// **'💧 LPG'**
  String get vehicleLPG;

  /// No description provided for @vehicleElectric.
  ///
  /// In en, this message translates to:
  /// **'⚡ Electric'**
  String get vehicleElectric;

  /// No description provided for @vehicleNaN.
  ///
  /// In en, this message translates to:
  /// **'❓ NaN'**
  String get vehicleNaN;

  /// No description provided for @questionnaireSocialActivity.
  ///
  /// In en, this message translates to:
  /// **'🎉 How often do you participate in social activities?'**
  String get questionnaireSocialActivity;

  /// No description provided for @socialSometimes.
  ///
  /// In en, this message translates to:
  /// **'🤷‍♂️ Sometimes'**
  String get socialSometimes;

  /// No description provided for @socialOften.
  ///
  /// In en, this message translates to:
  /// **'🥳 Often'**
  String get socialOften;

  /// No description provided for @socialNever.
  ///
  /// In en, this message translates to:
  /// **'🚫 Never'**
  String get socialNever;

  /// No description provided for @questionnaireMonthlyGrocery.
  ///
  /// In en, this message translates to:
  /// **'🛒 What is your average monthly grocery bill (in your local currency)?'**
  String get questionnaireMonthlyGrocery;

  /// No description provided for @questionnaireAirTravel.
  ///
  /// In en, this message translates to:
  /// **'✈️ How often did you travel by air?'**
  String get questionnaireAirTravel;

  /// No description provided for @airTravelNever.
  ///
  /// In en, this message translates to:
  /// **'🚫 Never'**
  String get airTravelNever;

  /// No description provided for @airTravelRarely.
  ///
  /// In en, this message translates to:
  /// **'🌟 Rarely'**
  String get airTravelRarely;

  /// No description provided for @airTravelFrequently.
  ///
  /// In en, this message translates to:
  /// **'🛫 Frequently'**
  String get airTravelFrequently;

  /// No description provided for @airTravelVeryFrequently.
  ///
  /// In en, this message translates to:
  /// **'✈️ Very frequently'**
  String get airTravelVeryFrequently;

  /// No description provided for @questionnaireVehicleDistance.
  ///
  /// In en, this message translates to:
  /// **'🛣️ How many kilometers do you drive per month?'**
  String get questionnaireVehicleDistance;

  /// No description provided for @questionnaireWasteBagSize.
  ///
  /// In en, this message translates to:
  /// **'🗑️ What is the size of your garbage bag?'**
  String get questionnaireWasteBagSize;

  /// No description provided for @wasteBagMedium.
  ///
  /// In en, this message translates to:
  /// **'📏 Medium'**
  String get wasteBagMedium;

  /// No description provided for @wasteBagSmall.
  ///
  /// In en, this message translates to:
  /// **'📏 Small'**
  String get wasteBagSmall;

  /// No description provided for @wasteBagLarge.
  ///
  /// In en, this message translates to:
  /// **'📏 Large'**
  String get wasteBagLarge;

  /// No description provided for @questionnaireWasteBagCount.
  ///
  /// In en, this message translates to:
  /// **'♻️ On average, how many garbage bags did your household use weekly?'**
  String get questionnaireWasteBagCount;

  /// No description provided for @questionnaireTvPcHours.
  ///
  /// In en, this message translates to:
  /// **'📺 On average, how many hours do you spend daily watching TV or using a PC?'**
  String get questionnaireTvPcHours;

  /// No description provided for @questionnaireInternetHours.
  ///
  /// In en, this message translates to:
  /// **'🌐 On average, how many hours do you spend online daily?'**
  String get questionnaireInternetHours;

  /// No description provided for @questionnaireNewClothes.
  ///
  /// In en, this message translates to:
  /// **'👕 On average, how many new clothes do you buy per month?'**
  String get questionnaireNewClothes;

  /// No description provided for @questionnaireEnergyEfficiency.
  ///
  /// In en, this message translates to:
  /// **'💡 Do you actively seek out energy-efficient appliances?'**
  String get questionnaireEnergyEfficiency;

  /// No description provided for @energyEfficiencyYes.
  ///
  /// In en, this message translates to:
  /// **'✅ Yes'**
  String get energyEfficiencyYes;

  /// No description provided for @energyEfficiencySometimes.
  ///
  /// In en, this message translates to:
  /// **'🤔 Sometimes'**
  String get energyEfficiencySometimes;

  /// No description provided for @energyEfficiencyNo.
  ///
  /// In en, this message translates to:
  /// **'❌ No'**
  String get energyEfficiencyNo;

  /// No description provided for @questionnairePleaseAnswer.
  ///
  /// In en, this message translates to:
  /// **'Please answer:'**
  String get questionnairePleaseAnswer;

  /// No description provided for @questionnairePleaseCorrect.
  ///
  /// In en, this message translates to:
  /// **'Please correct:'**
  String get questionnairePleaseCorrect;

  /// No description provided for @questionnaireMustBeNumber.
  ///
  /// In en, this message translates to:
  /// **'must be a valid number'**
  String get questionnaireMustBeNumber;

  /// No description provided for @questionnaireHoursRange.
  ///
  /// In en, this message translates to:
  /// **'Must be between 0 and 24 hours'**
  String get questionnaireHoursRange;

  /// No description provided for @questionnairePositiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Must be a positive number'**
  String get questionnairePositiveNumber;

  /// No description provided for @submitButton.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitButton;

  /// No description provided for @enterValue.
  ///
  /// In en, this message translates to:
  /// **'Enter value'**
  String get enterValue;

  /// No description provided for @invalidNumber.
  ///
  /// In en, this message translates to:
  /// **'Invalid number'**
  String get invalidNumber;

  /// No description provided for @permissionDeniedMessage.
  ///
  /// In en, this message translates to:
  /// **'Permission denied. Please enable it in settings.'**
  String get permissionDeniedMessage;

  /// No description provided for @errorPickingImageMessage.
  ///
  /// In en, this message translates to:
  /// **'Error picking image'**
  String get errorPickingImageMessage;

  /// No description provided for @errorSavingImageMessage.
  ///
  /// In en, this message translates to:
  /// **'Error saving image'**
  String get errorSavingImageMessage;

  /// No description provided for @editProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfileTitle;

  /// No description provided for @fullNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullNameLabel;

  /// No description provided for @addressLabel.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get addressLabel;

  /// No description provided for @dateOfBirthLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of Birth'**
  String get dateOfBirthLabel;

  /// No description provided for @emailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// No description provided for @updateButton.
  ///
  /// In en, this message translates to:
  /// **'UPDATE'**
  String get updateButton;

  /// No description provided for @profileUpdateSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Profile updated successfully!'**
  String get profileUpdateSuccessMessage;

  /// No description provided for @profileUpdateFailedMessage.
  ///
  /// In en, this message translates to:
  /// **'Failed to update profile'**
  String get profileUpdateFailedMessage;

  /// No description provided for @cameraOption.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get cameraOption;

  /// No description provided for @galleryOption.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get galleryOption;

  /// No description provided for @notificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @noNotificationsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet!'**
  String get noNotificationsYetMessage;

  /// No description provided for @dayAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} day ago'**
  String dayAgo(int days);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{days} days ago'**
  String daysAgo(int days);

  /// No description provided for @hourAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hour ago'**
  String hourAgo(int hours);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{hours} hours ago'**
  String hoursAgo(int hours);

  /// No description provided for @minuteAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minute ago'**
  String minuteAgo(int minutes);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{minutes} minutes ago'**
  String minutesAgo(int minutes);

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @notificationLogActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Log Your Daily Activity'**
  String get notificationLogActivityTitle;

  /// No description provided for @notificationLogActivityDescription.
  ///
  /// In en, this message translates to:
  /// **'Don\'t forget to log your travel and meals to track your carbon footprint!'**
  String get notificationLogActivityDescription;

  /// No description provided for @notificationGreatJobTitle.
  ///
  /// In en, this message translates to:
  /// **'Great Job!'**
  String get notificationGreatJobTitle;

  /// No description provided for @notificationGreatJobDescription.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reduced your carbon footprint by 5% this week. Keep it up!'**
  String get notificationGreatJobDescription;

  /// No description provided for @notificationSustainableTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Sustainable Tip'**
  String get notificationSustainableTipTitle;

  /// No description provided for @notificationSustainableTipDescription.
  ///
  /// In en, this message translates to:
  /// **'Try walking or biking instead of driving to reduce emissions.'**
  String get notificationSustainableTipDescription;

  /// No description provided for @notificationHighCarbonAlertTitle.
  ///
  /// In en, this message translates to:
  /// **'High Carbon Alert!'**
  String get notificationHighCarbonAlertTitle;

  /// No description provided for @notificationHighCarbonAlertDescription.
  ///
  /// In en, this message translates to:
  /// **'Your recent flight has significantly increased your carbon footprint. Consider offsetting with a sustainable action.'**
  String get notificationHighCarbonAlertDescription;

  /// No description provided for @notificationMilestoneAchievedTitle.
  ///
  /// In en, this message translates to:
  /// **'Milestone Achieved!'**
  String get notificationMilestoneAchievedTitle;

  /// No description provided for @notificationMilestoneAchievedDescription.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You\'ve offset 1 ton of CO2 through your sustainable choices this month!'**
  String get notificationMilestoneAchievedDescription;

  /// No description provided for @notificationEnergySavingTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Energy Saving Tip'**
  String get notificationEnergySavingTipTitle;

  /// No description provided for @notificationEnergySavingTipDescription.
  ///
  /// In en, this message translates to:
  /// **'Turn off lights and unplug devices when not in use to lower your energy consumption.'**
  String get notificationEnergySavingTipDescription;

  /// No description provided for @notificationChallengeAcceptedTitle.
  ///
  /// In en, this message translates to:
  /// **'Challenge Accepted!'**
  String get notificationChallengeAcceptedTitle;

  /// No description provided for @notificationChallengeAcceptedDescription.
  ///
  /// In en, this message translates to:
  /// **'You\'ve joined the \'Meatless Monday\' challenge. Log your plant-based meals to earn points!'**
  String get notificationChallengeAcceptedDescription;

  /// No description provided for @notificationCommunityUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Community Update'**
  String get notificationCommunityUpdateTitle;

  /// No description provided for @notificationCommunityUpdateDescription.
  ///
  /// In en, this message translates to:
  /// **'Your city just launched a new recycling program. Check it out to reduce waste!'**
  String get notificationCommunityUpdateDescription;

  /// No description provided for @notificationWaterConservationTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Water Conservation Tip'**
  String get notificationWaterConservationTipTitle;

  /// No description provided for @notificationWaterConservationTipDescription.
  ///
  /// In en, this message translates to:
  /// **'Shorten your showers to save water and reduce your environmental impact.'**
  String get notificationWaterConservationTipDescription;

  /// No description provided for @notificationMonthlySummaryTitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly Summary'**
  String get notificationMonthlySummaryTitle;

  /// No description provided for @notificationMonthlySummaryDescription.
  ///
  /// In en, this message translates to:
  /// **'Your carbon footprint for this month is 1.2 tons. Aim for 1 ton next month with small changes!'**
  String get notificationMonthlySummaryDescription;

  /// No description provided for @profileTitle.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileTitle;

  /// No description provided for @editMyAccount.
  ///
  /// In en, this message translates to:
  /// **'Edit My Account'**
  String get editMyAccount;

  /// No description provided for @helpCenter.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get helpCenter;

  /// No description provided for @emailPrefix.
  ///
  /// In en, this message translates to:
  /// **'email'**
  String get emailPrefix;

  /// No description provided for @phonePrefix.
  ///
  /// In en, this message translates to:
  /// **'phone'**
  String get phonePrefix;

  /// No description provided for @locationPrefix.
  ///
  /// In en, this message translates to:
  /// **'location'**
  String get locationPrefix;

  /// No description provided for @notAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get notAvailable;

  /// No description provided for @rankTitle.
  ///
  /// In en, this message translates to:
  /// **'Rank'**
  String get rankTitle;

  /// No description provided for @loadingUser.
  ///
  /// In en, this message translates to:
  /// **'Loading user...'**
  String get loadingUser;

  /// No description provided for @failedToLoadUser.
  ///
  /// In en, this message translates to:
  /// **'Failed to load user'**
  String get failedToLoadUser;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @userNamePlaceholder.
  ///
  /// In en, this message translates to:
  /// **'User Name'**
  String get userNamePlaceholder;

  /// No description provided for @cityRankTitle.
  ///
  /// In en, this message translates to:
  /// **'City Rank'**
  String get cityRankTitle;

  /// No description provided for @countryRankTitle.
  ///
  /// In en, this message translates to:
  /// **'Country Rank'**
  String get countryRankTitle;

  /// No description provided for @globalRankTitle.
  ///
  /// In en, this message translates to:
  /// **'Global Rank'**
  String get globalRankTitle;

  /// No description provided for @noRankingsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No Rankings Available'**
  String get noRankingsAvailable;

  /// No description provided for @yourEcoRecommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Your Eco Recommendations'**
  String get yourEcoRecommendationsTitle;

  /// No description provided for @noRecommendationsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'No Recommendations yet!'**
  String get noRecommendationsYetMessage;

  /// No description provided for @carbonEmissionReportTitle.
  ///
  /// In en, this message translates to:
  /// **'Carbon Emission Report'**
  String get carbonEmissionReportTitle;

  /// No description provided for @dailyTab.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get dailyTab;

  /// No description provided for @monthlyTab.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get monthlyTab;

  /// No description provided for @yearlyTab.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get yearlyTab;

  /// No description provided for @emissionTrendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Emission Trends'**
  String get emissionTrendsTitle;

  /// No description provided for @noDataAvailable.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noDataAvailable;

  /// No description provided for @kilogramAbbreviation.
  ///
  /// In en, this message translates to:
  /// **'kg'**
  String get kilogramAbbreviation;

  /// No description provided for @useSystemTheme.
  ///
  /// In en, this message translates to:
  /// **'Use System Theme'**
  String get useSystemTheme;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
