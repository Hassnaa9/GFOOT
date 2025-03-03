class UserModel {
  static const String userType="IndividualUser";
  final String displayName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String country;
  final String city;

  UserModel({
    required this.displayName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      displayName: json["displayName"],
      userName: json["userName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      country: json["country"],
      city: json["city"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userType": userType,
      "displayName": displayName,
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "country": country,
      "city": city,
    };
  }
}
