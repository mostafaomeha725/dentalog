part of 'showdoctor_cubit.dart';

abstract class ShowdoctorState extends Equatable {
  const ShowdoctorState();

  @override
  List<Object> get props => [];
}

class ShowdoctorInitial extends ShowdoctorState {}

class ShowdoctorLoading extends ShowdoctorState {}

class ShowdoctorFailure extends ShowdoctorState {
  final String errorMessage;
  const ShowdoctorFailure({required this.errorMessage});
  
  @override
  List<Object> get props => [errorMessage];
}

class ShowdoctorSuccess extends ShowdoctorState {
  final List doctorsData;
  const ShowdoctorSuccess({required this.doctorsData});
  
  @override
  List<Object> get props => [doctorsData];
}
