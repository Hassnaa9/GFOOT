import 'package:graduation_project/Core/api/end_points.dart';

class ErrorModel {
  final int status;
  final String errorMessage;
  final List<String>? errors; // New field for validation errors

  ErrorModel({
    required this.status,
    required this.errorMessage,
    this.errors, required String message,
  });

  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    final errorsList = jsonData['Errors'] is List
        ? List<String>.from(jsonData['Errors'].map((e) => e.toString()))
        : null;

    return ErrorModel(
      status: jsonData[ApiKey.status] is int
          ? jsonData[ApiKey.status]
          : (jsonData['StatusCode'] ?? -1), // Support "StatusCode" key
      errorMessage: jsonData[ApiKey.errorMessage] is String
          ? jsonData[ApiKey.errorMessage]
          : (jsonData['message'] ?? 'Unknown error'),
      errors: errorsList, message: '',
    );
  }

  // Combine errorMessage and errors into a single string for display
  String get fullErrorMessage {
    if (errors == null || errors!.isEmpty) {
      return errorMessage;
    }
    return '$errorMessage: ${errors!.join(" ")}';
  }

  get message => null;
}