import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';

part 'reschedule_state.dart';

class RescheduleCubit extends Cubit<RescheduleState> {
  RescheduleCubit() : super(RescheduleInitial());

  Future<void> rescheduleAppointment({
    required int appointmentId,
    required String appointmentDate,
    required String appointmentTime,
  }) async {
    emit(RescheduleLoading());

    final result = await ApiService().rescheduleAppointmentRequest(
      appointmentId: appointmentId,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
    );

    result.fold(
      (failure) => emit(RescheduleFailure(failure.errMessage)),
      (data) => emit(RescheduleSuccess(data)),
    );
  }
}
