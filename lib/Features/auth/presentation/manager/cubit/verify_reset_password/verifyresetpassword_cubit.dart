import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dartz/dartz.dart';
import 'package:dentalog/core/services/api_service.dart';

part 'verifyresetpassword_state.dart';

class VerifyresetpasswordCubit extends Cubit<VerifyresetpasswordState> {
  VerifyresetpasswordCubit(this.apiService) : super(VerifyresetpasswordInitial());

  final ApiService apiService;

  Future<void> verifyResetCode({required String phone, required String code}) async {
    emit(VerifyresetpasswordLoading());

    final result = await apiService.verifyResetpasswordCode(phone: phone, code: code);

    result.fold(
      (failure) {
        emit(VerifyresetpasswordFailure(errMessage: failure.errMessage));
      },
      (resetToken) {
        emit(VerifyresetpasswordSuccess(resetToken: resetToken));
      },
    );
  }
}
