class RegisterModel {
  final String? accessToken;
  final String? refreshToken;
  final String? message;

  RegisterModel({
    this.accessToken,
    this.refreshToken = '',
    this.message = '',
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
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