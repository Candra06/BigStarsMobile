class GuruModel {
  GuruModel({
    this.username,
    this.phone,
    this.id,
    this.idUsers,
    this.nama,
    this.alamat,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
  });

  String username;
  String phone;
  int id;
  String idUsers;
  String nama;
  String alamat;
  DateTime birthDate;
  dynamic createdAt;
  dynamic updatedAt;

  factory GuruModel.fromJson(Map<String, dynamic> json) => GuruModel(
        username: json["username"],
        phone: json["phone"],
        id: json["id"],
        idUsers: json["id_users"],
        nama: json["nama"],
        alamat: json["alamat"],
        birthDate: DateTime.parse(json["birth_date"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "phone": phone,
        "id": id,
        "id_users": idUsers,
        "nama": nama,
        "alamat": alamat,
        "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
