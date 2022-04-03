class KelasTodayModel {
  KelasTodayModel({
    this.siswa,
    this.guru,
    this.mapel,
    this.id,
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

  String siswa;
  String guru;
  String mapel;
  int id;
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

  factory KelasTodayModel.fromJson(Map<String, dynamic> json) => KelasTodayModel(
        siswa: json["siswa"],
        guru: json["guru"],
        mapel: json["mapel"],
        id: json["id"],
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
        "siswa": siswa,
        "guru": guru,
        "mapel": mapel,
        "id": id,
        "id_mapel": idMapel,
        "id_guru": idGuru,
        "id_siswa": idSiswa,
        "spp": spp,
        "fee_guru": feeGuru,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
