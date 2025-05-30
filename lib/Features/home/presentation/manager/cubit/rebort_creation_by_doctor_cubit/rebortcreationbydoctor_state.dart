part of 'rebortcreationbydoctor_cubit.dart';

sealed class RebortcreationbydoctorState extends Equatable {
  const RebortcreationbydoctorState();

  @override
  List<Object> get props => [];
}

final class RebortcreationbydoctorInitial extends RebortcreationbydoctorState {}

final class RebortcreationbydoctorLoading extends RebortcreationbydoctorState {}

final class RebortcreationbydoctorSuccess extends RebortcreationbydoctorState {
  final Map<String, dynamic> data;

  const RebortcreationbydoctorSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class RebortcreationbydoctorFailure extends RebortcreationbydoctorState {
  final String error;

  const RebortcreationbydoctorFailure(this.error);

  @override
  List<Object> get props => [error];
}
