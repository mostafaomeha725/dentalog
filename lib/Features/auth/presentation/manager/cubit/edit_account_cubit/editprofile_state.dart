part of 'editprofile_cubit.dart';

abstract class EditprofileState extends Equatable {
  const EditprofileState();

  @override
  List<Object> get props => [];
}

class EditprofileInitial extends EditprofileState {}

class EditprofileLoading extends EditprofileState {}

class EditprofileSuccess extends EditprofileState {
  final Map<String, dynamic> profileData;

  const EditprofileSuccess(this.profileData);

  @override
  List<Object> get props => [profileData];
}

class EditprofileFailure extends EditprofileState {
  final String message;

  const EditprofileFailure(this.message);

  @override
  List<Object> get props => [message];
}
  