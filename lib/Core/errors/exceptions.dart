import 'package:dio/dio.dart';
import 'package:graduation_project/Core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel errModel;

  ServerException({required this.errModel});
}

void handleDioExceptions(DioException e) {
  // Default error model for cases where response is null
  final fallbackError = ErrorModel(
    status: -1,
    errorMessage: _getFallbackMessage(e.type),
  );

  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.badCertificate:
    case DioExceptionType.cancel:
    case DioExceptionType.connectionError:
    case DioExceptionType.unknown:
      throw ServerException(
        errModel: e.response != null
            ? ErrorModel.fromJson(e.response!.data)
            : fallbackError,
      );
    case DioExceptionType.badResponse:
      if (e.response != null) {
        switch (e.response?.statusCode) {
          case 400: // Bad request
          case 401: // Unauthorized
          case 403: // Forbidden
          case 404: // Not found
          case 409: // Conflict
          case 422: // Unprocessable Entity
          case 504: // Gateway Timeout
            throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
          default:
            throw ServerException(errModel: ErrorModel.fromJson(e.response!.data));
        }
      } else {
        throw ServerException(errModel: fallbackError);
      }
  }
}

// Helper method for fallback messages
String _getFallbackMessage(DioExceptionType type) {
  switch (type) {
    case DioExceptionType.connectionTimeout:
      return "Connection timed out. Please check your internet.";
    case DioExceptionType.sendTimeout:
      return "Request send timed out. Please try again.";
    case DioExceptionType.receiveTimeout:
      return "Response timed out. Server may be slow.";
    case DioExceptionType.connectionError:
      return "No internet connection. Please try again.";
    case DioExceptionType.cancel:
      return "Request was cancelled.";
    case DioExceptionType.badCertificate:
      return "Invalid server certificate.";
    case DioExceptionType.unknown:
      return "An unknown error occurred.";
    default:
      return "Something went wrong.";
  }
}