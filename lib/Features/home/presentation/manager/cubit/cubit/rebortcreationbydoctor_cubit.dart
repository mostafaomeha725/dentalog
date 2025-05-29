import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'rebortcreationbydoctor_state.dart';

class RebortcreationbydoctorCubit extends Cubit<RebortcreationbydoctorState> {
  RebortcreationbydoctorCubit() : super(RebortcreationbydoctorInitial());

  Future<void> submitReport({
    required int appointmentId,
    required String diagnosis,
    required String advice,
    required List<Map<String, dynamic>> medicines,
  }) async {
    emit(RebortcreationbydoctorLoading());

    final response = await ApiService().submitReportByDoctor(
      appointmentId: appointmentId,
      diagnosis: diagnosis,
      advice: advice,
      medicines: medicines,
    );

    response.fold(
      (failure) => emit(RebortcreationbydoctorFailure(failure.errMessage)),
      (data) => emit(RebortcreationbydoctorSuccess(data)),
    );
  }
}
