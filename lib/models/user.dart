class Users {
  final String id;
  final String name;
  final String? email;
  final String? role;
  final int? age;
  final String? imageurl;
  final String? status;
  Users({
    required this.id,
    required this.name,
    this.email,
    this.role,
    this.age,
    this.imageurl,
    this.status,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'].toString(),
      name: json['name'] ?? 'Unknown',
      email: json['email'] ?? 'No email',
      role: json['role'] ?? 'No role',
      age: json['age'] ?? 0,
      imageurl: json['image_url'],
      status: json['status'] ?? 'active',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'role': role,
      'age': age,
      'image_url': imageurl,
      'status': status,
    };
  }
}
