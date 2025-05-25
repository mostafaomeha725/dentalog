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
    final result = await apiService.getProfileData(); // No ID

    result.fold(
      (failure) => emit(ProfileFailure(errMessage: failure.errMessage)),
      (data) async {
        final user = data['data']; // API returns user data inside 'data'
        await sharedPreference.saveProfileData(user);
        emit(ProfileSuccess(profileData: user));
      },
    );
  }
}
}

















//   import 'package:bloc/bloc.dart';
// import 'package:dentalog/Features/auth/data/models/user_model.dart';
// import 'package:dentalog/core/api/end_ponits.dart';
// import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
// import 'package:dentalog/core/services/api_service.dart';
// import 'package:equatable/equatable.dart';

// part 'profile_state.dart';

// class ProfileCubit extends Cubit<ProfileState> {
//   ProfileCubit(this.apiService, this.sharedPreference) : super(ProfileInitial());

//   final ApiService apiService;
//   final SharedPreference sharedPreference;

//   Future<void> getProfile() async {
//     emit(ProfileLoading());

//     final profileData = await sharedPreference.getProfileData();

//     if (profileData != null) {
//       emit(ProfileSuccess(profileData: profileData));
//     } else {
//       final id = await sharedPreference.getUser(ApiKey.id);

//       final result = await apiService.getProfileData(id: id!);

//       result.fold(
//         (failure) => emit(ProfileFailure(errMessage: failure.errMessage)),
//         (data) async {
//           final user = data['user'];
//           await sharedPreference.saveProfileData(user); 
//           emit(ProfileSuccess(profileData: user)); 
//         },
//       );
//     }
//   }
// }



