part of 'add_doctor_cubit.dart';

@immutable
sealed class AddDoctorState {}

final class AddDoctorInitial extends AddDoctorState {}

final class AddDoctorSuccess extends AddDoctorState {}

final class AddDoctorLoading extends AddDoctorState {}

final class AddDoctorFailure extends AddDoctorState {
  final String errMessage;
  AddDoctorFailure(this.errMessage);
}
