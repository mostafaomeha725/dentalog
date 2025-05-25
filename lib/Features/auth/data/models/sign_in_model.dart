class SignInModel {
  final String message;
  final bool isVerified;
  final String token;
  final Map<String, dynamic> fullUserData;

  SignInModel({
    required this.message,
    required this.isVerified,
    required this.token,
    required this.fullUserData,
  });

  factory SignInModel.fromJson(Map<String, dynamic> json) {
    final user = json['data']['user'] ?? {};

    return SignInModel(
      message: json['message'] ?? "Login successful",
      isVerified: user['is_verified'] == "1" || user['is_verified'] == true,
      token: json['data']['token'] ?? '',
      fullUserData: Map<String, dynamic>.from(user),
    );
  }

  Map<String, dynamic> toJson() => {
        "message": message,
        "is_verified": isVerified,
        "token": token,
        "user": fullUserData,
      };
}
