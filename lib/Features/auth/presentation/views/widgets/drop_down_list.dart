import 'package:dentalog/Features/home/presentation/manager/cubit/show_specialties_cubit/show_specialties_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialtiesDropdown extends StatefulWidget {
  const SpecialtiesDropdown({Key? key}) : super(key: key);

  @override
  _SpecialtiesDropdownState createState() => _SpecialtiesDropdownState();
}

class _SpecialtiesDropdownState extends State<SpecialtiesDropdown> {
  int? selectedSpecialtyId;

  @override
  void initState() {
    super.initState();
    context.read<ShowSpecialtiesCubit>().showSpecialties();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowSpecialtiesCubit, ShowSpecialtiesState>(
      builder: (context, state) {
        if (state is ShowSpecialtiesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShowSpecialtiesFailure) {
          return Center(child: Text("Error: ${state.message}"));
        } else if (state is ShowSpecialtiesSuccess) {
          final Map<String, dynamic> response = state.data as Map<String, dynamic>;
          final List<dynamic> rawSpecialties = response['data'] as List<dynamic>;
          final List<Specialty> specialties = rawSpecialties
              .map((json) => Specialty.fromJson(json as Map<String, dynamic>))
              .toList();

          if (specialties.isEmpty) {
            return const Text("No specialties available");
          }

          return DropdownButtonFormField<int>(
            hint: Row(
              children: const [
                Icon(Icons.medical_services),
                SizedBox(width: 8),
                Text('Select Specialty'),
              ],
            ),
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Color(0xff134FA2),
                  width: 1.5,
                ),
              ),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              filled: true,
              fillColor: Colors.white,
            ),
            value: selectedSpecialtyId,
            items: specialties.map((specialty) {
              return DropdownMenuItem<int>(
                value: specialty.id,
                child: Row(
                  children: [
                    // لو الايقونة موجودة، عرضها كصورة صغيرة بجانب الاسم
                    if (specialty.icon.isNotEmpty)
                      Image.network(
                        specialty.icon,
                        width: 24,
                        height: 24,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(Icons.medical_services, size: 24);
                        },
                      )
                    else
                      const Icon(Icons.medical_services, size: 24),
                    const SizedBox(width: 8),
                    Text(specialty.name),
                  ],
                ),
              );
            }).toList(),
            onChanged: (value) {
              setState(() {
                selectedSpecialtyId = value;
              });
            },
            validator: (value) =>
                value == null ? "Please select a specialty" : null,
          );
        }

        return Container();
      },
    );
  }
}

class Specialty {
  final int id;
  final String name;
  final String icon;

  Specialty({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return Specialty(
      id: json['id'],
      name: json['name'],
      icon: json['icon'] ?? '',
    );
  }
}
