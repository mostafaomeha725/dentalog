part of 'doctor_rating_cubit.dart';

abstract class DoctorRatingState extends Equatable {
  const DoctorRatingState();

  @override
  List<Object> get props => [];
}

class DoctorRatingInitial extends DoctorRatingState {}

class DoctorRatingLoading extends DoctorRatingState {}

class DoctorRatingSuccess extends DoctorRatingState {
  final Map<String, dynamic> data;

  const DoctorRatingSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class DoctorRatingFailure extends DoctorRatingState {
  final String error;

  const DoctorRatingFailure(this.error);

  @override
  List<Object> get props => [error];
}
