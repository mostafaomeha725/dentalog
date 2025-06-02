part of 'notification_cubit.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object?> get props => [];
}

class NotificationInitial extends NotificationState {}

class NotificationLoading extends NotificationState {}

class NotificationSuccess extends NotificationState {
  final List<dynamic> notificationsData;

  const NotificationSuccess({required this.notificationsData});

  @override
  List<Object?> get props => [notificationsData];
}

class NotificationFailure extends NotificationState {
  final String errorMessage;

  const NotificationFailure({required this.errorMessage});

  @override
  List<Object?> get props => [errorMessage];
}
