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
    final response = await apiConsumer.post(
      EndPoint.signIn,
      queryParameters: {
      },
      data: {
        ApiKey.email: email,
        ApiKey.password: password, 
      },
      isFromData: false,
    );
    final loginResponse = LoginResponseModel.fromJson(response);
    if (loginResponse.token != null) {
      await CacheHelper().saveData(key: 'token', value: loginResponse.token!);
    }
    return loginResponse;
  } on ServerException catch (e) {
    throw e.errModel.fullErrorMessage;
  } catch (e) {
    throw e.toString();
  }
}
  Future<LoginResponseModel> googleLogin(String googleAccessToken) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.googleSignIn, // Add this endpoint to your EndPoints class
        data: {
          "accessToken": googleAccessToken,
        },
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.token != null) {
        await CacheHelper().saveData(key: 'token', value: loginResponse.token!);
      }

      return loginResponse;
    } on ServerException catch (e) {
      throw e.errModel.fullErrorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  // Facebook Login Method
  Future<LoginResponseModel> facebookLogin(String facebookAccessToken) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.facebookSignIn, // Add this endpoint to your EndPoints class
        data: {
          "accessToken": facebookAccessToken,
        },
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.token != null) {
        await CacheHelper().saveData(key: 'token', value: loginResponse.token!);
      }

      return loginResponse;
    } on ServerException catch (e) {
      throw e.errModel.fullErrorMessage;
    } catch (e) {
      throw e.toString();
    }
  }

  // Apple Login Method
  Future<LoginResponseModel> appleLogin(String appleIdToken) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.appleSignIn, // Add this endpoint to your EndPoints class
        data: {
          "idToken": appleIdToken,
        },
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.token != null) {
        await CacheHelper().saveData(key: 'token', value: loginResponse.token!);
      }

      return loginResponse;
    } on ServerException catch (e) {
      throw e.errModel.fullErrorMessage;
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
// forgot password Method
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
  Future<void> resetPassword(String email, String newPassword, String otp) async {
  try {
    await apiConsumer.put(
      EndPoint.resetPassword,
      data: {
        ApiKey.email: email,
        ApiKey.newPassword: newPassword,
        ApiKey.otp: otp, 
      },
    );
  } on ServerException catch (e) {
    throw e.errModel.fullErrorMessage;
  } catch (e) {
    throw e.toString();
  }
}


  // Resend OTP Method
Future<void> resendOtp(String email) async {
  try {
    await apiConsumer.post(
      EndPoint.resendOtp,
      data: {ApiKey.email: email},
    );
  } on ServerException catch (e) {
    throw e.errModel.fullErrorMessage;
  } catch (e) {
    throw e.toString();
  }
}
}