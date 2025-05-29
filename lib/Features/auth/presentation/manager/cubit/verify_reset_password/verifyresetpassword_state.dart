part of 'verifyresetpassword_cubit.dart';

abstract class VerifyresetpasswordState extends Equatable {
  const VerifyresetpasswordState();

  @override
  List<Object?> get props => [];
}

class VerifyresetpasswordInitial extends VerifyresetpasswordState {}

class VerifyresetpasswordLoading extends VerifyresetpasswordState {}

class VerifyresetpasswordSuccess extends VerifyresetpasswordState {
  final String resetToken;

  const VerifyresetpasswordSuccess({required this.resetToken});

  @override
  List<Object?> get props => [resetToken];
}

class VerifyresetpasswordFailure extends VerifyresetpasswordState {
  final String errMessage;

  const VerifyresetpasswordFailure({required this.errMessage});

  @override
  List<Object?> get props => [errMessage];
}
