import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:graduation_project/Core/api/api_consumer.dart';
import 'package:graduation_project/Core/api/end_points.dart';
import 'package:graduation_project/Core/errors/error_model.dart';
import 'package:graduation_project/Core/errors/exceptions.dart';
import 'package:graduation_project/Core/models/login_model.dart';
import 'package:graduation_project/Core/models/register_model.dart';
import 'package:graduation_project/Core/models/user_model.dart';

class AuthRepository {
  final ApiConsumer apiConsumer;
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  AuthRepository({required this.apiConsumer});

  // Login Method
  Future<LoginResponseModel> login(String email, String password) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.signIn,
        queryParameters: {},
        data: {
          ApiKey.email: email,
          ApiKey.password: password,
        },
        isFromData: false,
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.accessToken != null && loginResponse.refreshToken != null) {
        await secureStorage.write(key: 'accessToken', value: loginResponse.accessToken!);
        await secureStorage.write(key: 'refreshToken', value: loginResponse.refreshToken!);
        print('AuthRepository: Tokens saved - AccessToken: ${loginResponse.accessToken}, RefreshToken: ${loginResponse.refreshToken}');
      } else {
        throw ServerException(
          errModel: ErrorModel(
            status: 400,
            errorMessage: 'Missing tokens in response',
            message: 'Login response did not contain required tokens',
          ),
        );
      }
      return loginResponse;
    } on ServerException catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during login',
        ),
      );
    }
  }

  // Google Login Method
  Future<LoginResponseModel> googleLogin(String googleAccessToken) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.googleSignIn,
        data: {
          "accessToken": googleAccessToken,
        }, isFromData: false,
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.accessToken != null && loginResponse.refreshToken != null) {
        await secureStorage.write(key: 'accessToken', value: loginResponse.accessToken!);
        await secureStorage.write(key: 'refreshToken', value: loginResponse.refreshToken!);
        print('AuthRepository: Google Tokens saved - AccessToken: ${loginResponse.accessToken}, RefreshToken: ${loginResponse.refreshToken}');
      } else {
        throw ServerException(
          errModel: ErrorModel(
            status: 400,
            errorMessage: 'Missing tokens in response',
            message: 'Google login response did not contain required tokens',
          ),
        );
      }
      return loginResponse;
    } on ServerException catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during Google login',
        ),
      );
    }
  }

  // Facebook Login Method
  Future<LoginResponseModel> facebookLogin(String facebookAccessToken) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.facebookSignIn,
        data: {
          "accessToken": facebookAccessToken,
        }, isFromData: false,
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.accessToken != null && loginResponse.refreshToken != null) {
        await secureStorage.write(key: 'accessToken', value: loginResponse.accessToken!);
        await secureStorage.write(key: 'refreshToken', value: loginResponse.refreshToken!);
        print('AuthRepository: Facebook Tokens saved - AccessToken: ${loginResponse.accessToken}, RefreshToken: ${loginResponse.refreshToken}');
      } else {
        throw ServerException(
          errModel: ErrorModel(
            status: 400,
            errorMessage: 'Missing tokens in response',
            message: 'Facebook login response did not contain required tokens',
          ),
        );
      }
      return loginResponse;
    } on ServerException catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during Facebook login',
        ),
      );
    }
  }

  // Apple Login Method
  Future<LoginResponseModel> appleLogin(String appleIdToken) async {
    try {
      final response = await apiConsumer.post(
        EndPoint.appleSignIn,
        data: {
          "idToken": appleIdToken,
        }, isFromData: false,
      );

      final loginResponse = LoginResponseModel.fromJson(response);
      if (loginResponse.accessToken != null && loginResponse.refreshToken != null) {
        await secureStorage.write(key: 'accessToken', value: loginResponse.accessToken!);
        await secureStorage.write(key: 'refreshToken', value: loginResponse.refreshToken!);
        print('AuthRepository: Apple Tokens saved - AccessToken: ${loginResponse.accessToken}, RefreshToken: ${loginResponse.refreshToken}');
      } else {
        throw ServerException(
          errModel: ErrorModel(
            status: 400,
            errorMessage: 'Missing tokens in response',
            message: 'Apple login response did not contain required tokens',
          ),
        );
      }
      return loginResponse;
    } on ServerException catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during Apple login',
        ),
      );
    }
  }

  // Register Method
  // In auth_repository.dart

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
      isFromData: false,
    );

    final registerModel = RegisterModel.fromJson(response);
    if (registerModel.accessToken != null) {
      await secureStorage.write(key: 'accessToken', value: registerModel.accessToken!);
      if (registerModel.refreshToken != null) {
        await secureStorage.write(key: 'refreshToken', value: registerModel.refreshToken!);
      } else {
        print('AuthRepository: RefreshToken is null, proceeding without it');
      }
      print('AuthRepository: Register Tokens saved - AccessToken: ${registerModel.accessToken}, RefreshToken: ${registerModel.refreshToken}');
    } else {
      throw ServerException(
        errModel: ErrorModel(
          status: 400,
          errorMessage: 'Missing access token in response',
          message: 'Register response did not contain required access token',
        ),
      );
    }
    return registerModel;
  } on ServerException catch (e) {
    throw ServerException(
      errModel: ErrorModel(
        status: e.errModel.status,
        errorMessage: e.errModel.errorMessage,
        message: e.errModel.message,
      ),
    );
  } catch (e) {
    throw ServerException(
      errModel: ErrorModel(
        status: 500,
        errorMessage: e.toString(),
        message: 'An unexpected error occurred during registration',
      ),
    );
  }
}

  // Forgot Password Method
  Future<void> forgotPassword(String email) async {
    try {
      await apiConsumer.post(
        EndPoint.forgotPassword,
        data: {
          "email": email,
        }, isFromData: false,
      );
    } on ServerException catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during forgot password',
        ),
      );
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
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during reset password',
        ),
      );
    }
  }

  // Resend OTP Method
  Future<void> resendResetPasswordOtp(String email) async {
    try {
      await apiConsumer.post(
        EndPoint.resendOtp,
        data: {ApiKey.email: email}, isFromData: false,
      );
    } on ServerException catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during resend OTP',
        ),
      );
    }
  }

  Future<void> resendResetConfirmEmailOtp(String email) async {
    try {
      await apiConsumer.post(
        EndPoint.sendConfirmationEmailOtp,
        data: {ApiKey.email: email}, isFromData: false,
      );
    } on ServerException catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during resend OTP',
        ),
      );
    }
  }

  // Refresh Token Method
  Future<String> refreshToken(String refreshToken) async {
    try {
      print('AuthRepository: Refreshing token with refreshToken: $refreshToken');
      final response = await apiConsumer.post(
        EndPoint.refreshToken,
        data: {
          'refreshToken': refreshToken,
        }, isFromData: false,
      );
      print('AuthRepository: Refresh token response: $response');
      final newAccessToken = response['AccessToken'] as String;
      final newRefreshToken = response['RefreshToken'] as String;

      await secureStorage.write(key: 'accessToken', value: newAccessToken);
      await secureStorage.write(key: 'refreshToken', value: newRefreshToken);
      print('AuthRepository: Tokens saved - AccessToken: $newAccessToken, RefreshToken: $newRefreshToken');

      return newAccessToken;
    } on ServerException catch (e) {
      print('AuthRepository: ServerException during token refresh: ${e.errModel.fullErrorMessage}');
      throw ServerException(
        errModel: ErrorModel(
          status: e.errModel.status,
          errorMessage: e.errModel.errorMessage,
          message: e.errModel.message,
        ),
      );
    } catch (e) {
      print('AuthRepository: General error during token refresh: $e');
      throw ServerException(
        errModel: ErrorModel(
          status: 500,
          errorMessage: e.toString(),
          message: 'An unexpected error occurred during token refresh',
        ),
      );
    }
  }

  // Logout Method (Uncomment if needed)
  // Future<void> logout() async {
  //   try {
  //     await apiConsumer.post(
  //       EndPoint.logout,
  //       data: {},
  //     );
  //     await secureStorage.delete(key: 'accessToken');
  //     await secureStorage.delete(key: 'refreshToken');
  //   } on ServerException catch (e) {
  //     throw ServerException(
  //       errModel: ErrorModel(
  //         status: e.errModel.status,
  //         errorMessage: e.errModel.errorMessage,
  //         message: e.errModel.message,
  //       ),
  //     );
  //   } catch (e) {
  //     throw ServerException(
  //       errModel: ErrorModel(
  //         status: 500,
  //         errorMessage: e.toString(),
  //         message: 'An unexpected error occurred during logout',
  //       ),
  //     );
  //   }
  // }

  // In auth_repository.dart

Future<void> verifyConfirmEmailOtp(String email, String otp) async {
  try {
     await apiConsumer.post(
      EndPoint.confirmEmail, 
      queryParameters: {
        ApiKey.email: email,
        ApiKey.otp: otp,
      },
      isFromData: false,
    );
    print('AuthRepository: OTP verified successfully for email: $email');
  } on ServerException catch (e) {
    throw ServerException(
      errModel: ErrorModel(
        status: e.errModel.status,
        errorMessage: e.errModel.errorMessage,
        message: e.errModel.message,
      ),
    );
  } catch (e) {
    throw ServerException(
      errModel: ErrorModel(
        status: 500,
        errorMessage: e.toString(),
        message: 'An unexpected error occurred during OTP verification',
      ),
    );
  }
}

Future<void> verifyResetPasswordOtp(String email, String otp,String newPassword) async {
  try {
     await apiConsumer.post(
      EndPoint.resetPassword, 
      data: {
        ApiKey.email: email,
        ApiKey.otp: otp,
        ApiKey.newPassword:newPassword,
      },
      isFromData: false,
    );
    print('AuthRepository: OTP verified successfully for email: $email');
  } on ServerException catch (e) {
    throw ServerException(
      errModel: ErrorModel(
        status: e.errModel.status,
        errorMessage: e.errModel.errorMessage,
        message: e.errModel.message,
      ),
    );
  } catch (e) {
    throw ServerException(
      errModel: ErrorModel(
        status: 500,
        errorMessage: e.toString(),
        message: 'An unexpected error occurred during OTP verification',
      ),
    );
  }
}

Future<UserModel> getUserProfile(String token) async {
  try {
    final response = await apiConsumer.get(
      EndPoint.getProfile,
      headers: {
        'Authorization': 'Bearer $token',
      },
    );
    return UserModel.fromJson(response);
  } catch (e) {
    throw Exception('Failed to fetch user profile');
  }
}



}