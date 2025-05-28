import 'package:dentalog/Features/home/presentation/manager/cubit/show_history_cubit/showhistory_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/build_report_card.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryViewBody extends StatelessWidget {
  const   HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: BlocBuilder<ShowhistoryCubit, ShowhistoryState>(
              builder: (context, state) {
                if (state is ShowhistoryLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShowhistoryFailure) {
                  return Center(child: Text(state.errorMessage));
                } else if (state is ShowhistorySuccess) {
                  final reports = state.reportsData;

                  return ListView.separated(
                    itemCount: reports.length,
                    separatorBuilder: (context, index) {
                      if (reports[index]['is_new'] == true) {
                        return buildDivider(screenWidth);
                      }
                      return const SizedBox(height: 8);
                    },
                    itemBuilder: (context, index) {
                      final report = reports[index];
                      return BuildReportCard(
                        id: report['id'],
                        doctor: report['doctor_name'] ?? 'Unknown Doctor',
                        title: report['message'] ?? '',
                        time: report['time_elapsed'] ?? '',
                        image: Assets.assetsDrKareem, // يمكن ربطه ديناميكياً لاحقاً
                        isNew: report['is_new'] ?? false,
                      );
                    },
                  );
                } else {
                  // الحالة الابتدائية، تشغيل الكيوبت هنا:
                  context.read<ShowhistoryCubit>().fetchHistory();
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDivider(double screenWidth) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: screenWidth * 0.05,
            endIndent: screenWidth * 0.02,
          ),
        ),
        Text(
          "New",
          style: TextStyles.bold10w300.copyWith(color: Colors.grey),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 1,
            indent: screenWidth * 0.02,
            endIndent: screenWidth * 0.05,
          ),
        ),
      ],
    );
  }
}
