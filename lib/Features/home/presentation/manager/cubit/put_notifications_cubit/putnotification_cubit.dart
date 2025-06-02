import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart'; // Adjust path as needed

part 'putnotification_state.dart';

class PutnotificationCubit extends Cubit<PutnotificationState> {
  PutnotificationCubit() : super(PutnotificationInitial());

  Future<void> markAsRead(int notificationId) async {
    emit(PutnotificationLoading());

    final response = await ApiService().markNotificationAsRead(notificationId);

    response.fold(
      (failure) => emit(PutnotificationFailure(errorMessage: failure.errMessage)),
      (data) => emit(PutnotificationSuccess(responseData: data)),
    );
  }
}
