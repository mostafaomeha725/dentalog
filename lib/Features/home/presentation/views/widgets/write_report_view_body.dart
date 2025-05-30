import 'package:dentalog/Features/home/presentation/manager/cubit/rebort_creation_by_doctor_cubit/rebortcreationbydoctor_cubit.dart';
import 'package:dentalog/core/utiles/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class WriteReportViewBody extends StatefulWidget {
  final int appointmentId; // Pass appointmentId to submit

  const WriteReportViewBody({super.key, required this.appointmentId});

  @override
  State<WriteReportViewBody> createState() => _WriteReportViewBodyState();
}

class _WriteReportViewBodyState extends State<WriteReportViewBody> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _diagnosisController = TextEditingController();
  final TextEditingController _adviceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RebortcreationbydoctorCubit, RebortcreationbydoctorState>(
      listener: (context, state) {
        if (state is RebortcreationbydoctorSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Report submitted successfully")),
          );
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
                    ElevatedButton(
                      onPressed: state is RebortcreationbydoctorLoading
                          ? null
                          : () {
                              if (_formKey.currentState!.validate()) {
                                context.read<RebortcreationbydoctorCubit>().submitReport(
                                  appointmentId: widget.appointmentId,
                                  diagnosis: _diagnosisController.text,
                                  advice: _adviceController.text,
                                  medicines: [], // Add medicine data here
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
