class UserModel {
  final int id;
  final String name;
  final String email;
  final String phone;
  final String type;
  final String? image;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    this.image,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: int.tryParse(json['id'].toString()) ?? 0,
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      type: json['type'] ?? '',
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone': phone,
        'type': type,
        'image': image,
      };
}