part of 'signin_cubit.dart';



sealed class SignInState {}

final class SignInInitial extends SignInState {}

final class SignInLoading extends SignInState {}

final class SignInSuccess extends SignInState {

  final String userId; // Add user ID to success state

  SignInSuccess({ required this.userId});
}

final class SignInFailure extends SignInState {
  final String errMessage;

  SignInFailure({required this.errMessage});
}
//class SignInUnverifiedUser extends SignInState {}
