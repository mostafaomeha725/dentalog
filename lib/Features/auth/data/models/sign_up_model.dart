import 'package:dentalog/Features/auth/data/models/user_model.dart';
import 'package:dentalog/core/api/end_ponits.dart';

class SignUpModel {
  final String message;
  final UserModel? user;
  final String? token;
  final bool? needsVerification;
  final String? verificationCode;
  final bool? emailSent;

  SignUpModel({
    required this.message,
    this.user,
    this.token,
    this.needsVerification,
    this.verificationCode,
    this.emailSent,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    final data = json[ApiKey.data];
    final userData = data?[ApiKey.user];

    return SignUpModel(
      message: json[ApiKey.message] ?? '',
      user: userData != null && userData is Map<String, dynamic>
          ? UserModel.fromJson(userData)
          : null,
      token: data?[ApiKey.token],
      needsVerification: data?[ApiKey.needsverification],
      verificationCode: data?[ApiKey.verificationCode],
      emailSent: data?[ApiKey.emailsent],
    );
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        if (user != null) 'user': user!.toJson(),
        'token': token,
        'needs_verification': needsVerification,
        'verification_code': verificationCode,
        'email_sent': emailSent,
      };
}
