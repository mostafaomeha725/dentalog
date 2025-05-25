import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';


part 'book_appointment_state.dart';

class BookAppointmentCubit extends Cubit<BookAppointmentState> {
  BookAppointmentCubit() : super(BookAppointmentInitial());

  Future<void> bookAppointment({
    required int doctorId,
    required String appointmentDate,
    required String appointmentTime,
    required String name,
    required String phone,
    required int age,
    required String gender,
    required String address,
    required String problemDescription,
  }) async {
    emit(BookAppointmentLoading());

    final result = await ApiService().submitAppointmentRequest(
      doctorId: doctorId,
      appointmentDate: appointmentDate,
      appointmentTime: appointmentTime,
      name: name,
      phone: phone,
      age: age,
      gender: gender,
      address: address,
      problemDescription: problemDescription,
    );

    result.fold(
      (failure) => emit(BookAppointmentFailure(failure.errMessage)),
      (data) => emit(BookAppointmentSuccess(data)),
    );
  }
}
