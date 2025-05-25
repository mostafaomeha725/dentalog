import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';

part 'signout_state.dart';

class SignoutCubit extends Cubit<SignoutState> {
  final ApiService apiService;
  final SharedPreference sharedPreference;

  SignoutCubit(this.apiService, this.sharedPreference) : super(SignoutInitial());

  Future<void> signOut() async {
    emit(SignoutLoading());

    final token = await sharedPreference.getToken();
    if (token == null) {
      emit(SignoutFailure("Token not found"));
      return;
    }

    final result = await apiService.logOutUser(
    );

    result.fold(
      (failure) {
        emit(SignoutFailure(failure.errMessage));
      },
      (data) async {
        await sharedPreference.clearAllData();
        emit(SignoutSuccess());
      },
    );
  }
}
