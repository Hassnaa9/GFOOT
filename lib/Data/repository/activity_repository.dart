import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/end_points.dart';
import 'package:graduation_project/Core/cache/cache_helper.dart';
import 'package:graduation_project/Core/errors/error_model.dart';
import 'package:graduation_project/Core/errors/exceptions.dart';

class ActivityRepository {
  final ApiConsumer apiConsumer;

  ActivityRepository({required this.apiConsumer});

  Future<double> logActivity({
    required Map<String, dynamic> queryParameters,
  }) async {
    try {
      final token = await CacheHelper().getData(key: 'token');
      print('ActivityRepository: Fetched token: $token');
      if (token == null) {
        throw ServerException(
          errModel: ErrorModel(
            status: 404,
            errorMessage: '',
            message: 'No token found',
          ),
        );
      }

      print('ActivityRepository: Sending POST request to ${EndPoint.activity}');
      print('ActivityRepository: Query Parameters: $queryParameters');
      final response = await apiConsumer.post(
        EndPoint.activity,
        queryParameters: queryParameters,
        headers: {
          'Authorization': 'Bearer $token',
        },
        data: {},
        isFromData: false,
      );

      print('ActivityRepository: Response received: $response');
      try {
  final carbonValue = response['CarbonEmission']?.toDouble() ?? 0.0;
  return carbonValue;
} catch (e) {
  print('Failed to parse carbonEmission: $e');
  throw Exception('Invalid carbonEmission value');
}


    } on ServerException catch (e) {
      print('ActivityRepository: ServerException: ${e.errModel.fullErrorMessage}');
      throw e.errModel.fullErrorMessage;
    } catch (e) {
      print('ActivityRepository: General error: $e');
      throw e.toString();
    }
  }
  Future<Map<String, dynamic>> fetchStatistics(String period) async {
  try {
    final response = await apiConsumer.get(
      EndPoint.activityStatistics, // Adjust to the actual endpoint
      queryParameters: {
        // ApiKey.period: period, // Daily, Weekly, Monthly, Yearly
      },
    );
    return response; // Assuming response is a Map<String, dynamic>
  } on ServerException catch (e) {
    throw e.errModel.fullErrorMessage;
  } catch (e) {
    throw e.toString();
  }
}
}