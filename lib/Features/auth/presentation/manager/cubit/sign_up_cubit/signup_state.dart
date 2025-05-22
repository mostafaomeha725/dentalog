part of 'signup_cubit.dart';

@immutable
abstract class SignUpState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {
  final String email;
  final String password;

  SignUpSuccess({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

class SignUpFailure extends SignUpState {
  final String errMessage;

  SignUpFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
