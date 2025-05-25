import 'package:dentalog/Features/home/presentation/manager/cubit/book_appointment_cubit/book_appointment_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Book_Appointment_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookAppointmentView extends StatefulWidget {
  const BookAppointmentView({
    super.key,
    required this.selectedDate,
    required this.selectedTime, required this.doctorId,
  });

  final DateTime selectedDate;
  final String selectedTime;
  final int doctorId;

  @override
  _BookAppointmentViewState createState() => _BookAppointmentViewState();
}

class _BookAppointmentViewState extends State<BookAppointmentView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookAppointmentCubit>(
      create: (context) => BookAppointmentCubit(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Book an Appointment",
            style: TextStyles.bold20w500,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
        ),
        body: BookAppointmentViewBody(
          selectedDate: widget.selectedDate,
          selectedTime: widget.selectedTime,
          doctorId:widget.doctorId,
        ),
      ),
    );
  }
}
