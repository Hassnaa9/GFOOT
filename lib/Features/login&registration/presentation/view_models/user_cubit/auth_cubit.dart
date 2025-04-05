import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/Core/cache/cache_helper.dart';
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
      final registerResponse = await authRepository.register(
        userName,
        displayName,
        email,
        password,
        phoneNumber,
        country,
        city,
        userType,
      );
      emit(SignUpSuccess(message: 'Registration successful'));
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
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
    emit(OtpStored()); // Trigger navigation to ChangePassword
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

  
Future<void> resendOtp(String email, BuildContext context) async {
    emit(SignInLoading());
    try {
      await authRepository.resendOtp(email);
      _email = email; // Update stored email
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    }
  }
}