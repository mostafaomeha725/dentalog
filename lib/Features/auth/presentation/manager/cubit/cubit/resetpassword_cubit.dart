import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:dentalog/core/services/api_service.dart';

part 'resetpassword_state.dart';

class ResetpasswordCubit extends Cubit<ResetpasswordState> {
  ResetpasswordCubit(this.apiService) : super(ResetpasswordInitial());

  final ApiService apiService;

  Future<void> resetPassword({
    required String phone,
    required String token,
    required String password,
  }) async {
    emit(ResetpasswordLoading());

    final result = await apiService.resetPassword(
      phone: phone,
      token: token,
      password: password,
    );

    result.fold(
      (failure) {
        emit(ResetpasswordFailure(errMessage: failure.errMessage));
      },
      (_) {
        emit(ResetpasswordSuccess());
      },
    );
  }
}
