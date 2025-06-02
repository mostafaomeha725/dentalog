import 'package:dentalog/Features/home/presentation/manager/cubit/show_Specialties_by_id_cubit/show_specialtiesbyid_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Doctor_card.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShowSpecialtiesDoctorViewBody extends StatefulWidget {
  const ShowSpecialtiesDoctorViewBody({super.key, required this.id, required this.name,  this.istrue=false});
final int id ;
final String name ;
final bool istrue;
  @override
  State<ShowSpecialtiesDoctorViewBody> createState() => _ShowSpecialtiesDoctorViewBodyState();
}

class _ShowSpecialtiesDoctorViewBodyState extends State<ShowSpecialtiesDoctorViewBody> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ShowSpecialtiesbyidCubit>().getSpecialtiesById(widget.id); // تحميل البيانات
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
     
    
     widget. istrue?  Column(
          children: [
            const SizedBox(height: 30),
            Text("All Doctors ${widget.name}", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
          ],
        ):SizedBox(),
    
        Expanded(
          child: BlocBuilder<ShowSpecialtiesbyidCubit, ShowSpecialtiesbyidState>(
            builder: (context, state) {
              if (state is ShowSpecialtiesbyidLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShowSpecialtiesbyidFailure) {
                return Center(child: Text("Error: ${state.error}"));
              } else if (state is ShowSpecialtiesbyidSuccess) {
                // ✅ استخدام المفتاح الصحيح داخل "data"
                final doctors = (state.data['data']?['doctors'] ?? []) as List<dynamic>;
    
                if (doctors.isEmpty) {
                  return const Center(child: Text("No doctors available"));
                }
    
                return ListView.builder(
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return DoctorCard (doctor: doctors[index],istrue: false,);
                  },
                );
              } else {
                return const Center(child: Text("Please select a department"));
              }
            },
          ),
        ),
      ],
    );
  }
}
