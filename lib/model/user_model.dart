class UserModel {
  UserModel({
    this.id,
    this.username,
    this.password,
    this.foto,
    this.phone,
    this.role,
    this.status,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  int id;
  String username;
  String password;
  String foto;
  String phone;
  String role;
  String status;
  dynamic rememberToken;
  dynamic createdAt;
  DateTime updatedAt;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        username: json["username"],
        password: json["password"],
        foto: json["foto"],
        phone: json["phone"],
        role: json["role"],
        status: json["status"],
        rememberToken: json["remember_token"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "password": password,
        "foto": foto,
        "phone": phone,
        "role": role,
        "status": status,
        "remember_token": rememberToken,
        "created_at": createdAt,
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
      };
  Map<String, dynamic> editProfilAdmin() =>
      {"phone": phone, "username": username, 'password': password};
  Map<String, dynamic> editProfilAdminNoPass() =>
      {"phone": phone, "username": username};
}
