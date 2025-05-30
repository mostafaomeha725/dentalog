import 'package:dentalog/Features/home/presentation/manager/cubit/show_Specialties_by_id_cubit/show_specialtiesbyid_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_doctor_cubit/showdoctor_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/show_specialties_doctor_view.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/Doctor_card.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/show_specialties_doctor_view_body.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_specialties_cubit/show_specialties_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DoctorViewBody extends StatefulWidget {
  const DoctorViewBody({super.key});

  @override
  State<DoctorViewBody> createState() => _DoctorViewBodyState();
}

class _DoctorViewBodyState extends State<DoctorViewBody> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ShowSpecialtiesCubit>().showSpecialties();
    context.read<ShowdoctorCubit>().fetchDoctors(); // إحضار كل الأطباء مبدئياً
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Text("Departments", style: TextStyles.bold18w500),
          const SizedBox(height: 32),

          BlocConsumer<ShowSpecialtiesCubit, ShowSpecialtiesState>(
            listener: (context, state) {
              if (state is ShowSpecialtiesFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('فشل في جلب التخصصات: ${state.message}')),
                );
              }
            },
            builder: (context, state) {
              if (state is ShowSpecialtiesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ShowSpecialtiesSuccess) {
                final specialties = state.data[ApiKey.data] as List<dynamic>;

                return SizedBox(
                  height: 80,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: specialties.length + 1,
                    itemBuilder: (context, index) {
                      final bool isSelected = selectedIndex == index;

                      // خانة All
                      if (index == 0) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = 0;
                            });
                            context.read<ShowdoctorCubit>().fetchDoctors();
                          },
                          child: Container(
                            width: 70,
                            height: 80,
                            margin: const EdgeInsets.only(right: 16),
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              color: isSelected ? const Color(0xff134FA2) : Colors.blue[50],
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "All",
                                textAlign: TextAlign.center,
                                style: TextStyles.bold18w600.copyWith(
                                  color: isSelected ? Colors.white : Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                          ),
                        );
                      }

                      final item = specialties[index - 1];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });
                          context
                              .read<ShowSpecialtiesbyidCubit>()
                              .getSpecialtiesById(index+1);
                        },
                        child: Container(
                          width: 70,
                          height: 80,
                          margin: const EdgeInsets.only(right: 16),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: isSelected ? const Color(0xff134FA2) : Colors.blue[50],
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: item["icon"] == null
                                ? Text(
                                    item["name"] ?? '',
                                    textAlign: TextAlign.center,
                                    style: TextStyles.bold18w600.copyWith(
                                      color: isSelected ? Colors.white : Colors.black,
                                      fontSize: 12,
                                    ),
                                  )
                                : Image.network(
                                    item["icon"],
                                    width: 30,
                                    height: 30,
                                    errorBuilder: (context, error, stackTrace) =>
                                        const Icon(Icons.broken_image),
                                  ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),

          const SizedBox(height: 30),
          Text("All Doctors", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),

          // BlocConsumer لعرض الأطباء حسب التخصص أو الكل
          selectedIndex == 0
              ? BlocBuilder<ShowdoctorCubit, ShowdoctorState>(
                  builder: (context, state) {
                    if (state is ShowdoctorLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ShowdoctorSuccess) {
                      final doctors = state.doctorsData;
                      return DoctorListView();
                    } else if (state is ShowdoctorFailure) {
                      return Center(child: Text("فشل في جلب الأطباء: ${state.errorMessage}"));
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                )
              : Expanded(
                child: ShowSpecialtiesDoctorViewBody(id:3, name: 'name'))
        ],
      ),
    );
  }
}


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
