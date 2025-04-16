import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/end_points.dart';
import 'package:graduation_project/Core/errors/error_model.dart';
import 'package:graduation_project/Core/errors/exceptions.dart';
import 'package:graduation_project/Core/models/rank_model.dart';
import 'package:graduation_project/Core/models/recommendations_model.dart';
import 'package:graduation_project/Core/models/statistics_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ActivityRepository {
  final ApiConsumer apiConsumer;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  ActivityRepository({required this.apiConsumer});

  Future<void> logActivity({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      String? token = await secureStorage.read(key: 'accessToken');
      print('ActivityRepository: Fetched token: $token');
      if (token == null) {
        throw ServerException(
          errModel: ErrorModel(
            status: 401,
            errorMessage: 'No token found',
            message: 'Please log in to continue',
          ),
        );
      }

      if (JwtDecoder.isExpired(token)) {
        print('ActivityRepository: Token expired, refreshing...');
        token = await _refreshToken();
      }

      print('ActivityRepository: Sending POST request to ${EndPoint.activity}');
      print('ActivityRepository: Request Body: $queryParameters');

      final response = await apiConsumer.post(
        EndPoint.activity,
        queryParameters: queryParameters,
        headers: {
          'Authorization': 'Bearer $token',
        },
         isFromData: false,
      );

      print('ActivityRepository: LogActivity response: $response');
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errors = errorData['errors'] as Map<String, dynamic>?;
        final errorMessage = errors != null
            ? errors.entries.map((entry) => '${entry.key}: ${entry.value.join(", ")}').join('; ')
            : errorData['title'] ?? 'Unknown error';
        final detailedMessage = errorData.toString(); // Capture the full error response
        print('ActivityRepository: DioException: $errorMessage');
        print('ActivityRepository: Full Error Response: $detailedMessage');
        throw ServerException(
          errModel: ErrorModel(
            status: e.response!.statusCode ?? 400,
            errorMessage: errorMessage,
            message: 'Validation failed: $errorMessage\nDetails: $detailedMessage',
          ),
        );
      }
      print('ActivityRepository: DioException: ${e.message}');
      throw ServerException(
        errModel: ErrorModel(
          status: 400,
          errorMessage: e.message ?? 'Unknown error',
          message: 'Unexpected error occurred while logging activity',
        ),
      );
    } catch (e) {
      print('ActivityRepository: General error: $e');
      throw ServerException(
        errModel: ErrorModel(
          status: 400,
          errorMessage: e.toString(),
          message: 'Unexpected error occurred while logging activity',
        ),
      );
    }
  }

  Future<double> getFootprint() async {
    try {
      String? token = await secureStorage.read(key: 'accessToken');
      print('ActivityRepository: Fetched token for getFootprint: $token');
      if (token == null) {
        throw ServerException(
          errModel: ErrorModel(
            status: 401,
            errorMessage: 'No token found',
            message: 'Please log in to continue',
          ),
        );
      }

      if (JwtDecoder.isExpired(token)) {
        print('ActivityRepository: Token expired, refreshing...');
        token = await _refreshToken();
      }

      print('ActivityRepository: Sending GET request to ${EndPoint.getCarbonValue}');
      final response = await apiConsumer.get(
        EndPoint.getCarbonValue,
        headers: {
          'Authorization': 'Bearer $token',
        },
      );

      print('ActivityRepository: GetFootprint response: $response');
      final carbonValue = double.tryParse(response.toString()) ?? 0.0;
      return carbonValue;
    } on DioException catch (e) {
      if (e.response != null) {
        final errorData = e.response!.data;
        final errors = errorData['errors'] as Map<String, dynamic>?;
        final errorMessage = errors != null
            ? errors.entries.map((entry) => '${entry.key}: ${entry.value.join(", ")}').join('; ')
            : errorData['title'] ?? 'Unknown error';
        print('ActivityRepository: DioException in getFootprint: $errorMessage');
        throw ServerException(
          errModel: ErrorModel(
            status: e.response!.statusCode ?? 400,
            errorMessage: errorMessage,
            message: 'Validation failed: $errorMessage',
          ),
        );
      }
      print('ActivityRepository: DioException in getFootprint: ${e.message}');
      throw ServerException(
        errModel: ErrorModel(
          status: 400,
          errorMessage: e.message ?? 'Unknown error',
          message: 'Unexpected error occurred while fetching footprint',
        ),
      );
    } catch (e) {
      print('ActivityRepository: General error in getFootprint: $e');
      throw ServerException(
        errModel: ErrorModel(
          status: 400,
          errorMessage: e.toString(),
          message: 'Unexpected error occurred while fetching footprint',
        ),
      );
    }
  }

  Future<String> _refreshToken() async {
    try {
      String? refreshToken = await secureStorage.read(key: 'refreshToken');
      if (refreshToken == null) {
        throw ServerException(
          errModel: ErrorModel(
            status: 401,
            errorMessage: 'No refresh token available',
            message: 'Please log in to continue',
          ),
        );
      }

      final response = await apiConsumer.post(
        EndPoint.refreshToken,
        data: {
          ApiKey.refreshToken: refreshToken,
        }, isFromData: false,
      );

      final newAccessToken = response['AccessToken'] as String;
      final newRefreshToken = response['RefreshToken'] as String;

      await secureStorage.write(key: 'accessToken', value: newAccessToken);
      await secureStorage.write(key: 'refreshToken', value: newRefreshToken);

      print('ActivityRepository: Token refreshed successfully');
      return newAccessToken;
    } catch (e) {
      print('ActivityRepository: Failed to refresh token: $e');
      throw ServerException(
        errModel: ErrorModel(
          status: 401,
          errorMessage: e.toString(),
          message: 'Session expired. Please log in again.',
        ),
      );
    }
  }

  Future<StatisticsModel> getStatistics(String token) async {
  final response = await apiConsumer.get(
    EndPoint.activityStatistics,
    headers: {
      'Authorization': 'Bearer $token',
    },
  );
  return StatisticsModel.fromJson(response);
}

Future<List<Recommendation>> getRecommendations(String token) async {
  final response = await apiConsumer.get(
    EndPoint.getRecommendations,
    headers: {'Authorization': 'Bearer $token'},
  );
  return (response as List).map((e) => Recommendation.fromJson(e)).toList();
}
Future<RankModel> getRanks(String token) async {
  final response = await apiConsumer.get(
    EndPoint.getRank, // Replace with your actual endpoint (e.g., 'api/ranks')
    headers: {'Authorization': 'Bearer $token'},
  );
  return RankModel.fromJson(response);
}

}