import 'package:equatable/equatable.dart';
import 'package:graduation_project/Core/models/user_model.dart';

class UserState extends Equatable {
  @override
  List<Object?> get props => [];
}

//////////////////////////////// Login States ///////////////////////////////////

class UserInitial extends UserState {}

class SignInLoading extends UserState {}

class SignInSuccess extends UserState {}

class SignInFailure extends UserState {
  final String errMessage;

  SignInFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

//////////////////////////////// Signup States ///////////////////////////////////

class SignUpLoading extends UserState {}

class SignUpSuccess extends UserState {
  final String? message;

  SignUpSuccess({required this.message});
  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends UserState {
  final String? errMessage;

  SignUpFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}

class UserAuthenticated extends UserState {
  final UserModel user;

  UserAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}
class ForgotPasswordSuccess extends UserState {}
class OtpStored extends UserState {}
class OtpVerificationSuccess extends UserState {
  final String message;
  OtpVerificationSuccess({this.message = 'OTP verified successfully', required String errMessage});
}
class ForgotPasswordFailure extends UserState {
  final String errMessage;

  ForgotPasswordFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
} 

class OtpVerificationFailure extends UserState {
  final String errMessage;
  OtpVerificationFailure({required this.errMessage});
}
class UserProfileLoading extends UserState {}

class UserProfileLoaded extends UserState {
  final UserModel user;
  UserProfileLoaded({required this.user});
}

class UserProfileError extends UserState {
  final String errorMessage;
  UserProfileError({required this.errorMessage});
}
class ResetPasswordFailure extends UserState {
  final String errMessage;

  ResetPasswordFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
class ResetPasswordSuccess extends UserState {
  final String message;

  ResetPasswordSuccess({required this.message});

  @override
  List<Object?> get props => [message];
} 
