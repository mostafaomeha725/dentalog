import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart'; // تأكد من صحة المسار

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationInitial());

  Future<void> fetchNotifications() async {
    emit(NotificationLoading());

    final response = await ApiService().getNotifications(); // تأكد من أن الدالة موجودة في ApiService

    response.fold(
      (failure) => emit(NotificationFailure(errorMessage: failure.errMessage)),
      (data) {
        final notifications = data['data'];
        if (notifications != null && notifications is List) {
          emit(NotificationSuccess(notificationsData: notifications));
        } else {
          emit(NotificationFailure(errorMessage: 'No notification data found.'));
        }
      },
    );
  }
}
