import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:dartz/dartz.dart';

part 'show_specialtiesbyid_state.dart';

class ShowSpecialtiesbyidCubit extends Cubit<ShowSpecialtiesbyidState> {
  final ApiService apiService;

  ShowSpecialtiesbyidCubit(this.apiService) : super(ShowSpecialtiesbyidInitial());

  Future<void> getSpecialtiesById(int id) async {
    emit(ShowSpecialtiesbyidLoading());

    final result = await apiService.showSpecialtiesbyid(id);

    result.fold(
      (failure) => emit(ShowSpecialtiesbyidFailure(failure.errMessage)),
      (data) => emit(ShowSpecialtiesbyidSuccess(data)),
    );
  }
}
