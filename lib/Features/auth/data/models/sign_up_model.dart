import 'user_model.dart';

class SignUpModel {
  final String message;
  final UserModel? user;

  SignUpModel({
    required this.message,
    this.user,
  });

  factory SignUpModel.fromJson(Map<String, dynamic> json) {
    final userData = json['user'];
    if (userData != null && userData is Map<String, dynamic>) {
      return SignUpModel(
        message: json['message'] ?? '',
        user: UserModel.fromJson(userData),
      );
    } else {
      return SignUpModel(
        message: json['message'] ?? '',
        user: null,
      );
    }
  }

  Map<String, dynamic> toJson() => {
        'message': message,
        if (user != null) 'user': user!.toJson(),
      };
}
