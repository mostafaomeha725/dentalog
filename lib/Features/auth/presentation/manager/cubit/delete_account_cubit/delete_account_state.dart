part of 'delete_account_cubit.dart';

abstract class DeleteAccountState extends Equatable {
  const DeleteAccountState();

  @override
  List<Object> get props => [];
}

class DeleteAccountInitial extends DeleteAccountState {}

class DeleteAccountLoading extends DeleteAccountState {}

class DeleteAccountSuccess extends DeleteAccountState {
  final Map<String, dynamic> response;

  const DeleteAccountSuccess(this.response);

  @override
  List<Object> get props => [response];
}

class DeleteAccountFailure extends DeleteAccountState {
  final String message;

  const DeleteAccountFailure(this.message);

  @override
  List<Object> get props => [message];
}
