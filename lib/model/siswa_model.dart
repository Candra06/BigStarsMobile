class SiswaModel {
  SiswaModel({
    this.wali,
    this.alamat,
    this.id,
    this.idWali,
    this.nama,
    this.birthDate,
    this.createdAt,
    this.updatedAt,
  });

  String wali;
  String alamat;
  int id;
  int idWali;
  String nama;
  DateTime birthDate;
  dynamic createdAt;
  dynamic updatedAt;

  factory SiswaModel.fromJson(Map<String, dynamic> json) => SiswaModel(
        wali: json["wali"],
        alamat: json["alamat"],
        id: json["id"],
        idWali: json["id_wali"],
        nama: json["nama"],
        birthDate: DateTime.parse(json["birth_date"]),
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "wali": wali,
        "alamat": alamat,
        "id": id,
        "id_wali": idWali,
        "nama": nama,
        "birth_date":
            "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}