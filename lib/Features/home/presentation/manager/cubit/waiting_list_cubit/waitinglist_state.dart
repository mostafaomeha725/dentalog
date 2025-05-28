part of 'waitinglist_cubit.dart';

abstract class WaitinglistState extends Equatable {
  const WaitinglistState();

  @override
  List<Object> get props => [];
}

class WaitinglistInitial extends WaitinglistState {}

class WaitinglistLoading extends WaitinglistState {}

class WaitinglistSuccess extends WaitinglistState {
  final List<dynamic> waitingData;

  const WaitinglistSuccess({required this.waitingData});

  @override
  List<Object> get props => [waitingData];
}

class WaitinglistFailure extends WaitinglistState {
  final String errorMessage;

  const WaitinglistFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
