part of 'showreport_cubit.dart';

abstract class ShowreportState extends Equatable {
  const ShowreportState();

  @override
  List<Object> get props => [];
}

class ShowreportInitial extends ShowreportState {}

class ShowreportLoading extends ShowreportState {}

class ShowreportSuccess extends ShowreportState {
  final Map<String, dynamic> reportData;

  const ShowreportSuccess({required this.reportData});

  @override
  List<Object> get props => [reportData];
}

class ShowreportFailure extends ShowreportState {
  final String errorMessage;

  const ShowreportFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
