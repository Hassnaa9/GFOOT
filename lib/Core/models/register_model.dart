class RegisterRequestModel {
  static const String userType="IndividualUser";
  final String displayName;
  final String userName;
  final String email;
  final String password;
  final String phoneNumber;
  final String country;
  final String city;

  RegisterRequestModel({
    required this.displayName,
    required this.userName,
    required this.email,
    required this.password,
    required this.phoneNumber,
    required this.country,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      "userType": userType,
      "displayName": displayName,
      "userName": userName,
      "email": email,
      "password": password,
      "phoneNumber": phoneNumber,
      "country": country,
      "city": city,
    };
  }
}
