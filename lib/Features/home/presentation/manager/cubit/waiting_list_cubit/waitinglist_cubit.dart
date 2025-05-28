import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart';

part 'waitinglist_state.dart';

class WaitinglistCubit extends Cubit<WaitinglistState> {
  WaitinglistCubit() : super(WaitinglistInitial());

  Future<void> fetchWaitingList() async {
    emit(WaitinglistLoading());

    final response = await ApiService().showWaitingAppointments();

    response.fold(
      (failure) =>
          emit(WaitinglistFailure(errorMessage: failure.errMessage)),
      (data) {
        final waitingList = data['data']?['data'];
        if (waitingList != null && waitingList is List) {
          emit(WaitinglistSuccess(waitingData: waitingList));
        } else {
          emit(WaitinglistFailure(errorMessage: 'No waiting list data found.'));
        }
      },
    );
  }
}
