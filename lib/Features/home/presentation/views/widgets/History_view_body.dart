import 'package:dentalog/Features/home/presentation/manager/cubit/show_history_cubit/showhistory_cubit.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/build_report_card.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

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
                  final allReports = List<Map<String, dynamic>>.from(state.reportsData);

                  final newReports = allReports.where((e) => e['is_new'] == true).toList();
                  final oldReports = allReports.where((e) => e['is_new'] != true).toList();

                  newReports.sort((a, b) {
                    final dateA = DateTime.tryParse(a['created_at'] ?? '') ?? DateTime(2000);
                    final dateB = DateTime.tryParse(b['created_at'] ?? '') ?? DateTime(2000);
                    return dateB.compareTo(dateA);
                  });

                  oldReports.sort((a, b) {
                    final dateA = DateTime.tryParse(a['created_at'] ?? '') ?? DateTime(2000);
                    final dateB = DateTime.tryParse(b['created_at'] ?? '') ?? DateTime(2000);
                    return dateB.compareTo(dateA);
                  });

                  return ListView(
                    children: [
                      ...newReports.map((report) => Column(
                            children: [
                              BuildReportCard(
                                id: report['id'],
                                doctor: report['doctor_name'] ?? 'Unknown Doctor',
                                title: report['message'] ?? '',
                                time: getTimeOrDate(report),
                                image: report['doctor_image'] ?? '', // ✅ Use image from API
                                isNew: report['is_new'] ?? false,
                              ),
                              const SizedBox(height: 8),
                            ],
                          )),

                      if (newReports.isNotEmpty) buildDivider(screenWidth),

                      ...oldReports.map((report) => Column(
                            children: [
                              BuildReportCard(
                                id: report['id'],
                                doctor: report['doctor_name'] ?? 'Unknown Doctor',
                                title: report['message'] ?? '',
                                time: getTimeOrDate(report),
                                image: report['doctor_image'] ?? '', // ✅
                                isNew: report['is_new'] ?? false,
                              ),
                              const SizedBox(height: 8),
                            ],
                          )),
                    ],
                  );
                } else {
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

  String getTimeOrDate(Map<String, dynamic> report) {
    final createdAt = DateTime.tryParse(report['created_at'] ?? '') ?? DateTime(2000);
    final now = DateTime.now();
    final diff = now.difference(createdAt);

    if (diff.inHours >= 24) {
      return report['report_date'] ?? '';
    } else {
      return report['time_elapsed'] ?? '';
    }
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
