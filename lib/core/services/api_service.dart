
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dentalog/Features/auth/data/models/sign_in_model.dart';
import 'package:dentalog/Features/auth/data/models/sign_up_model.dart';
import 'package:dentalog/core/api/Api.dart';
import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/core/errors/exceptions.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio dio = Dio(); 
Future<Either<Failure, SignUpModel>> signUpUser({
  required String name,
  required String email,
  required String password,
  required String type,
  required String mobile,
  int? specialityId,
}) async {
  final body = {
    "name": name,
    "email": email,
    "phone": mobile,
    "password": password,
    "role": type,
    if (type == 'doctor') "speciality_id": specialityId,
  };

  final response = await Api().post(
    name: 'register',
    body: body,
    errMessage: 'Registration failed',
    withAuth: false,
  );

  return response.fold(
    (failure) => Left(failure),
    (data) async {
      try {
        final dataContent = data['data']; // Extract the inner "data" object
        final userJson = dataContent['user'];
        final role = userJson['role'];
        final token = dataContent['token'];

        final signUpModel = SignUpModel.fromJson(dataContent);

        final prefs = SharedPreference();
        prefs.saveUser(role, role);

        if (userJson != null) {
          final userId = userJson['id'];
          if (userId != null) {
            await prefs.saveUser(ApiKey.id, userId.toString()); // Save user ID
          }
        }

        if (token != null) {
          await prefs.saveToken(token); // Save token
        }

        return Right(signUpModel);
      } catch (e) {
        return Left(Failure('Data conversion failed'));
      }
    },
  );
}

Future<Either<Failure, SignInModel>> signInUser({
  required String phone,
  required String password,
}) async {
  final result = await Api().post(
    name: "login",
    body: {
      "phone": phone,
      "password": password,
    },
    errMessage: "Failed to login",
  );

  return result.fold(
    (failure) => Left(failure),
    (data) async {
      try {
        final prefs = SharedPreference();

        final userData = data['data']['user'];
        final token = data['data']['token'];

        await prefs.saveToken(token);

        final userId = userData['id'];
        final role = userData['role']; // ← استخراج الدور

        if (userId != null) {
          await prefs.saveUser(ApiKey.id, userId.toString());
        }

        if (role != null) {
          await prefs.saveUser("role", role);
          print("role= $role"); // ← حفظ الدور في SharedPreferences
        }

        final signInModel = SignInModel.fromJson(data);
        return Right(signInModel);
      } catch (e) {
        return Left(Failure('Error while saving user data'));
      }
    },
  );
}




Future<Either<Failure, String>> otpVerify({
  required String email,
  required String otp,
}) async {
  final result = await Api().post(
    name: "verify", // تأكد أن هذا هو المسار الصحيح (قد تحتاج تغييره إلى 'verify' حسب Postman)
    body: {
      "email": email,
      "code": otp, 
    },
    errMessage: "OTP verification failed",
  );

  return result.fold(
    (failure) => Left(failure),
    (data) {
      final message = data['message'] ?? 'OTP verified successfully';
      return Right(message);
    },
  );
}


Future<Either<Failure, String>> verifyResetpasswordCode({
  required String phone,
  required String code,
}) async {
  final result = await Api().post(
    name: 'verify-reset-code', // يجب أن يتطابق مع اسم المسار في Api class
    body: {
      "phone": phone,
      "code": code,
    },
    errMessage: 'Code verification failed',
  );

  return result.fold(
    (failure) => Left(failure),
    (data) {
      final token = data['data']?['reset_token'];
      if (token == null) {
        return Left(Failure('The reset code was not found.'));
      }
      return Right(token);
    },
  );
}

Future<Either<Failure, Unit>> resetPassword({
  required String phone,
  required String token,
  required String password,
}) async {
  final result = await Api().post(
    name: 'reset-password',
    body: {
      "phone": phone,
      "token": token,
      "password": password,
    },
    errMessage: 'Failed to reset the password',
  );

  return result.fold(
    (failure) => Left(failure),
    (_) => const Right(unit), // Use `unit` from dartz to indicate success without data
  );
}



Future<Either<Failure, String>> forgetPassword({
  required String phone,
}) async {
  final result = await Api().post(
    name: "forgot-password", // تأكد من تطابقه مع المسار في الـ API
    body: {
      "phone": phone,
    },
    errMessage:'Failed to send the recovery code',
  );

  return result.fold(
    (failure) => Left(failure),
    (data) {
      final code = data['data']?['reset_code'];
      if (code != null) {
        return Right(code.toString());
      } else {
        return Left(Failure('The verification code has not been received.'));
      }
    },
  );
}


  Future<Either<Failure, String>> resetOtp({
  required String email,
}) async {
  final result = await Api().post(
    name: "resend-verification",
    body: {"email": email},
    errMessage: "Failed to resend OTP",
  );

  return result.fold(
    (failure) => Left(failure),
    (data) {
      final message = data['message'] ?? 'OTP resent successfully';

      if (data['old_otp_invalidated'] == true) {
        return Right('Old OTP has been invalidated. $message');
      }

      return Right(message);
    },
  );
}


  Future<Either<Failure, String>> logOutUser() async {
    final result = await Api().post(
      name: "logout",
      withAuth: true,
      errMessage: "Failed to logout",
    );

    return result.fold(
      (failure) => Left(failure),
      (_) => Right("Successfully logged out"),
    );
  }

Future<Either<Failure, Map<String, dynamic>>> getProfileData() async {
  final result = await Api().get(
    name: "user", // Endpoint like "/userprofile"
    errMessage: "Failed to get profile data",
    withAuth: true, // Ensures token is added in headers
  );

  if (result.isRight()) {
    final data = result.getOrElse(() => {});
    await SharedPreference().saveProfileData(data['data']); // Save "data" not "user"
  }

  return result;
}
Future<Either<Failure, Map<String, dynamic>>> editProfileUser({
  required String id,
  required String name,
  required String email,
  required String phone,
  required String password,
  File? imageFile,
}) async {
  try {
    Dio dio = Dio();

    final token = await SharedPreference().getToken();
    print("Token: Bearer $token");

    dio.options.headers['Authorization'] = 'Bearer $token';

    final String url = 'https://tempweb90.com/dentalog/api/users/$id';

    FormData formData = FormData.fromMap({
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      if (imageFile != null)
        'image': await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        ),
    });

    final response = await dio.post(
      url,
      data: formData,
      options: Options(
        followRedirects: false,
        validateStatus: (status) {
          return status != null && status < 500;
        },
      ),
    );

    print("Status code: ${response.statusCode}");
    print("Redirect location: ${response.headers['location']}");
    print("Response data: ${response.data}");

    if (response.statusCode == 200) {
      final data = response.data['data'];

      await SharedPreference().clearProfileCache();
      await SharedPreference().saveProfileData(data);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(ApiKey.id, data['id'].toString());
      prefs.setString(ApiKey.name, data['name']);
      prefs.setString(ApiKey.phone, data['phone']);
      prefs.setString(ApiKey.email, data['email']);
      prefs.setString(ApiKey.user, data['role']);

      return Right(data);
    } else {
      return Left(ServerFailure('Failed to modify the account: ${response.statusMessage ?? 'Unknown Error'}'));
    }
  } catch (e) {
    return Left(ServerFailure('Error connecting to the server: $e'));
  }
}

Future<Either<Failure, Map<String, dynamic>>> showSpecialties() async {
  try {
    final response = await dio.get(
      'https://tempweb90.com/dentalog/api/specialities',
      options: Options(
        headers: {'Accept': 'application/json'},
      ),
    );

    if (response.statusCode == 200) {
      return Right(response.data as Map<String, dynamic>);
    } else {
      return Left(ServerFailure('Failed to get specialties'));
    }
  } on DioError catch (e) {
    return Left(ServerFailure.fromDioError(e));
  } catch (e) {
    return Left(ServerFailure('An unexpected error occurred'));
  }
}


  Future<Either<Failure, Map<String, dynamic>>> showdoctors() async {
    final response = await Api().get(
      name: "doctors",
      errMessage: "Failed to get doctors ",
    );

    return response; // Already Either<Failure, Map<String, dynamic>>
  }

   Future<Either<Failure, Map<String, dynamic>>> showSpecialtiesbyid(int id) async {
    final response = await Api().get(
      name: "specialities/$id/doctors",
      errMessage: "Failed to get Specialties",
    );

    return response; // Already Either<Failure, Map<String, dynamic>>
  }


  Future<Either<Failure, Map<String, dynamic>>> showReportById(int reportId) async {
  final response = await Api().get(
    name: "reports/$reportId",
    errMessage: "Failed to get report details",
    withAuth: true
  );

  return response; // إما Failure أو Map<String, dynamic> حسب النتيجة
}


Future<Either<Failure, Map<String, dynamic>>> showAppointments() async {
  final response = await Api().get(
    name: "appointments",
    errMessage: "Failed to get appointments",
    withAuth: true,
  );

  return response;
}


Future<Either<Failure, Map<String, dynamic>>> getMedicines() async {
  final response = await Api().get(
    name: "medicines",
    errMessage: "Failed to get medicines",
    withAuth: true,
  );

  return response;
}



Future<Either<Failure, Map<String, dynamic>>> showWaitingAppointments() async {
  final response = await Api().get(
    name: "waiting-list", 
    errMessage: "Failed to get waiting list",
    withAuth: true,
  );

  return response; // Either<Failure, Map<String, dynamic>>
}



Future<Either<Failure, Map<String, dynamic>>> showHistory() async {
  final response = await Api().get(
    name: "reports/history", // استبدله بالمسار الصحيح إن وُجد
    errMessage: "Failed to get report history",
    withAuth: true,
  );

  return response;
}


Future<Either<Failure, Map<String, dynamic>>> submitAppointmentRequest({
  required int doctorId,
  required String appointmentDate,
  required String appointmentTime,
  required String name,
  required String phone,
  required int age,
  required String gender,
  required String address,
  required String problemDescription,
}) async {
  final response = await Api().post(
    name: 'appointments',
    withAuth: true,
    body: {
      'doctor_id': doctorId,
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
      'name': name,
      'phone': phone,
      'age': age,
      'gender': gender,
      'address': address,
      'problem_description': problemDescription,
    },
    errMessage: 'Failed to book the appointment',
  );



  return response.fold(
    (failure) => Left(failure),
    (data) {
      final contentData = data['data'] as Map<String, dynamic>;
      return Right(contentData);
    },
  );
}


Future<Either<Failure, Map<String, dynamic>>> rescheduleAppointmentRequest({
  required int appointmentId,
  required String appointmentDate,
  required String appointmentTime,
}) async {
  final response = await Api().post(
    name: 'appointments/$appointmentId/reschedule',
    withAuth: true,
    body: {
      'appointment_date': appointmentDate,
      'appointment_time': appointmentTime,
    },
    errMessage: 'Failed to reschedule the appointment.',
  );

  return response.fold(
    (failure) => Left(failure),
    (data) {
      final contentData = data['data'] as Map<String, dynamic>;
      return Right(contentData);
    },
  );
}



  Future<Either<Failure, Map<String, dynamic>>> updateAppointmentStatusRequest({
    required int appointmentId,
    required String status, // expected values: 'waiting', 'completed', 'canceled'
  }) async {
    final response = await Api().patch(
      name: 'appointments/$appointmentId/status',
      withAuth: true,
      body: {
        'status': status,
      },
      errMessage: 'Failed to update the appointment status.',
    );

    return response.fold(
      (failure) => Left(failure),
      (data) {
        final contentData = data['data'] as Map<String, dynamic>;
        return Right(contentData);
      },
    );
  }



Future<Either<Failure, Map<String, dynamic>>> submitDoctorRating({
  required int doctorId,
  required int rating,
  required String review,
}) async {
  final response = await Api().post(
    name: 'doctors/$doctorId/ratings',
    withAuth: true,
    body: {
      'rating': rating,
      'review': review,
    },
    errMessage: "Failed to send the evaluation.",
  );

  return response.fold(
    (failure) => Left(failure),
    (data) {
      final contentData = data['data'] as Map<String, dynamic>;
      return Right(contentData);
    },
  );
}


  Future<Either<Failure, Map<String, dynamic>>> submitReportByDoctor({
  required int appointmentId,
  required String diagnosis,
  required String advice,
  required List<Map<String, dynamic>> medicines,
}) async {
  final response = await Api().post(
    name: 'appointments/$appointmentId/report',
    withAuth: true,
    body: {
      'diagnosis': diagnosis,
      'advice': advice,
      'medicines': medicines,
    },
    errMessage: "Failed to generate the report",
  );

  return response.fold(
    (failure) => Left(failure),
    (data) {
      final contentData = data['data'] as Map<String, dynamic>;
      return Right(contentData);
    },
  );
}



Future<Either<Failure, dynamic>> deleteAccount({required String password}) async {
  final result = await Api().delete(
    name: "account/delete",
    body: {"password": password},
    errMessage: "Failed to delete user",
    withAuth: true, // خليها true لو فيه توكن بيستخدم
  );

  return result;
}



Future<Either<Failure, Map<String, dynamic>>> getNotifications() async {
  final response = await Api().get(
    name: "notifications", // Replace with the correct endpoint if different
    errMessage: "Failed to retrieve notifications",
    withAuth: true,
  );

  return response;
}

Future<Either<Failure, Map<String, dynamic>>> markNotificationAsRead(int profileId) async {
  return await Api().put(
    name: "notifications/$profileId/read", // This matches the Postman endpoint
    errMessage: "Failed to mark notification as read",
    withAuth: true,
  );
}


Future<Either<Failure, Map<String, dynamic>>> getDoctorSchedules(int doctorId) async {
  final response = await Api().get(
    name: "doctors/$doctorId/schedules",
    errMessage: "Failed to get doctor schedules",
    withAuth: true,
  );

  return response;
}

}
