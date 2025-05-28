
import 'package:dentalog/Features/home/presentation/manager/cubit/show_doctor_cubit/showdoctor_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Doctor_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorListView extends StatelessWidget {
  const DoctorListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowdoctorCubit, ShowdoctorState>(
      builder: (context, state) {
        if (state is ShowdoctorLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is ShowdoctorFailure) {
          return Center(child: Text("Error: ${state.errorMessage}"));
        } else if (state is ShowdoctorSuccess) {
  final doctors = state.doctorsData;
  if (doctors.isEmpty) {
    return Center(child: Text("No doctors available"));
  }

  return Expanded(
    child: ListView.builder(
      itemCount: doctors.length,
      itemBuilder: (context, index) {
        return DoctorCard(doctor: doctors[index]);
      },
    ),
  );
}
 else {
          return SizedBox.shrink();
        }
      },
    );
  }
}
