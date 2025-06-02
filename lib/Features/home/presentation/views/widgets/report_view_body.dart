import 'package:dentalog/Features/home/presentation/manager/cubit/show_report_cubit/showreport_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentalog/core/utiles/app_images.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ReportViewBody extends StatefulWidget {
  const ReportViewBody({super.key});

  @override
  State<ReportViewBody> createState() => _ReportViewBodyState();
}

class _ReportViewBodyState extends State<ReportViewBody> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowreportCubit, ShowreportState>(
      builder: (context, state) {
        if (state is ShowreportLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShowreportFailure) {
          return Center(child: Text(state.errorMessage));
        } else if (state is ShowreportSuccess) {
          final report = state.reportData;

          final patient = report['patient'];
          final doctor = report['doctor'];
          final medicines = report['medicines'] as List<dynamic>? ?? [];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: EdgeInsets.all(16),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildPatientInfoCard(patient, report['report_date']),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Diagnosis"),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        report['diagnosis'] ?? '',
                        style: TextStyles.bold12w400.copyWith(color: Color(0xff6D6565)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Advices"),
                    SizedBox(height: 6),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        report['advice'] ?? '',
                        style: TextStyles.bold12w400.copyWith(color: Color(0xff6D6565)),
                      ),
                    ),
                    const SizedBox(height: 26),
                    _buildSectionTitle("Medicines"),
                    const SizedBox(height: 12),
                    ...medicines.map((medicine) {
                      return _buildMedicineCard(
                        medicine['name'] ?? '',
                        medicine['dosage_instructions'] ?? '',
                      );
                    }).toList(),
                    const SizedBox(height: 16),
                    _buildDoctorInfo(context, doctor),
                  ],
                ),
              ),
            ),
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildPatientInfoCard(Map<String, dynamic>? patient, String? reportDate) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.blue),
      ),
      elevation: 4,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Patient Name:", style: TextStyles.bold12w500),
                    Text("Age:", style: TextStyles.bold12w500),
                    Text("Gender", style: TextStyles.bold12w500),
                    Text("Report Date:", style: TextStyles.bold12w500),
                  ],
                ),
                SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(patient?['name'] ?? '', style: TextStyles.bold12w500.copyWith(color: Color(0xff6D6565))),
                    Text(patient?['age'] ?? '', style: TextStyles.bold12w500.copyWith(color: Color(0xff6D6565))),
                    Text(patient?['gender'] ?? '', style: TextStyles.bold12w500.copyWith(color: Color(0xff6D6565))),
                    Text(reportDate ?? '', style: TextStyles.bold12w500.copyWith(color: Color(0xff6D6565))),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(12),
                bottomLeft: Radius.circular(12),
              ),
              child: Container(
                width: 50,
                height: 50,
                color: Color(0xff134FA2),
                child: Center(
                  child: SvgPicture.asset(Assets.assetsPlus),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyles.bold16w500);
  }

  Widget _buildMedicineCard(String name, String dosage) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double screenWidth = MediaQuery.of(context).size.width;
        double iconSize = screenWidth * 0.022;
        double titleFontSize = screenWidth * 0.035;
        double dosageFontSize = screenWidth * 0.022;

        return Card(
          color: const Color(0xffe6f7fd),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: screenWidth * 0.02,
              horizontal: screenWidth * 0.04,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Row(
                children: [
                  Icon(Icons.circle, size: iconSize, color: const Color(0xff134FA2)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      name,
                      style: TextStyles.bold12w400.copyWith(
                        fontSize: titleFontSize,
                        color: const Color(0xff134FA2),
                      ),
                    ),
                  ),
                  Text(
                    dosage,
                    style: TextStyles.bold9w400.copyWith(
                      fontSize: dosageFontSize,
                      color: const Color(0xff6D6565),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctorInfo(BuildContext context, Map<String, dynamic>? doctor) {
    print(doctor.toString());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.75,
          height: 1.3,
          color: Colors.black,
          margin: const EdgeInsets.symmetric(vertical: 8),
        ),
       
      ],
    );
  }
}
