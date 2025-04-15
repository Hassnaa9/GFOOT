class EndPoint {
static const String _baseUrl = "https://gfoot.runasp.net/api/";

  static String get baseUrl => _baseUrl;

  static String signIn = "${_baseUrl}Authentication/Login";
  static const String googleSignIn = "${_baseUrl}Authentication/social-login";
  static const String facebookSignIn = "${_baseUrl}Authentication/social-login";
  static const String appleSignIn = "${_baseUrl}Authentication/social-login";
  static String signUp = "${_baseUrl}Authentication/Register";
  static String forgotPassword = "${_baseUrl}Authentication/Forgot-Password";
  static String resetPassword = "${_baseUrl}Authentication/Reset-Password";
  static String activity = "${_baseUrl}Individual/log-activity";
  static String getCarbonValue = "${_baseUrl}Individual/footprint";
  static String getRank = "${_baseUrl}Individual/rank";
  static String refreshToken = "${_baseUrl}Authentication/Refresh-Token";
  static String resendOtp = "${_baseUrl}Authentication/Resend-PasswordReset-Otp";
  static String period = "${_baseUrl}Individual/period";
  static String activityStatistics = "${_baseUrl}Individual/statistics";
  

}

class ApiKey {


  // Keys for log-activity endpoint, matching C# property names exactly
  static const String bodyType = 'BodyType';
  static const String sex = 'Sex';
  static const String diet = 'Diet';
  static const String shower = 'HowOftenShower';
  static const String heatSrs = 'HeatingEnergySource';
  static const String transport = 'Transport';
  static const String vehicleType = 'VehicleType';
  static const String socialActivity = 'SocialActivity';
  static const String groceryBill = 'MonthlyGroceryBill';
  static const String travelFreq = 'FrequencyOfTravelingByAir';
  static const String vehicleDist = 'VehicleMonthlyDistanceKm';
  static const String wastedBag = 'WasteBagSize';
  static const String wastedBagCnt = 'WasteBagWeeklyCount';
  static const String dailyTv = 'HowLongTvPcDailyHour';
  static const String dailyInternet = 'HowLongInternetDailyHour';
  static const String monthlyCloth = 'HowManyNewClothesMonthly';
  static const String energyEff = 'EnergyEfficiency';

  // Keys for other endpoints
  static const String email = 'email';
  static const String password = 'password';
  static const String newPassword = 'newPassword';
  static const String otp = 'otp';
  static const String refreshToken = 'refreshToken';
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static const String userType = "userType";
  static const String displayName = "displayName";
  static const String userName = "userName";
    static const String country = "country";
  static const String city = "city";
  static const String token = "token";
}