class UserModel {
  final String id;
  final String username;
  final String email;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['\$id'] ?? '',  // Aseguramos que coincida con la clave que usamos arriba
      username: json['username'] ?? '',
      email: json['email'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'username': username,
    'email': email,
  };
}
