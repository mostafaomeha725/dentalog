import 'package:bloc/bloc.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'delete_account_state.dart';

class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this.apiService, this.sharedPreference) : super(DeleteAccountInitial());

  final ApiService apiService;
  final SharedPreference sharedPreference;

  Future<void> deleteAccount({required String password}) async {
    emit(DeleteAccountLoading());

    final result = await apiService.deleteAccount(password: password);

    result.fold(
      (failure) => emit(DeleteAccountFailure(failure.errMessage)),
      (data) async {
        await sharedPreference.clearAllData();
        emit(DeleteAccountSuccess(data));
      },
    );
  }
}
