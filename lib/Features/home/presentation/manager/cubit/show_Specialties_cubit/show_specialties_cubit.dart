import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'show_specialties_state.dart';

class ShowSpecialtiesCubit extends Cubit<ShowSpecialtiesState> {
  ShowSpecialtiesCubit(this.apiService) : super(ShowSpecialtiesInitial());
final ApiService apiService ;
  Future<void> showSpecialties() async {
    emit(ShowSpecialtiesLoading());

    final result = await apiService.showSpecialties (
   
    );

    result.fold(
      (failure) => emit(ShowSpecialtiesFailure(failure.errMessage)),
      (data) => emit(ShowSpecialtiesSuccess(data)),
    );
  }
}