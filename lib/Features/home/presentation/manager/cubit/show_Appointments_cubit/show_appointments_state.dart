part of 'show_appointments_cubit.dart';

abstract class ShowAppointmentsState extends Equatable {
  const ShowAppointmentsState();

  @override
  List<Object> get props => [];
}

class ShowAppointmentsInitial extends ShowAppointmentsState {}

class ShowAppointmentsLoading extends ShowAppointmentsState {}

class ShowAppointmentsSuccess extends ShowAppointmentsState {
  final List<dynamic> appointmentsData;

  const ShowAppointmentsSuccess({required this.appointmentsData});

  @override
  List<Object> get props => [appointmentsData];
}

class ShowAppointmentsFailure extends ShowAppointmentsState {
  final String errorMessage;

  const ShowAppointmentsFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
