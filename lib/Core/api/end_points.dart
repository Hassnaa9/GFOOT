class EndPoint {
static const String _baseUrl = "https://gfoot.runasp.net/api/";

  static String get baseUrl => _baseUrl;

  static String signIn = "${_baseUrl}Authentication/Login";
  static String signUp = "${_baseUrl}Authentication/Register";
  static String forgotPassword = "${_baseUrl}Authentication/Forgot-Password";
  static String resetPassword = "${_baseUrl}Authentication/Reset-Password";
  static String activity = "${_baseUrl}Individual/log-activity";
  static String getRank = "${_baseUrl}Individual/rank";
  static String confirmEmail = "${_baseUrl}Authentication/Confirm-Email";
  static String refreshToken = "${_baseUrl}Authentication/Refresh-Token";
  

}

class ApiKey {
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  static const String userType = "userType";
  static const String displayName = "displayName";
  static const String userName = "userName";
  static const String email = "email";
  static const String password = "password";
  static const String phoneNumber = "phoneNumber";
  static const String country = "country";
  static const String city = "city";
  static const String token = "token";
  static const String newPassword = "newPassword";
  static const String sex = "Sex";
  static const String diet = "Diet";
  static const String bodyType = "BodyType";
  static const String shower = "ShowerFreq";
  static const String heatSrs = "HeatingSource";
  static const String travelFreq = "AirTravelFreq";
  static const String vehicleType = "VehicleType";
  static const String cookingMethods = "CookingMethods";
  static const String socialActivity = "SocialActivity";
  static const String transport = "Transport";
  static const String wastedBag = "WasteBagSize";
  static const String recycOprions = "RecyclingOptions";
  static const String dailyTv = "DailyTvTime";
  static const String monthlyCloth = "MonthlyClothingPurchases";
  static const String dailyInternet = "DailyInternetUsage";
  static const String wastedBagCnt = "WasteBagWeeklyCount";
  static const String vehicleDist = "VehicleDistanceKm";
  static const String energyEff = "EnergyEfficiency";
  static const String groceryBill = "GroceryBill";
  static const String refreshToken = "refreshToken";
}
