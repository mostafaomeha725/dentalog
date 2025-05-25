import 'package:bloc/bloc.dart';
import 'package:dentalog/core/services/api_service.dart';
import 'package:equatable/equatable.dart';

part 'editprofile_state.dart';

class EditprofileCubit extends Cubit<EditprofileState> {
  final ApiService apiService;

  EditprofileCubit(this.apiService) : super(EditprofileInitial());

  Future<void> editProfile({
    required String id,
    required String name,
    required String email,
    required String phone,
    required String password,
    required String role,
  }) async {
    emit(EditprofileLoading());

    final result = await apiService.editProfileUser(
      id: id,
      name: name,
      email: email,
      phone: phone,
      password: password,
      role: role,
    );

    result.fold(
      (failure) => emit(EditprofileFailure(failure.errMessage)),
      (userData) => emit(EditprofileSuccess(userData)),
    );
  }
}
