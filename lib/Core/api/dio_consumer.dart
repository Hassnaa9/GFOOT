import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/api_interceptors.dart';
import 'package:graduation_project/Core/api/end_points.dart';
import 'package:dio/dio.dart';
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
  Future delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.delete(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
  Future get(String path,
      {Object? data, Map<String, dynamic>? headers, Map<String, dynamic>? queryParameters}) async {
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
  Future patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    bool isFromData = false,
  }) async {
    try {
      final response = await dio.patch(
        path,
        data: isFromData ? FormData.fromMap(data) : data,
        queryParameters: queryParameters,
        options: Options(headers: headers),
      );
      return response.data;
    } on DioException catch (e) {
      handleDioExceptions(e);
    }
  }

  @override
Future post(
  String path, {
  dynamic data,
  Map<String, dynamic>? headers,
  Map<String, dynamic>? queryParameters,
  bool isFromData = false,
}) async {
  try {
    final response = await dio.post(
      path,
      data: isFromData ? FormData.fromMap(data) : data,
      options: Options(
        contentType: data == null ? null : 'application/json',
        headers: headers, // Use the provided headers
      ),
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
  bool isFromData = false,
}) async {
  try {
    final response = await dio.put(
      path,
      data: isFromData && data != null ? FormData.fromMap(data as Map<String, dynamic>) : data,
      queryParameters: queryParameters,
      options: Options(
        contentType: data == null ? null : (isFromData ? 'multipart/form-data' : 'application/json'),
        headers: headers, // Use the provided headers
      ),
    );
    return response.data;
  } on DioException catch (e) {
    handleDioExceptions(e);
  }
}
}