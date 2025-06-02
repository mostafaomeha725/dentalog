part of 'doctor_schedules_cubit.dart';

abstract class DoctorSchedulesState extends Equatable {
  const DoctorSchedulesState();

  @override
  List<Object> get props => [];
}

class DoctorSchedulesInitial extends DoctorSchedulesState {}

class DoctorSchedulesLoading extends DoctorSchedulesState {}

class DoctorSchedulesSuccess extends DoctorSchedulesState {
  final List<dynamic> schedulesData;

  const DoctorSchedulesSuccess({required this.schedulesData});

  @override
  List<Object> get props => [schedulesData];
}

class DoctorSchedulesFailure extends DoctorSchedulesState {
  final String errorMessage;

  const DoctorSchedulesFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
