part of 'signout_cubit.dart';

abstract class SignoutState extends Equatable {
  @override
  List<Object> get props => [];
}

class SignoutInitial extends SignoutState {}

class SignoutLoading extends SignoutState {}

class SignoutSuccess extends SignoutState {}

class SignoutFailure extends SignoutState {
  final String message;
  SignoutFailure(this.message);

  @override
  List<Object> get props => [message];
}
