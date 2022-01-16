class UserModel {
  UserModel({this.token, this.alamat, this.idUsers, this.id, this.phone, this.foto, this.role, this.username, this.password, this.status, this.rememberToken});

  String token;
  String password;
  int id;
  String alamat;
  int idUsers;
  dynamic phone;
  String role;
  String username;
  String foto;
  String status;
  dynamic rememberToken;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        idUsers: json["id_users"] == null ? null : json["id_users"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        foto: json["foto"] == null ? null : json["foto"],
        phone: json["phone"] == null ? null : json["phone"],
        role: json["role"] == null ? null : json["role"],
        status: json["status"] == null ? null : json["status"],
        rememberToken: json["remember_token"] == null ? null : json["remember_token"],
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

  Map<String, dynamic> editProfilAdmin() => {"phone": phone, "username": username, 'password': password};
  Map<String, dynamic> editProfilAdminNoPass() => {"phone": phone, "username": username};
}
