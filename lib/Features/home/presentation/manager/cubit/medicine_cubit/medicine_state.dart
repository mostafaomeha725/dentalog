part of 'medicine_cubit.dart';

abstract class MedicineState extends Equatable {
  const MedicineState();

  @override
  List<Object?> get props => [];
}

class MedicineInitial extends MedicineState {}

class MedicineLoading extends MedicineState {}

class MedicineSuccess extends MedicineState {
  final List<dynamic> medicines;

  const MedicineSuccess({required this.medicines});

  @override
  List<Object?> get props => [medicines];
}

class MedicineFailure extends MedicineState {
  final String errorMessage;

  const MedicineFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
