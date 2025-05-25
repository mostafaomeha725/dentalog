part of 'signin_cubit.dart';



sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {
  final String token;

  SignInSuccess({required this.token});
}


final class SignInFailure extends SignInState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}
//class SignInUnverifiedUser extends SignInState {}
