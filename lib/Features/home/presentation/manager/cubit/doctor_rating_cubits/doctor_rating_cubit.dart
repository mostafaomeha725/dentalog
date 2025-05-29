import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';


part 'doctor_rating_state.dart';

class DoctorRatingCubit extends Cubit<DoctorRatingState> {
  DoctorRatingCubit() : super(DoctorRatingInitial());

  Future<void> submitDoctorRating({
    required int doctorId,
    required int rating,
    required String review,
  }) async {
    emit(DoctorRatingLoading());

    final response = await ApiService().submitDoctorRating(
      doctorId: doctorId,
      rating: rating,
      review: review,
    );

    response.fold(
      (failure) => emit(DoctorRatingFailure(failure.errMessage)),
      (data) => emit(DoctorRatingSuccess(data)),
    );
  }
}
