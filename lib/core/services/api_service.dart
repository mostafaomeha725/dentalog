


import 'package:dartz/dartz.dart';
import 'package:dentalog/Features/auth/data/models/sign_in_model.dart';
import 'package:dentalog/Features/auth/data/models/sign_up_model.dart';
import 'package:dentalog/core/api/Api.dart';
import 'package:dentalog/core/api/end_ponits.dart';
import 'package:dentalog/core/errors/exceptions.dart';
import 'package:dentalog/core/helper/shared_preferences/shared_preferences.dart';
import 'package:dentalog/core/widgets/get_device_id.dart';
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
      "type": type,
    },
    errMessage: 'فشل التسجيل',
    withAuth: false,
  );

  return await response.fold(
    (failure) => Left(failure),
    (data) async {
      try {
        final signUpModel = SignUpModel.fromJson(data);

        // حفظ الـ ID في SharedPreferences
        if (signUpModel.user != null) {
          await SharedPreference()
              .saveUser(ApiKey.id, signUpModel.user!.id.toString());
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
  required String deviceId,
}) async {
  final result = await Api().post(
    name: "login",
    body: {
      "phone": phone,
      "password": password,
      "deviceid": deviceId,
    },
    errMessage: "Failed to login",
  );

  return result.fold(
    (failure) => Left(failure),
    (data) async {
      final user = data['user'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(ApiKey.id, user['id'].toString());
      await prefs.setString(ApiKey.phone, user['phone']);
            await prefs.setString(ApiKey.email, user['email']);


      return Right(SignInModel.fromJson(data));
    },
  );
}




//   Future<Either<Failure, String>> otpVerify({
//     required String email,
//     required String otp,
//   }) async {
//     final result = await Api().post(
//       name: "verify-otp",
//       body: {
//         "email": email,
//         "otp": otp,
//       },
//       errMessage: "OTP verification failed",
//     );

//     return result.fold(
//       (failure) => Left(failure),
//       (data) {
//         final message = data['message'] ?? 'OTP verified successfully';
//         return Right(message);
//       },
//     );
//   }

//   Future<Either<Failure, String>> resetOtp({
//     required String email,
//   }) async {
//     final result = await Api().post(
//       name: "resend-otp",
//       body: {"email": email},
//       errMessage: "Failed to resend OTP",
//     );

//     return result.fold(
//       (failure) => Left(failure),
//       (data) {
//         // Check if there's a message indicating the old OTP was invalidated
//         final message = data['message'] ?? 'OTP resent successfully';

//         // If the old OTP is invalidated, return a message about it and the new OTP.
//         if (data['old_otp_invalidated'] == true) {
//           return Right('Old OTP has been invalidated. $message');
//         }

//         // If no invalidation happened, return the normal success message
//         return Right(message);
//       },
//     );
//   }

//   Future<Either<Failure, String>> logOutUser() async {
//     final result = await Api().post(
//       name: "logout",
//       withAuth: true,
//       errMessage: "Failed to logout",
//     );

//     return result.fold(
//       (failure) => Left(failure),
//       (_) => Right("Successfully logged out"),
//     );
//   }

Future<Either<Failure, Map<String, dynamic>>> getProfileData({required String id}) async {
  final result = await Api().get(
    name: "userprofile",
    id: '?id=$id',
    errMessage: "Failed to get profile data",
    withAuth: false,
  );

  if (result.isRight()) {
    final data = result.getOrElse(() => {});
    await SharedPreference().saveProfileData(data['user']);
      await SharedPreference().saveId(data['id']);
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
    name: "editprofile",
    body: {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "password": password,
      "role": role,
    },
    errMessage: "Failed to edit profile",
  );

  return result.fold(
    (failure) => Left(failure),
    (data) async {
      final user = data['user'];
      final prefs = await SharedPreferences.getInstance();
      SharedPreference().clearProfileCache();
    await SharedPreference().saveProfileData(data);
    print(data);

      await prefs.setString(ApiKey.id, user['id'].toString());
      await prefs.setString(ApiKey.name, user['name']);
      await prefs.setString(ApiKey.phone, user['phone']);
      await prefs.setString(ApiKey.email, user['email']);
      await prefs.setString(ApiKey.user, user['role']);

      return Right(user);
    },
  );
}




  Future<Either<Failure, Map<String, dynamic>>> showSpecialties() async {
    final result = await Api().get(
      name: "specialties",
      errMessage: "Failed to get specialties",
    );

    return result;
  }

//   Future<Either<Failure, Map<String, dynamic>>> getAllCity() async {
//     final response = await Api().get(
//       name: "cities",
//       errMessage: "Failed to get city",
//     );

//     return response; // Already Either<Failure, Map<String, dynamic>>
//   }

//   Future<Either<Failure, Map<String, dynamic>>> getCategory() async {
//     final result = await Api().get(
//       name: "categories",
//       errMessage: "Failed to get categories",
//     );

//     return result;
//   }

//   Future<Either<Failure, Map<String, dynamic>>> getContentByCategory(
//       int categoryId) async {
//     final result = await Api().get(
//       name: 'categories/$categoryId/contents',
//       errMessage: 'Failed to get content by category',
//     );
//     return result;
//   }

//   Future<Either<Failure, Map<String, dynamic>>> getSpecificCategory(
//       int id) async {
//     final result = await Api().get(
//       name: 'categories/$id',
//       errMessage: 'Failed to get specific category',
//     );
//     return result;
//   }

//   Future<Either<Failure, Map<String, dynamic>>> getAllContents() async {
//     final result = await Api().get(
//       name: 'contents',
//       errMessage: 'Failed to get All category',
//     );
//     return result;
//   }
// //getallvoucher
//     Future<Either<Failure, Map<String, dynamic>>> getAllVoucher() async {
//       final result = await Api().get(
//         name: 'vouchers',
//         errMessage: 'Failed to get All voucher',
//         withAuth: true
//       );
      
//       return result;
//     }     
// Future<Either<Failure, Map<String, dynamic>>> getUserVouchers(String userId) async {
//   final result = await Api().get(
//     name: 'users/$userId/vouchers',
//     errMessage: 'Failed to get user vouchers',
//     withAuth: true,
//   );

//   return result;
// }


// Future<Either<Failure, Map<String, dynamic>>> getuserpoint(String userId) async {
//   final result = await Api().get(
//     name: 'users/$userId/points',
//     errMessage: 'Failed to get user points',
//     withAuth: true,
//   );

//   return result;
// }

// Future<Either<Failure, Map<String, dynamic>>> purchaseVoucher(int voucherId) async {
//   final response = await Api().post(
//     name: 'vouchers/purchase?voucher_id=$voucherId',
//     withAuth: true,
//     errMessage: 'Failed to purchase voucher',
//   );

//   return response.fold(
//     (failure) => Left(failure),
//     (data) {
//       final voucherData = data['data'] as Map<String, dynamic>;
//       return Right(voucherData);
//     },
//   );
// }

// Future<Either<Failure, Map<String, dynamic>>> addGamePoint(int gameId) async {
//   final response = await Api().post(
//     name: 'games/add-points',
//     withAuth: true,
//     body: {'game_id': gameId},
//     errMessage: 'Failed to add points',
//   );

//   return response.fold(
//     (failure) => Left(failure),
//     (data) {
//       final responseData = data ;
//       return Right(responseData);
//     },
//   );
// }

// Future<Either<Failure, Map<String, dynamic>>> viewSpecificContent(int contentId) async {
//   final response = await Api().post(
//     name: 'content/view?content_id=$contentId',
//     withAuth: true,
//     errMessage: 'فشل في عرض المحتوى',
//   );

//   return response.fold(
//     (failure) => Left(failure),
//     (data) {
//       final contentData = data['data'] as Map<String, dynamic>;
//       return Right(contentData);
//     },
//   );
// }


// Future<Either<Failure, List<dynamic>>> getGames() async {
//     try {
//       final prefs = await SharedPreferences.getInstance();
//       final token = prefs.getString('user_token');

//       if (token == null) {
//         return Left(ServerFailure('Token غير موجود'));
//       }

//       final response = await dio.get(
//         'https://tempweb90.com/azrobot/public/api/games',
//         options: Options(
//           headers: {
//             'Accept': 'application/json',
//             'Authorization': 'Bearer $token',
//           },
//         ),
//       );

//       if (response.statusCode == 200 && response.data is List) {
//         return Right(response.data);
//       } else {
//         return Left(ServerFailure('خطأ في تحميل البيانات'));
//       }
//     } catch (e) {
//       return Left(ServerFailure('حدث خطأ أثناء الاتصال بالخادم'));
//     }
//   }
  

  Future<Either<Failure, dynamic>> deleteAccount({required int id}) async {
  final result = await Api().delete(
    name: "deleteuser",
    body: {"id": id},
    errMessage: "Failed to delete user",
    withAuth: false,
  );

  return result;
}



}
