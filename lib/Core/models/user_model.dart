// Core/models/user_model.dart
class UserModel {
  final String userName;
  final String email;
  final String phoneNumber;
  final String country;
  final String? city;

  UserModel({
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userName: json["userName"],
      email: json["email"],
      phoneNumber: json["phoneNumber"],
      country: json["country"],
      city: json["city"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userName": userName,
      "email": email,
      "phoneNumber": phoneNumber,
      "country": country,
      "city": city,
    };
  }
}