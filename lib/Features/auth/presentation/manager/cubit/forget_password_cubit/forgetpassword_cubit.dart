import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart';

part 'forgetpassword_state.dart';

class ForgetpasswordCubit extends Cubit<ForgetpasswordState> {
  ForgetpasswordCubit(this.apiService) : super(ForgetpasswordInitial());

  final ApiService apiService;

  Future<void> sendResetCode({required String phone}) async {
    emit(ForgetpasswordLoading());

    final result = await apiService.forgetPassword(phone: phone);

    result.fold(
      (failure) {
        emit(ForgetpasswordFailure(errMessage: failure.errMessage));
      },
      (code) {
        emit(ForgetpasswordSuccess(resetCode: code));
      },
    );
  }
}
