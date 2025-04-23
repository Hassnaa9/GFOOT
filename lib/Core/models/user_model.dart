class UserModel {
  final String id;
  final String displayName;
  final String userName;
  final String email;
  final String phoneNumber;
  final String country;
  final String city;

  UserModel({
    required this.id,
    required this.displayName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.country,
    required this.city,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['Id'],
      displayName: json['DisplayName'],
      userName: json['UserName'],
      email: json['Email'],
      phoneNumber: json['PhoneNumber'],
      country: json['Country'],
      city: json['City'],
    );
  }
}
