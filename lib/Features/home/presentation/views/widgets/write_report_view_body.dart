import 'package:dentalog/Features/home/presentation/manager/cubit/rebort_creation_by_doctor_cubit/rebortcreationbydoctor_cubit.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/medicine_cubit/medicine_cubit.dart';
import 'package:dentalog/core/app_router/app_router.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class WriteReportViewBody extends StatefulWidget {
  final int appointmentId;

  const WriteReportViewBody({super.key, required this.appointmentId});

  @override
  State<WriteReportViewBody> createState() => _WriteReportViewBodyState();
}

class _WriteReportViewBodyState extends State<WriteReportViewBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _adviceController = TextEditingController();

  String? selectedMedicine;
  List<dynamic> allMedicines = [];
  List<Map<String, String>> addedMedicines = [];

  @override
  void initState() {
    super.initState();
    context.read<MedicineCubit>().fetchMedicines();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RebortcreationbydoctorCubit, RebortcreationbydoctorState>(
      listener: (context, state) {
        if (state is RebortcreationbydoctorSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Report submitted successfully")),
          );
          GoRouter.of(context).push(AppRouter.kDocrtorHomeView);
        } else if (state is RebortcreationbydoctorFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      builder: (context, state) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.15),
                      blurRadius: 6,
                      spreadRadius: 2,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionTitle("Diagnosis"),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      controller: _diagnosisController,
                      hintText: 'Enter diagnosis...',
                      maxLines: 4,
                      validator: (value) =>
                          value!.isEmpty ? 'Diagnosis is required' : null,
                    ),
                    const SizedBox(height: 16),
                    _buildSectionTitle("Advices"),
                    const SizedBox(height: 8),
                    CustomTextFormField(
                      controller: _adviceController,
                      hintText: 'Enter advice...',
                      maxLines: 4,
                      validator: (value) =>
                          value!.isEmpty ? 'Advice is required' : null,
                    ),
                    const SizedBox(height: 20),
                    _buildSectionTitle("Medicines"),
                    const SizedBox(height: 8),
                    BlocBuilder<MedicineCubit, MedicineState>(
                      builder: (context, medState) {
                        if (medState is MedicineLoading) {
                          return const Center(child: CircularProgressIndicator());
                        } else if (medState is MedicineSuccess) {
                          allMedicines = medState.medicines;
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DropdownButton<String>(
                                isExpanded: true,
                                hint: const Text("Select Medicine"),
                                value: selectedMedicine,
                                items: allMedicines.map<DropdownMenuItem<String>>((medicine) {
                                  return DropdownMenuItem<String>(
                                    value: medicine['name'],
                                    child: Text(medicine['name']),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    selectedMedicine = value;
                                    final selected = allMedicines.firstWhere(
                                      (med) => med['name'] == value,
                                      orElse: () => {},
                                    );

                                    bool alreadyAdded = addedMedicines.any(
                                      (med) => med['medicine_id'] == selected['id'].toString(),
                                    );

                                    if (!alreadyAdded) {
                                      addedMedicines.add({
                                        'medicine_id': selected['id'].toString(),
                                        'dosage_instructions': selected['prescription_instructions'] ?? '',
                                      });
                                    }
                                  });
                                },
                              ),
                              const SizedBox(height: 10),
                              ...addedMedicines.map((medicine) {
                                final medicineName = allMedicines.firstWhere(
                                  (m) => m['id'].toString() == medicine['medicine_id'],
                                  orElse: () => {'name': 'Unknown'},
                                )['name'];

                                return ListTile(
                                  title: Text(medicineName),
                                  subtitle: Text(medicine['dosage_instructions'] ?? ''),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                    onPressed: () {
                                      setState(() {
                                        addedMedicines.remove(medicine);
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ],
                          );
                        } else if (medState is MedicineFailure) {
                          return Text("Error: ${medState.errorMessage}");
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: state is RebortcreationbydoctorLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RebortcreationbydoctorCubit>().submitReport(
                                  appointmentId: widget.appointmentId,
                                  diagnosis: _diagnosisController.text,
                                  advice: _adviceController.text,
                                  medicines: addedMedicines,
                                );
                              }
                            },
                      child: state is RebortcreationbydoctorLoading
                          ? const CircularProgressIndicator()
                          : const Text("Submit Report"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(title, style: TextStyles.bold16w500);
  }
}


class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final int maxLines;
  final TextInputType keyboardType;
  final bool enabled;

  const CustomTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxLines,
      keyboardType: keyboardType,
      enabled: enabled,
      style: const TextStyle(fontSize: 14, color: Colors.black),
      decoration: InputDecoration(
        hintText: hintText,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
