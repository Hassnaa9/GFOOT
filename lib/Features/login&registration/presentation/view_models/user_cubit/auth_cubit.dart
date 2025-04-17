import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/cache/cache_helper.dart';
import 'package:graduation_project/Core/errors/exceptions.dart';
import 'package:graduation_project/Data/repository/auth_repository.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<UserState> {
  final AuthRepository authRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String? _email; // Store email temporarily
  String? _otp;   // Store OTP temporarily

  AuthCubit(this.authRepository) : super(UserInitial());

  Future<Map<String, dynamic>?> getCurrentUser() async {
    final token = await CacheHelper().getData(key: 'token');
    if (token != null) {
      final userData = {
        'email': 'user@example.com',
        'token': token,
      };
      return userData;
    }
    return null;
  }

  Future<void> clearToken() async {
    await CacheHelper().removeData(key: 'token');
  }

  Future<void> login(String email, String password) async {
    emit(SignInLoading());
    try {
      await authRepository.login(email, password);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    }
  }

  Future<void> signInWithGoogle(User user) async {
    emit(SignInLoading());
    try {
      final idToken = await user.getIdToken();
      await clearToken();
      // Assuming authRepository can handle Firebase token
      await authRepository.googleLogin(idToken!);
      await CacheHelper().saveData(key: 'token', value: idToken);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: 'Google Sign-In Failed: $e'));
    }
  }

  Future<void> signInWithFacebook(User user) async {
    emit(SignInLoading());
    try {
      final idToken = await user.getIdToken();
      await clearToken();
      // Assuming authRepository can handle Firebase token
      await authRepository.facebookLogin(idToken!);
      await CacheHelper().saveData(key: 'token', value: idToken);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: 'Facebook Sign-In Failed: $e'));
    }
  }

  // In auth_cubit.dart

Future<void> register(
  String userName,
  String displayName,
  String email,
  String password,
  String phoneNumber,
  String country,
  String city,
  String userType,
) async {
  emit(SignUpLoading());
  try {
    await authRepository.register(
      userName,
      displayName,
      email,
      password,
      phoneNumber,
      country,
      city,
      userType,
    );
    _email = email; // Store email for OTP verification
    emit(SignUpSuccess(message: 'Registration successful! Please verify your email.'));
  } catch (e) {
    String errorMessage = 'An unexpected error occurred';
    if (e is ServerException) {
      errorMessage = e.errModel.errorMessage ?? 'Registration failed';
      if (errorMessage.contains('email')) {
        errorMessage = 'This email is already registered. Please use a different email.';
      }
    }
    emit(SignUpFailure(errMessage: errorMessage));
  }
}

  Future<void> forgotPassword(String email, BuildContext context) async {
    emit(SignInLoading());
    try {
      await authRepository.forgotPassword(email);
      _email = email; // Store email temporarily
      emit(ForgotPasswordSuccess());
      Navigator.pushNamed(context, '/Verify', arguments: email);
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    }
}
  void storeOtp(String otp) {
    _otp = otp; // Store OTP
    emit(OtpStored()); 
  }

 Future<void> resetPassword(String newPassword) async {
    if (_email == null || _otp == null) {
      emit(SignInFailure(errMessage: 'Email or OTP missing'));
      return;
    }
    emit(SignInLoading());
    try {
      await authRepository.resetPassword(_email!, newPassword, _otp!);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    } finally {
      _email = null; // Clear stored data
      _otp = null;
    }
  }

  Future<void> logout() async {
    await _auth.signOut(); // Sign out from Firebase
    await clearToken();
    emit(UserInitial());
  }

  
Future<void> resendResetConfirmEmailOtp(String email, BuildContext context) async {
    emit(SignInLoading());
    try {
      await authRepository.resendResetConfirmEmailOtp(email);
      _email = email; // Update stored email
      emit(OtpVerificationFailure(errMessage: 'OTP is not valid'));
    } catch (e) {
      emit(OtpVerificationSuccess(errMessage: e.toString()));
    }
  }
  Future<void> resendResetPasswordOtp(String email, BuildContext context) async {
    emit(SignInLoading());
    try {
      await authRepository.resendResetPasswordOtp(email);
      _email = email; // Update stored email
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    }
  }

Future<void> verifyConfirmEmailOtp(String email, String otp) async {
    emit(SignInLoading());
    try {
      await authRepository.verifyConfirmEmailOtp(email, otp);
      emit(OtpVerificationSuccess(errMessage: 'OTP verified successfully'));
    } catch (e) {
      emit(OtpVerificationFailure(errMessage: e.toString()));
    }
  }

  Future<void> verifyResetPasswordOtp(String email, String otp,String newPasswod) async {
    emit(SignInLoading());
    try {
      await authRepository.verifyResetPasswordOtp(email, otp,newPasswod);
      emit(OtpVerificationSuccess(errMessage: 'OTP verified successfully'));
    } catch (e) {
      emit(OtpVerificationFailure(errMessage: e.toString()));
    }
  }
}