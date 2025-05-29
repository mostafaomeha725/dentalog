part of 'updateappointmentstatus_cubit.dart';

abstract class UpdateAppointmentStatusState extends Equatable {
  const UpdateAppointmentStatusState();

  @override
  List<Object?> get props => [];
}

class UpdateAppointmentStatusInitial extends UpdateAppointmentStatusState {}

class UpdateAppointmentStatusLoading extends UpdateAppointmentStatusState {}

class UpdateAppointmentStatusSuccess extends UpdateAppointmentStatusState {
  final Map<String, dynamic> data;

  const UpdateAppointmentStatusSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class UpdateAppointmentStatusFailure extends UpdateAppointmentStatusState {
  final String error;

  const UpdateAppointmentStatusFailure(this.error);

  @override
  List<Object?> get props => [error];
}
