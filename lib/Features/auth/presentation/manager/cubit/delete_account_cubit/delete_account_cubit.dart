import 'package:bloc/bloc.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'delete_account_state.dart';


class DeleteAccountCubit extends Cubit<DeleteAccountState> {
  DeleteAccountCubit(this.apiService, this.sharedPreference) : super(DeleteAccountInitial());
final  ApiService apiService ;
final SharedPreference sharedPreference ;
  Future<void> deleteAccount(int id) async {
    emit(DeleteAccountLoading());

    final result = await apiService.deleteAccount(id: id);

    result.fold(
      (failure) => emit(DeleteAccountFailure(failure.errMessage)),
      (data)  {
        sharedPreference.clearAllData();
         

        emit(DeleteAccountSuccess(data));},
    );
  }
}
