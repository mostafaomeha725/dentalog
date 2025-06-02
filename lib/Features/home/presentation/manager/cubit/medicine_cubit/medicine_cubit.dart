import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:dentalog/core/services/api_service.dart';

part 'medicine_state.dart';

class MedicineCubit extends Cubit<MedicineState> {
  MedicineCubit() : super(MedicineInitial());

  Future<void> fetchMedicines() async {
    emit(MedicineLoading());

    final response = await ApiService().getMedicines();

    response.fold(
      (failure) => emit(MedicineFailure(errorMessage: failure.errMessage)),
      (data) {
        final medicines = data['data'];
        if (medicines != null && medicines is List) {
          emit(MedicineSuccess(medicines: medicines));
        } else {
          emit(MedicineFailure(errorMessage: 'No medicine data found.'));
        }
      },
    );
  }
}
