import 'package:bloc/bloc.dart';
import 'package:dentalog/Features/auth/presentation/manager/cubit/profile_cubit/profile_cubit.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/services/api_service.dart';

part 'signin_state.dart';

class SigninCubit extends Cubit<SignInState> {
  SigninCubit(this.apiService, this.profileCubit, this.sharedPreference)
      : super(SignInInitial());

  final ApiService apiService;
  final ProfileCubit profileCubit;
  final SharedPreference sharedPreference;

  Future<void> signInUser({
    required String phone,
    required String password,
  }) async {
    emit(SignInLoading());

    final result = await apiService.signInUser(
      password: password,
      phone: phone,
    );

    result.fold(
      (failure) => emit(SignInFailure(errMessage: failure.errMessage)),
      (signInModel) async {
        await sharedPreference.clearProfileCache();
        await sharedPreference.removeToken();
        await sharedPreference.saveToken(signInModel.token);

        await sharedPreference.saveProfileData(signInModel.fullUserData);

        emit(SignInSuccess(token: signInModel.token));
      },
    );
  }
}
