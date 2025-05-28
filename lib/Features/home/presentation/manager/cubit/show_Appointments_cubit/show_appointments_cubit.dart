import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart';

part 'show_appointments_state.dart';

class ShowAppointmentsCubit extends Cubit<ShowAppointmentsState> {
  ShowAppointmentsCubit() : super(ShowAppointmentsInitial());

  Future<void> fetchAppointments() async {
    emit(ShowAppointmentsLoading());

    final response = await ApiService().showAppointments();

    response.fold(
      (failure) =>
          emit(ShowAppointmentsFailure(errorMessage: failure.errMessage)),
      (data) {
        final appointmentsList = data['data']?['data'];
        if (appointmentsList != null && appointmentsList is List) {
          emit(ShowAppointmentsSuccess(appointmentsData: appointmentsList));
        } else {
          emit(ShowAppointmentsFailure(errorMessage: 'No appointments data found.'));
        }
      },
    );
  }
}
