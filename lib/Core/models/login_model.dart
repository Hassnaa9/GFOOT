// Core/models/login_model.dart
class LoginRequestModel {
  final String email;
  final String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
    };
  }
}

class LoginResponseModel {
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  LoginResponseModel({
    this.accessToken,
    this.refreshToken,
    this.message,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    return LoginResponseModel(
      accessToken: json['AccessToken'] as String?,
      refreshToken: json['RefreshToken'] as String?,
      message: json['message'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'AccessToken': accessToken,
      'RefreshToken': refreshToken,
      'message': message,
    };
  }
}