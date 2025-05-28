part of 'showhistory_cubit.dart';

abstract class ShowhistoryState extends Equatable {
  const ShowhistoryState();

  @override
  List<Object> get props => [];
}

class ShowhistoryInitial extends ShowhistoryState {}

class ShowhistoryLoading extends ShowhistoryState {}

class ShowhistorySuccess extends ShowhistoryState {
  final List<dynamic> reportsData;

  const ShowhistorySuccess({required this.reportsData});

  @override
  List<Object> get props => [reportsData];
}

class ShowhistoryFailure extends ShowhistoryState {
  final String errorMessage;

  const ShowhistoryFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
