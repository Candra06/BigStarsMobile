class KelasModel {
  KelasModel({
    this.id,
    this.guru,
    this.siswa,
    this.mapel,
    this.idMapel,
    this.idGuru,
    this.idSiswa,
    this.spp,
    this.feeGuru,
    this.status,
    this.jamMulai,
    this.jamSelesai,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String guru;
  String siswa;
  String mapel;
  int idMapel;
  int idGuru;
  int idSiswa;
  int spp;
  int feeGuru;
  String status;
  String jamMulai;
  String jamSelesai;
  DateTime createdAt;
  DateTime updatedAt;

  factory KelasModel.fromJson(Map<String, dynamic> json) => KelasModel(
        id: json["id"],
        guru: json["guru"],
        siswa: json["siswa"],
        mapel: json["mapel"],
        idMapel: json["id_mapel"],
        idGuru: json["id_guru"],
        idSiswa: json["id_siswa"],
        spp: json["spp"],
        feeGuru: json["fee_guru"],
        status: json["status"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guru": guru,
        "siswa": siswa,
        "mapel": mapel,
        "id_mapel": idMapel,
        "id_guru": idGuru,
        "id_siswa": idSiswa,
        "spp": spp,
        "fee_guru": feeGuru,
        "status": status,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
