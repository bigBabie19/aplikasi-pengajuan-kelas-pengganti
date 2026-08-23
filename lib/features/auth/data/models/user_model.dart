class UserModel {
  final int id;
  final String name;
  final String email;
  final String? avatarUrl;
  final String? role;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    this.role,
  });

  factory UserModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      avatarUrl: json['avatar_url'],
      role: json['role'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatar_url': avatarUrl,
      'role': role,
    };
  }
}
