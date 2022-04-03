class KelasModel {
  KelasModel({
    this.id,
    this.guru,
    this.siswa,
    this.mapel,
    this.jumlahPertemuan,
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
  String jumlahPertemuan;
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
        id: json["id"] == null ? null : json["id"],
        guru: json["guru"] == null ? null : json["guru"],
        siswa: json["siswa"] == null ? null : json["siswa"],
        mapel: json["mapel"] == null ? null : json["mapel"],
        jumlahPertemuan: json["jumlah_pertemuan"] == null ? null : json["jumlah_pertemuan"],
        idMapel: json["id_mapel"] == null ? null : json["id_mapel"],
        idGuru: json["id_guru"] == null ? null : json["id_guru"],
        idSiswa: json["id_siswa"] == null ? null : json["id_siswa"],
        spp: json["spp"] == null ? null : json["spp"],
        feeGuru: json["fee_guru"] == null ? null : json["fee_guru"],
        status: json["status"] == null ? null : json["status"],
        jamMulai: json["jam_mulai"] == null ? null : json["jam_mulai"],
        jamSelesai: json["jam_selesai"] == null ? null : json["jam_selesai"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "guru": guru == null ? null : guru,
        "siswa": siswa == null ? null : siswa,
        "mapel": mapel == null ? null : mapel,
        "id_mapel": idMapel == null ? null : idMapel,
        "id_guru": idGuru == null ? null : idGuru,
        "id_siswa": idSiswa == null ? null : idSiswa,
        "spp": spp == null ? null : spp,
        "fee_guru": feeGuru == null ? null : feeGuru,
        "status": status == null ? null : status,
        "jam_mulai": jamMulai == null ? null : jamMulai,
        "jam_selesai": jamSelesai == null ? null : jamSelesai,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
