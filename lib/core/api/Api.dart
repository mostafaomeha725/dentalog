
import 'package:dartz/dartz.dart';
import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/core/errors/exceptions.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';

class Api {
  final Dio dio = Dio();

  Future<Either<Failure, Map<String, dynamic>>> get({
    required String name,
    String? errMessage,
    String? id ,
    bool withAuth = false,
  }) async {
    try {
      Options? options;

      if (withAuth) {
        String? token = await SharedPreference().getToken();
        if (token == null) {
          return Left(ServerFailure('No token found'));
        }

        options = Options(
          headers: {
           'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        );
      }

      final response = await dio.get(
        '${EndPoint.baseUrl}$name',
        options: options,
      );

      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        final errorMessage =
            response.data[ApiKey.message] ?? errMessage ?? 'Request failed';
        return Left(ServerFailure(errorMessage));
      }
    // ignore: deprecated_member_use
    } on DioError catch (e) {
      return Left(ServerFailure.fromDioError(e));
    } catch (e) {
      return Left(ServerFailure('An unexpected error occurred'));
    }
  }

  
  

 Future<Either<Failure, Map<String, dynamic>>> post({
  required String name,
  Map<String, dynamic>? body,
  String? errMessage,
  bool withAuth = false,
}) async {
  try {
    Options? options;

    if (withAuth) {
      String? token = await SharedPreference().getToken();
      if (token == null) return Left(ServerFailure('No token found'));
      options = Options(
        headers: {
           'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
        validateStatus: (status) => status != null && status < 500,
      );
    }

    final response = await dio.post(
      '${EndPoint.baseUrl}$name',
      data: body,
      options: options,
    );

    if (response.statusCode == 200||response.statusCode == 201) {
      return Right(response.data);
    }

    final errorMessage = response.data is Map && response.data.containsKey('message')
        ? response.data['message'].toString()
        : errMessage ?? 'Request failed';

    return Left(ServerFailure(errorMessage));
  } on DioError catch (e) {
    return Left(ServerFailure.fromDioError(e));
  } catch (e) {
    return Left(ServerFailure('An unexpected error occurred'));
  }
}

Future<Either<Failure, Map<String, dynamic>>> delete({
  required String name,
  required Map<String, dynamic> body,
  String? errMessage,
  bool withAuth = false,
}) async {
  try {
    final headers = {
      'Accept': 'application/json',
    };

    if (withAuth) {
      final token = await SharedPreference().getToken(); // تأكد إنك عامل دالة getToken
      if (token == null) return Left(ServerFailure('No token found'));
      headers['Authorization'] = 'Bearer $token';
    }

    final options = Options(
      headers: headers,
      validateStatus: (status) => status != null && status < 500,
    );

    final response = await dio.delete(
      '${EndPoint.baseUrl}$name',
      data: body,
      options: options,
    );

    if (response.statusCode == 200 && response.data['success'] == true) {
      return Right(response.data);
    }

    final errorMessage = response.data is Map && response.data.containsKey('message')
        ? response.data['message'].toString()
        : errMessage ?? 'Delete request failed';

    return Left(ServerFailure(errorMessage));
  } on DioError catch (e) {
    return Left(ServerFailure.fromDioError(e));
  } catch (e) {
    return Left(ServerFailure('An unexpected error occurred'));
  }
}



  
}
