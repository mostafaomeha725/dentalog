part of 'book_appointment_cubit.dart';

abstract class BookAppointmentState extends Equatable {
  const BookAppointmentState();

  @override
  List<Object> get props => [];
}

class BookAppointmentInitial extends BookAppointmentState {}

class BookAppointmentLoading extends BookAppointmentState {}

class BookAppointmentSuccess extends BookAppointmentState {
  final Map<String, dynamic> data;

  const BookAppointmentSuccess(this.data);

  @override
  List<Object> get props => [data];
}

class BookAppointmentFailure extends BookAppointmentState {
  final String message;

  const BookAppointmentFailure(this.message);

  @override
  List<Object> get props => [message];
}
