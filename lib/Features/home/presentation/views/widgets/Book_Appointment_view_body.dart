import 'package:dentalog/Features/home/presentation/manager/cubit/book_appointment_cubit/book_appointment_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/widgets/Custom_buttom.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class BookAppointmentViewBody extends StatefulWidget {
  const BookAppointmentViewBody({
    super.key,
    required this.selectedDate,
    required this.selectedTime, 
    required this.doctorId,
  });

  final DateTime selectedDate;
  final String selectedTime;
  final int doctorId;

  @override
  State<BookAppointmentViewBody> createState() =>
      _BookAppointmentViewBodyState();
}

class _BookAppointmentViewBodyState extends State<BookAppointmentViewBody> {
  String? _selectedGender;
  final List<String> _genders = ["male", "female"];

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final ageController = TextEditingController();
  final addressController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookAppointmentCubit, BookAppointmentState>(
      listener: (context, state) {
        if (state is BookAppointmentSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Appointment booked successfully")),
          );
        GoRouter.of(context).pushReplacement(AppRouter.kDoctorView);
        } else if (state is BookAppointmentFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Set Information", style: TextStyles.bold16w500),
                SizedBox(height: 10),
                buildTextField("Name", controller: nameController),
                buildTextField("Phone", controller: phoneController),
                buildTextField("Age", controller: ageController),
                buildDropdownField(),
                buildTextField("Address", controller: addressController),
                buildTextField(
                  "Describe Your Problem (Optional)",
                  controller: descriptionController,
                  maxLines: 3,
                ),
                SizedBox(height: 120),
                CustomButtom(
                  text: state is BookAppointmentLoading ? "Loading..." : "Confirm",
                  onPressed: () {
                    final cubit = context.read<BookAppointmentCubit>();

                    cubit.bookAppointment(
                      doctorId: widget.doctorId, // 👈 استبدله بالمعرّف الفعلي للدكتور
                      appointmentDate: DateFormat('yyyy-MM-dd').format(widget.selectedDate),
                      appointmentTime: widget.selectedTime,
                      name: nameController.text,
                      phone: phoneController.text,
                      age: int.tryParse(ageController.text) ?? 0,
                      gender: _selectedGender ?? "male",
                      address: addressController.text,
                      problemDescription: descriptionController.text,
                    );
                  },
                  issized: true,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildTextField(String hint,
      {required TextEditingController controller, int maxLines = 1}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyles.bold16w500.copyWith(color: Color(0xff6D6565)),
            contentPadding: EdgeInsets.symmetric(vertical: 14, horizontal: 12),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget buildDropdownField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              spreadRadius: 2,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButtonFormField<String>(
            value: _selectedGender,
            isDense: true,
            icon: Transform.rotate(
              angle: 270 * (3.141592653589793 / 180),
              child: Icon(Icons.arrow_back_ios, color: Color(0xff134FA2)),
            ),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding:
                  EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            ),
            hint: Text("Gender"),
            items: _genders.map((String gender) {
              return DropdownMenuItem<String>(
                value: gender,
                child: Text(gender),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                _selectedGender = value;
              });
            },
          ),
        ),
      ),
    );
  }
}
