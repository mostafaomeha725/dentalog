import 'package:bloc/bloc.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignUpState> {
  SignupCubit(this.apiService, this.sharedPreference) : super(SignUpInitial());

  final ApiService apiService;
  final SharedPreference sharedPreference ;

  Future<void> registerUser({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String user,
  }) async {
    emit(SignUpLoading());

    try {
      final result = await apiService.signUpUser(
        name: name,
        email: email,
        mobile: mobile,
        password: password,
        type: user,
      );

      result.fold(
        (failure) => emit(SignUpFailure(errMessage: failure.errMessage)),
        (_) async { 
           await sharedPreference.clearProfileCache();


        // ✅ حفظ بيانات المستخدم
          emit(SignUpSuccess(email: email, password: password),);}
      );
    } catch (e) {
      emit(SignUpFailure(errMessage: "An unexpected error occurred"));
    }
  }
}
  