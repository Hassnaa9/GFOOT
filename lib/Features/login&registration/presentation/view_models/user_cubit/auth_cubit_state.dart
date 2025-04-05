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
  final String message;

  SignUpSuccess({required this.message});

  @override
  List<Object?> get props => [message];
}

class SignUpFailure extends UserState {
  final String errMessage;

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