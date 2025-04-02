import 'package:graduation_project/Core/api/end_points.dart';

class ErrorModel {
  final int status;
  final String errorMessage;

  ErrorModel({required this.status, required this.errorMessage});

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    return ErrorModel(
      status: jsonData[ApiKey.status] is int
          ? jsonData[ApiKey.status]
          : (jsonData['statusCode'] ?? -1), // Fallback for alternative key or missing status
      errorMessage: jsonData[ApiKey.errorMessage] is String
          ? jsonData[ApiKey.errorMessage]
          : (jsonData['message'] ?? 'Unknown error'), // Fallback for alternative key or missing message
    );
  }
}