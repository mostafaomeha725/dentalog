import 'package:dentalog/Features/home/presentation/manager/cubit/waiting_list_cubit/waitinglist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dentalog/Features/home/presentation/views/widgets/waiting_card.dart';
import 'package:dentalog/core/utiles/app_images.dart';

class WaitingListCard extends StatefulWidget {
  const WaitingListCard({super.key});

  @override
  State<WaitingListCard> createState() => _WaitingListCardState();
}

class _WaitingListCardState extends State<WaitingListCard> {
  @override
  void initState() {
    super.initState();
    context.read<WaitinglistCubit>().fetchWaitingList();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<WaitinglistCubit, WaitinglistState>(
        builder: (context, state) {
          if (state is WaitinglistLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is WaitinglistFailure) {
            return Center(child: Text(state.errorMessage));
          } else if (state is WaitinglistSuccess) {
            final appointments = state.waitingData;

            return ListView.builder(
              itemCount: appointments.length,
              itemBuilder: (context, index) {
                final appointment = appointments[index];

                final datePart = appointment['appointment_date'];
                final timePart = appointment['appointment_time'];

                final parsedDate = DateTime.parse(datePart);
                final timeParts = timePart.split(':');
                final hours = int.parse(timeParts[0]);
                final minutes = int.parse(timeParts[1]);

                final dateTime = DateTime(
                  parsedDate.year,
                  parsedDate.month,
                  parsedDate.day,
                  hours,
                  minutes,
                );

                return WaitingCard(
                  doctorName: appointment['user']['name'],
                  phoneNumber: appointment['user']['phone'],
                  image: appointment['user']['image'] ?? Assets.assetsDentist,
                  dateTime: dateTime,
                  status: appointment['status'],
                );
              },
            );
          } else {
            return const SizedBox(); // initial or unknown state
          }
        },
      ),
    );
  }
}
