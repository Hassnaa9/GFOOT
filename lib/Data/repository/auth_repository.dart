import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/end_points.dart';
import 'package:graduation_project/Core/cache/cache_helper.dart';
import 'package:graduation_project/Core/errors/exceptions.dart';
import 'package:graduation_project/Core/models/login_model.dart';
import 'package:graduation_project/Core/models/register_model.dart';

class AuthRepository {
  final ApiConsumer apiConsumer;

  AuthRepository({required this.apiConsumer});

  // Login Method
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await apiConsumer.get( // Changed to GET as per backend requirement
        EndPoint.signIn,
        queryParameters: {
          "email": email,
          "password": password,
        },
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.token != null) {
        await CacheHelper().saveData(key: 'token', value: loginResponse.token!);
      }

      return loginResponse;
    } on ServerException catch (e) {
      throw e.errModel.fullErrorMessage; // Throw the full error message
    } catch (e) {
      throw e.toString();
    }
  }

  // Register Method
  Future<RegisterModel> register(
    String userName,
    String displayName,
    String email,
    String password,
    String phoneNumber,
    String country,
    String city,
    String userType,
  ) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.signUp,
        data: {
          "userName": userName,
          "displayName": displayName,
          "email": email,
          "password": password,
          "phoneNumber": phoneNumber,
          "country": country,
          "city": city,
          "userType": userType,
        },
      );

      final registerModel = RegisterModel.fromJson(response);
      if (registerModel.token != null) {
        await CacheHelper().saveData(key: 'token', value: registerModel.token!);
      }

      return registerModel;
    } on ServerException catch (e) {
      throw e.errModel.fullErrorMessage; // Throw the full error message
    } catch (e) {
      throw e.toString();
    }
  }

  // Forgot Password Method
  Future<void> forgotPassword(String email) async {
    try {
      await apiConsumer.post(
        EndPoint.forgotPassword,
        data: {
          "email": email,
        },
      );
    } on ServerException catch (e) {
      throw e.errModel.fullErrorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  // Reset Password Method
  Future<void> resetPassword(String email, String newPassword) async {
    try {
      await apiConsumer.post(
        EndPoint.resetPassword,
        data: {
          "email": email,
          "newPassword": newPassword,
        },
      );
    } on ServerException catch (e) {
      throw e.errModel.fullErrorMessage;
    } catch (e) {
      throw e.toString();
    }
  }
}