part of 'show_specialtiesbyid_cubit.dart';

abstract class ShowSpecialtiesbyidState extends Equatable {
  const ShowSpecialtiesbyidState();

  @override
  List<Object?> get props => [];
}

class ShowSpecialtiesbyidInitial extends ShowSpecialtiesbyidState {}

class ShowSpecialtiesbyidLoading extends ShowSpecialtiesbyidState {}

class ShowSpecialtiesbyidSuccess extends ShowSpecialtiesbyidState {
  final Map<String, dynamic> data;

  const ShowSpecialtiesbyidSuccess(this.data);

  @override
  List<Object?> get props => [data];
}

class ShowSpecialtiesbyidFailure extends ShowSpecialtiesbyidState {
  final String error;

  const ShowSpecialtiesbyidFailure(this.error);

  @override
  List<Object?> get props => [error];
}
