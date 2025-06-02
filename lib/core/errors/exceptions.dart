import 'package:dio/dio.dart';

class Failure {
  final String errMessage;

  const Failure(this.errMessage);
}

class ServerFailure extends Failure {
  ServerFailure(super.errMessage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.connectionTimeout:
        return ServerFailure('Connection timeout');
      case DioErrorType.sendTimeout:
        return ServerFailure('Send timeout');
      case DioErrorType.receiveTimeout:
        return ServerFailure('Receive timeout');
      case DioErrorType.badResponse:
        return ServerFailure.fromResponse(
          dioError.response?.statusCode,
          dioError.response?.data,
        );
      case DioErrorType.cancel:
        return ServerFailure('Request was cancelled');
      case DioErrorType.unknown:
        if (dioError.message?.contains('SocketException') ?? false) {
          return ServerFailure('No internet connection');
        }
        return ServerFailure('Unexpected error occurred, please try again');
      default:
        return ServerFailure('An error occurred, please try again');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 422) {
      final errors = response['errors'] as Map<String, dynamic>?;
      if (errors != null && errors.isNotEmpty) {
        final allMessages = errors.entries.map((entry) {
          final messages = entry.value as List<dynamic>;
          return messages.map((msg) => msg.toString()).join(' - ');
        }).join('\n');
        return ServerFailure(allMessages);
      }
      return ServerFailure(response['message'] ?? 'Invalid data');
    }

    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['message'] ?? 'Unauthorized request');
    } else if (statusCode == 404) {
      return ServerFailure('Requested page not found');
    } else if (statusCode == 500) {
      return ServerFailure(response['message'] ?? 'Internal server error');
    } else {
      return ServerFailure('An error occurred, please try again');
    }
  }
}
