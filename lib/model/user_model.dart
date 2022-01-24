class UserModel {
  UserModel({
    this.id,
    this.username,
    this.password,
    this.foto,
    this.phone,
    this.nama,
    this.role,
    this.status,
    this.rememberToken,
    this.createdAt,
    this.updatedAt,
    this.token,
    this.alamat,
    this.birthDate,
  });

  int id;
  String username;
  String password;
  String foto;
  String phone;
  String nama;
  String role;
  String alamat;
  String status;
  dynamic rememberToken;
  DateTime birthDate;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"] == null ? null : json["id"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        foto: json["foto"] == null ? null : json["foto"],
        phone: json["phone"] == null ? null : json["phone"],
        nama: json["nama"] == null ? null : json["nama"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        role: json["role"] == null ? null : json["role"],
        status: json["status"] == null ? null : json["status"],
        rememberToken: json["remember_token"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        token: json["token"] == null ? null : json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "foto": foto == null ? null : foto,
        "phone": phone == null ? null : phone,
        "role": role == null ? null : role,
        "status": status == null ? null : status,
        "remember_token": rememberToken,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "token": token == null ? null : token,
      };

  Map<String, dynamic> editProfilAdmin() =>
      {"phone": phone, "username": username, 'password': password};
  Map<String, dynamic> editProfilAdminNoPass() =>
      {"phone": phone, "username": username};
}
