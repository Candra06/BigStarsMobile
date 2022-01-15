class JadwalModel {
  JadwalModel({
    this.id,
    this.idKelas,
    this.hari,
    this.jamMulai,
    this.jamSelesai,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String idKelas;
  String hari;
  String jamMulai;
  String jamSelesai;
  DateTime createdAt;
  DateTime updatedAt;

  factory JadwalModel.fromJson(Map<String, dynamic> json) => JadwalModel(
        id: json["id"],
        idKelas: json["id_kelas"],
        hari: json["hari"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_kelas": idKelas,
        "hari": hari,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
