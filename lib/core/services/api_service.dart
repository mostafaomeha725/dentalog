
import 'package:dartz/dartz.dart';
import 'package:dentalog/Features/auth/data/models/sign_in_model.dart';
import 'package:dentalog/Features/auth/data/models/sign_up_model.dart';
import 'package:dentalog/Features/home/presentation/manager/cubit/show_specialties_cubit/show_specialties_cubit.dart';
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
}) async {
  final response = await Api().post(
    name: 'register',
    body: {
      "name": name,
      "email": email,
      "phone": mobile,
      "password": password,
      "role": type,
    },
    errMessage: 'فشل التسجيل',
    withAuth: false,
  );

  return response.fold(
    (failure) => Left(failure),
    (data) async {
      try {
        final dataContent = data['data']; // Extract the inner "data" object
        final userJson = dataContent['user'];
                final role = dataContent['user']['role'];

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
        return Left(Failure('فشل تحويل البيانات'));
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
          await prefs.saveUser("role", role); // ← حفظ الدور في SharedPreferences
        }

        final signInModel = SignInModel.fromJson(data);
        return Right(signInModel);
      } catch (e) {
        return Left(Failure("خطأ أثناء حفظ بيانات المستخدم"));
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
    errMessage: "فشل التحقق من الكود",
  );

  return result.fold(
    (failure) => Left(failure),
    (data) {
      final token = data['data']?['reset_token'];
      if (token == null) {
        return Left(Failure('لم يتم العثور على رمز إعادة التعيين'));
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
    errMessage: "فشل إعادة تعيين كلمة المرور",
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
    errMessage: "فشل في إرسال كود الاستعادة",
  );

  return result.fold(
    (failure) => Left(failure),
    (data) {
      final code = data['data']?['reset_code'];
      if (code != null) {
        return Right(code.toString());
      } else {
        return Left(Failure("لم يتم استلام كود التحقق"));
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
  required String role,
}) async {
  final result = await Api().post(
    name: "users/$id", 
    body: {
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "role": role,
    },
    errMessage: "Failed to edit profile",
  );

  if (result.isLeft()) {
    return result;
  }

  final data = result.getOrElse(() => {});
  final user = data['data'];
  final prefs = await SharedPreferences.getInstance();

  await SharedPreference().clearProfileCache();
  await SharedPreference().saveProfileData(user);

  await prefs.setString(ApiKey.id, user['id'].toString());
  await prefs.setString(ApiKey.name, user['name']);
  await prefs.setString(ApiKey.phone, user['phone']);
  await prefs.setString(ApiKey.email, user['email']);
  await prefs.setString(ApiKey.user, user['role']);

  return Right(user);
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
    withAuth: true, // assuming appointments need authentication
  );

  return response; // This will be Either<Failure, Map<String, dynamic>>
}



Future<Either<Failure, Map<String, dynamic>>> showWaitingAppointments() async {
  final response = await Api().get(
    name: "waiting-list", // ← غيّر هذا حسب اسم endpoint الحقيقي لقائمة الانتظار
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
    errMessage: 'فشل في حجز الموعد',
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
    errMessage: 'فشل في إعادة جدولة الموعد',
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
      errMessage: 'فشل في تحديث حالة الموعد',
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
    errMessage: 'فشل في إرسال التقييم',
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
    errMessage: 'فشل في إنشاء التقرير',
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


}
