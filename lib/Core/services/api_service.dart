import 'package:dio/dio.dart';
import 'package:graduation_project/Core/api/api_interceptors.dart';
import 'package:graduation_project/Core/api/end_points.dart';
import 'package:graduation_project/Core/errors/error_model.dart';
import 'package:graduation_project/Core/errors/exceptions.dart'; // For ServerException

class ApiService {
  late Dio _dio;
  final String baseUrl = EndPoint.baseUrl;

  ApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 3),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));
    _dio.interceptors.add(LogInterceptor(
      request: true,
      requestBody: true,
      responseBody: true,
      responseHeader: false,
    ));
    _dio.interceptors.add(ApiInterceptor()); // Add token handling
  }

  Future<void> register({
  required String email,
  required String password,
  required String userName,
  required String displayName,
  required String phoneNumber,
  required String country,
  required String city,
}) async {
  try {
    final response = await _dio.post(
      EndPoint.signUp, // "/Authentication/Register"
      data: {
        ApiKey.email: email,
        ApiKey.password: password,
        ApiKey.userName: userName,
        ApiKey.displayName: displayName,
        ApiKey.phoneNumber: phoneNumber,
        ApiKey.country: country,
        ApiKey.city: city,
      },
    );
    // Assuming successful registration returns a token or success message
    if (response.data is Map<String, dynamic> && response.data[ApiKey.token] != null) {
      return; // Success
    } else {
      throw ServerException(
        errModel: ErrorModel(
          status: -1,
          errorMessage: "Registration failed: No token received",
        ),
      );
    }
  } on DioException catch (e) {
    throw _handleError(e);
  }
}

  Future<String> login(String email, String password) async {
    try {
      final response = await _dio.get(
        EndPoint.signIn,
        queryParameters: {
          ApiKey.email: email,
          ApiKey.password: password,
        },
      );
      if (response.data is Map<String, dynamic>) {
        final token = response.data[ApiKey.token];
        if (token == null) {
          throw ServerException(
            errModel: ErrorModel(status: -1, errorMessage: "No token received"),
          );
        }
        return token;
      } else if (response.data is String) {
        return response.data;
      } else {
        throw ServerException(
          errModel: ErrorModel(
            status: -1,
            errorMessage: "Unexpected response format",
          ),
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> getData(String endpoint) async {
    try {
      final response = await _dio.get(endpoint);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Future<Response> postData(String endpoint, Map<String, dynamic> data) async {
    try {
      final response = await _dio.post(endpoint, data: data);
      return response;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  ServerException _handleError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return ServerException(
          errModel: ErrorModel(
            status: -1,
            errorMessage: "Connection timed out. Please check your internet.",
          ),
        );
      case DioExceptionType.badResponse:
        if (error.response != null) {
          return ServerException(
            errModel: error.response!.data != null &&
                    error.response!.data is Map<String, dynamic>
                ? ErrorModel.fromJson(error.response!.data)
                : ErrorModel(
                    status: error.response!.statusCode ?? -1,
                    errorMessage: "Server error: ${error.response?.statusCode}",
                  ),
          );
        }
        return ServerException(
          errModel: ErrorModel(status: -1, errorMessage: "No response from server"),
        );
      case DioExceptionType.cancel:
        return ServerException(
          errModel: ErrorModel(status: -1, errorMessage: "Request was cancelled"),
        );
      default:
        return ServerException(
          errModel: ErrorModel(
            status: -1,
            errorMessage: "Network error: ${error.message}",
          ),
        );
    }
  }
}