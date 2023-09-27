class UserModel {
  String password;
  String name;
  String email;
  String profilePicUrl;

  UserModel({
    required this.password,
    required this.name,
    required this.email,
    required this.profilePicUrl,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      password: map['password'],
      name: map['name'],
      email: map['email'],
      profilePicUrl: map['profilePicUrl'] ?? "",
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'name': name,
      'email': email,
      'profilePicUrl': profilePicUrl,
    };
  }
}
