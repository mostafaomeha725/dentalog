import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_specialties_cubit/show_specialties_cubit.dart';
import 'package:go_router/go_router.dart';

class AddSpecialities extends StatelessWidget {
  const AddSpecialities({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowSpecialtiesCubit, ShowSpecialtiesState>(
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

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: specialties.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = specialties[index];
              return GestureDetector(
                onTap: () {
                              GoRouter.of(context).push(
  AppRouter.kShowSpecialtiesDoctorView,
  extra: {
    'id': index + 2,
    'name': item['name'],
  },
);


                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue[50],
                      child: Image.network(
                        item["icon"] ?? '',
                        height: 30,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item["name"] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}





class AddSpecialitiesDoctor extends StatelessWidget {
  const AddSpecialitiesDoctor({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShowSpecialtiesCubit, ShowSpecialtiesState>(
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

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: specialties.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
            ),
            itemBuilder: (context, index) {
              final item = specialties[index];
              return GestureDetector(
                onTap: () {
                              GoRouter.of(context).push(
  AppRouter.kwaitingListview,
  
);


                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blue[50],
                      child: Image.network(
                        item["icon"] ?? '',
                        height: 30,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.broken_image),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      item["name"] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
