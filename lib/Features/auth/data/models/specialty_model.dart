
class Specialty {
  final int id;
  final String name;
  final String icon;

  Specialty({
    required this.id,
    required this.name,
    required this.icon,
  });

  factory Specialty.fromJson(Map<String, dynamic> json) {
    return Specialty(
      id: json['id'],
      name: json['name'],
      icon: json['icon'] ?? '',
    );
  }
}