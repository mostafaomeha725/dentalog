part of 'reschedule_cubit.dart';

abstract class RescheduleState extends Equatable {
  const RescheduleState();

  @override
  List<Object?> get props => [];
}

class RescheduleInitial extends RescheduleState {}

class RescheduleLoading extends RescheduleState {}

class RescheduleSuccess extends RescheduleState {
  final Map<String, dynamic> response;

  const RescheduleSuccess(this.response);

  @override
  List<Object?> get props => [response];
}

class RescheduleFailure extends RescheduleState {
  final String error;

  const RescheduleFailure(this.error);

  @override
  List<Object?> get props => [error];
}
