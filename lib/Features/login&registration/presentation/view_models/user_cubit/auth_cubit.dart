import 'package:bloc/bloc.dart';
import 'package:graduation_project/Core/cache/cache_helper.dart';
import 'package:graduation_project/Data/repository/auth_repository.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<UserState> {
  final AuthRepository authRepository;
  final FirebaseAuth _auth = FirebaseAuth.instance;

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
      await clearToken();
      final loginResponse = await authRepository.login(email, password);
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

  Future<void> forgotPassword(String email) async {
    emit(SignInLoading());
    try {
      await authRepository.forgotPassword(email);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    }
  }

  Future<void> resetPassword(String email, String newPassword) async {
    emit(SignInLoading());
    try {
      await authRepository.resetPassword(email, newPassword);
      emit(SignInSuccess());
    } catch (e) {
      emit(SignInFailure(errMessage: e.toString()));
    }
  }

  Future<void> logout() async {
    await _auth.signOut(); // Sign out from Firebase
    await clearToken();
    emit(UserInitial());
  }
}