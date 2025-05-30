  import 'package:bloc/bloc.dart';

  import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
  import 'package:dentalog/core/services/api_service.dart';
  import 'package:equatable/equatable.dart';

  part 'profile_state.dart';

  class ProfileCubit extends Cubit<ProfileState> {
    ProfileCubit(this.apiService, this.sharedPreference) : super(ProfileInitial());
      final ApiService apiService;
    final SharedPreference sharedPreference;
   Future<void> getProfile() async {
  emit(ProfileLoading());

  final profileData = await sharedPreference.getProfileData();

  if (profileData != null) {
    emit(ProfileSuccess(profileData: profileData));
  } else {
    final result = await apiService.getProfileData();

    result.fold(
      (failure) => emit(ProfileFailure(errMessage: failure.errMessage)),
      (data) async {
        final user = data['data'];

        // حفظ بيانات البروفايل
        await sharedPreference.saveProfileData(user);

        // ✅ حفظ الدور في SharedPreferences
        await sharedPreference.saveRole(user['role']);

        emit(ProfileSuccess(profileData: user));
      },
    );
  }
}
  }









