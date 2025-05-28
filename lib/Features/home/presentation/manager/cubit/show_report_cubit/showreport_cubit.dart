import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'showreport_state.dart';

class ShowreportCubit extends Cubit<ShowreportState> {
  ShowreportCubit() : super(ShowreportInitial());

  Future<void> fetchReportById(int reportId) async {
    emit(ShowreportLoading());

    final response = await ApiService().showReportById(reportId);

    response.fold(
      (failure) => emit(ShowreportFailure(errorMessage: failure.errMessage)),
      (data) {
        final reportData = data['data'];
        if (reportData != null && reportData is Map<String, dynamic>) {
          emit(ShowreportSuccess(reportData: reportData));
        } else {
          emit(ShowreportFailure(errorMessage: 'No report data found.'));
        }
      },
    );
  }
}
