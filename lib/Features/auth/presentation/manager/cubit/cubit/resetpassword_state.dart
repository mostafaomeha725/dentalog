part of 'resetpassword_cubit.dart';

abstract class ResetpasswordState extends Equatable {
  const ResetpasswordState();

  @override
  List<Object> get props => [];
}

class ResetpasswordInitial extends ResetpasswordState {}

class ResetpasswordLoading extends ResetpasswordState {}

class ResetpasswordSuccess extends ResetpasswordState {}

class ResetpasswordFailure extends ResetpasswordState {
  final String errMessage;

  const ResetpasswordFailure({required this.errMessage});

  @override
  List<Object> get props => [errMessage];
}
