import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart'; // تأكد من المسار الصحيح

part 'showhistory_state.dart';

class ShowhistoryCubit extends Cubit<ShowhistoryState> {
  ShowhistoryCubit() : super(ShowhistoryInitial());

  Future<void> fetchHistory() async {
    emit(ShowhistoryLoading());

    final response = await ApiService().showHistory();

    response.fold(
      (failure) => emit(ShowhistoryFailure(errorMessage: failure.errMessage)),
      (data) {
        final reports = data['data'];
        if (reports != null && reports is List) {
          emit(ShowhistorySuccess(reportsData: reports));
        } else {
          emit(ShowhistoryFailure(errorMessage: 'No report data found.'));
        }
      },
    );
  }
}
