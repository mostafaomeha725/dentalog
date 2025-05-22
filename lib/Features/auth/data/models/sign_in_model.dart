class SignInModel {
  final String message;
  final bool isVerified;
  final String userId;
  final Map<String, dynamic> fullUserData;

  SignInModel({
    required this.message,
    required this.isVerified,
    required this.userId,
    required this.fullUserData,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    final user = json['user'] ?? {};

    return SignInModel(
      message: json['message'] ?? "Login successful",
      isVerified: user['is_verified'] ?? false,
      userId: user['id'].toString(),
      fullUserData: Map<String, dynamic>.from(user),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "is_verified": isVerified,
        "user_id": userId,
        "user": fullUserData,
      };
}
