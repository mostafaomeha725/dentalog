import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart'; // Adjust as needed

part 'updateappointmentstatus_state.dart';

class UpdateAppointmentStatusCubit extends Cubit<UpdateAppointmentStatusState> {
  UpdateAppointmentStatusCubit() : super(UpdateAppointmentStatusInitial());

  Future<void> updateStatus({
    required int appointmentId,
    required String status,
  }) async {
    emit(UpdateAppointmentStatusLoading());

    final result = await ApiService().updateAppointmentStatusRequest(
      appointmentId: appointmentId,
      status: status,
    );

    result.fold(
      (failure) => emit(UpdateAppointmentStatusFailure(failure.errMessage)),
      (data) => emit(UpdateAppointmentStatusSuccess(data)),
    );
  }
}
