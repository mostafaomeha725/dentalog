part of 'show_specialties_cubit.dart';

abstract class ShowSpecialtiesState extends Equatable {
  const ShowSpecialtiesState();

  @override
  List<Object> get props => [];
}

class ShowSpecialtiesInitial extends ShowSpecialtiesState {}

class ShowSpecialtiesLoading extends ShowSpecialtiesState {}

class ShowSpecialtiesSuccess extends ShowSpecialtiesState {
  final Map<String, dynamic> data;

  const ShowSpecialtiesSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class ShowSpecialtiesFailure extends ShowSpecialtiesState {
  final String message;

  const ShowSpecialtiesFailure(this.message);

  @override
  List<Object> get props => [message];
}
