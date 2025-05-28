
import 'package:dentalog/Features/home/presentation/views/widgets/waiting_list_card.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_specialties_cubit/show_specialties_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WaitingListViewBody extends StatefulWidget {
  const WaitingListViewBody({super.key});

  @override
  State<WaitingListViewBody> createState() => _WaitingListViewBodyState();
}

class _WaitingListViewBodyState extends State<WaitingListViewBody> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    context.read<ShowSpecialtiesCubit>().showSpecialties(); // جلب البيانات عند فتح الشاشة
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
                    itemCount: specialties.length,
                    itemBuilder: (context, index) {
                      final item = specialties[index];
                      final bool isSelected = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedIndex = index;
                          });

                        
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
          Text("Waiting",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 10),
WaitingListCard(),

        ],
      ),
    );
  }
}
