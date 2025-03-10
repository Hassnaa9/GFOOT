// Core/models/register_model.dart
class RegisterModel {
  final String? token;
  final String? userName;
  final String? displayName;
  final String? email;
  final String? phoneNumber;
  final String? country;
  final String? city;
  final String? userType;

  RegisterModel({
    this.token,
    this.userName,
    this.displayName,
    this.email,
    this.phoneNumber,
    this.country,
    this.city,
    this.userType,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
      token: json['token'],
      userName: json['userName'],
      displayName: json['displayName'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      country: json['country'],
      city: json['city'],
      userType: json['userType'],
    );
  }
}