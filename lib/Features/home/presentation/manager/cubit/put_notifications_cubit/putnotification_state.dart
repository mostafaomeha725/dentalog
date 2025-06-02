part of 'putnotification_cubit.dart';

abstract class PutnotificationState extends Equatable {
  const PutnotificationState();

  @override
  List<Object?> get props => [];
}

class PutnotificationInitial extends PutnotificationState {}

class PutnotificationLoading extends PutnotificationState {}

class PutnotificationSuccess extends PutnotificationState {
  final Map<String, dynamic> responseData;

  const PutnotificationSuccess({required this.responseData});

  @override
  List<Object?> get props => [responseData];
}

class PutnotificationFailure extends PutnotificationState {
  final String errorMessage;

  const PutnotificationFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
