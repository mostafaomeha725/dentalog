class DoctorsModel {
  String name;
  String avaliableTime;
  String department;
  String phone;

  DoctorsModel({
    required this.name,
    required this.avaliableTime,
    required this.department,
    required this.phone,
  });

  // تحويل JSON إلى كائن DoctorsModel
  factory DoctorsModel.fromJson(Map<String, dynamic> json) {
    return DoctorsModel(
      name: json['name'] ?? '',
      avaliableTime: json['avaliableTime'] ?? '',
      department: json['department'] ?? '',
      phone: json['phone'] ?? '',
    );
  }

  // تحويل كائن DoctorsModel إلى JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'avaliableTime': avaliableTime,
      'department': department,
      'phone': phone,
    };
  }
}
