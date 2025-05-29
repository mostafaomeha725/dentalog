part of 'forgetpassword_cubit.dart';

abstract class ForgetpasswordState extends Equatable {
  const ForgetpasswordState();

  @override
  List<Object?> get props => [];
}

class ForgetpasswordInitial extends ForgetpasswordState {}

class ForgetpasswordLoading extends ForgetpasswordState {}

class ForgetpasswordSuccess extends ForgetpasswordState {
  final String resetCode;

  const ForgetpasswordSuccess({required this.resetCode});

  @override
  List<Object?> get props => [resetCode];
}

class ForgetpasswordFailure extends ForgetpasswordState {
  final String errMessage;

  const ForgetpasswordFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
