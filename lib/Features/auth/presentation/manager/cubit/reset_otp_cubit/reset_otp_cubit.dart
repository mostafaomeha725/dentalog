import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'reset_otp_state.dart';

class ResetOtpCubit extends Cubit<ResetOtpState> {
  ResetOtpCubit(this.apiService) : super(ResetOtpInitial());

  final ApiService apiService;

  Future<void> resetOtp({
    required String email,
  }) async {
    emit(ResetOtpLoading());

    final result = await apiService.resetOtp(
      email: email,
    );

    result.fold(
      (failure) {
        emit(ResetOtpFailure(errMessage: failure.errMessage));
      },
      (message) {
        emit(ResetOtpSuccess(message: message));
      },
    );
  }
}
