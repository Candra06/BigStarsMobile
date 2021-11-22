class UserModel {
  UserModel({
    this.token,
    this.alamat,
    this.idUsers,
    this.phone,
    this.role,
    this.username,
    this.status,
  });

  String token;

  String alamat;
  int idUsers;
  dynamic phone;
  String role;
  String username;
  String status;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        token: json["token"],
        alamat: json["alamat"],
        idUsers: json["id_users"],
        phone: json["phone"],
        role: json["role"],
        username: json["username"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "alamat": alamat,
        "id_users": idUsers,
        "phone": phone,
        "role": role,
        "username": username,
        "status": status,
      };
}
