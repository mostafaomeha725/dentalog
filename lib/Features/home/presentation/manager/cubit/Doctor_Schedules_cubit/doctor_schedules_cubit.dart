import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart'; // Adjust if needed

part 'doctor_schedules_state.dart';

class DoctorSchedulesCubit extends Cubit<DoctorSchedulesState> {
  DoctorSchedulesCubit() : super(DoctorSchedulesInitial());

  Future<void> fetchDoctorSchedules(int doctorId) async {
    emit(DoctorSchedulesLoading());

    final response = await ApiService().getDoctorSchedules(doctorId);

    response.fold(
      (failure) => emit(DoctorSchedulesFailure(errorMessage: failure.errMessage)),
      (data) {
        final schedules = data['data'];
        if (schedules != null && schedules is List) {
          emit(DoctorSchedulesSuccess(schedulesData: schedules));
        } else {
          emit(DoctorSchedulesFailure(errorMessage: 'No schedule data found.'));
        }
      },
    );
  }
}
