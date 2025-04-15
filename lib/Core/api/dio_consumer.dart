import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/api_interceptors.dart';
import 'package:graduation_project/Core/api/end_points.dart';
import 'package:dio/dio.dart';
import 'package:graduation_project/Core/errors/error_model.dart';
import 'package:graduation_project/Core/errors/exceptions.dart';

class DioConsumer extends ApiConsumer {
  final Dio dio;

  DioConsumer({required this.dio}) {
    dio.options.baseUrl = EndPoint.baseUrl;
    dio.interceptors.add(ApiInterceptor());
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
    ));
  }

  @override
  Future post(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
    required bool isFromData,
    bool isUrlEncoded = false,
  }) async {
    try {
      dynamic requestData;
      String? contentType;

      if (isUrlEncoded && data != null) {
        // Convert map to URL-encoded string
        requestData = (data as Map<String, dynamic>)
            .entries
            .map((e) => '${Uri.encodeQueryComponent(e.key)}=${Uri.encodeQueryComponent(e.value.toString())}')
            .join('&');
        contentType = 'application/x-www-form-urlencoded';
      } else if (isFormData && data != null) {
        requestData = FormData.fromMap(data as Map<String, dynamic>);
        contentType = 'multipart/form-data';
      } else {
        requestData = data;
        contentType = 'application/json';
      }

      final response = await dio.post(
        path,
        data: requestData,
        queryParameters: queryParameters,
        options: Options(
          contentType: contentType,
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      final response = await dio.get(
        path,
        data: data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFormData && data != null ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFormData && data != null ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future put(
    String path, {
    Object? data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFormData = false,
  }) async {
    try {
      final response = await dio.put(
        path,
        data: isFormData && data != null ? FormData.fromMap(data as Map<String, dynamic>) : data,
        queryParameters: queryParameters,
        options: Options(
          contentType: isFormData ? 'multipart/form-data' : 'application/json',
          headers: headers,
        ),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  Never handleDioExceptions(DioException e) {
    throw ServerException(
      errModel: ErrorModel(
        status: e.response?.statusCode ?? 500,
        errorMessage: e.response?.data['title'] ?? e.message ?? 'Unknown error',
        message: e.response?.data['message'] ?? 'Unexpected error occurred',
      ),
    );
  }
}