// Core/features/login®istration/presentation/view_models/user_cubit/auth_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:graduation_project/Core/cache/cache_helper.dart';
import 'package:graduation_project/Data/repository/auth_repository.dart';
import 'package:graduation_project/Features/login&registration/presentation/view_models/user_cubit/auth_cubit_state.dart';

class AuthCubit extends Cubit<UserState> {
  final AuthRepository authRepository;

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
      emit(SignUpFailure(errMessage: e.toString()));
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
    await clearToken();
    emit(UserInitial());
  }
}