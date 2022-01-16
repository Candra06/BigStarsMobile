class WaliModel {
  WaliModel({
    this.id,
    this.idUsers,
    this.nama,
    this.alamat,
    this.createdAt,
    this.updatedAt,
    this.username,
    this.phone,
    this.status,
  });

  int id;
  String idUsers;
  String nama;
  String alamat;
  dynamic createdAt;
  dynamic updatedAt;
  String username;
  String phone;
  String status;

  factory WaliModel.fromJson(Map<String, dynamic> json) => WaliModel(
        id: json["id"],
        idUsers: json["id_users"],
        nama: json["nama"],
        alamat: json["alamat"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        username: json["username"],
        phone: json["phone"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_users": idUsers,
        "nama": nama,
        "alamat": alamat,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "username": username,
        "phone": phone,
        "status": status,
      };
}
