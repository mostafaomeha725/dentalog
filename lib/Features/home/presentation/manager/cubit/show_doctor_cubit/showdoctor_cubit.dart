import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'showdoctor_state.dart';

class ShowdoctorCubit extends Cubit<ShowdoctorState> {
  ShowdoctorCubit() : super(ShowdoctorInitial());

 Future<void> fetchDoctors() async {
  emit(ShowdoctorLoading());

  final response = await ApiService().showdoctors();

  response.fold(
    (failure) => emit(ShowdoctorFailure(errorMessage: failure.errMessage)),
    (data) {
      final doctorsList = data['data']['doctors'];
      if (doctorsList != null && doctorsList is List) {
        emit(ShowdoctorSuccess(doctorsData: doctorsList));
      } else {
        emit(ShowdoctorFailure(errorMessage: 'No doctors data found.'));
      }
    },
  );
}

}
