class DashboardModel {
  DashboardModel({
    this.kelas,
    this.siswa,
    this.guru,
    this.notifUnread,
    this.wali,
    this.kelasToday,
  });

  int kelas;
  int notifUnread;
  int siswa;
  int guru;
  int wali;
  List<KelasToday> kelasToday;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        kelas: json["kelas"],
        siswa: json["siswa"],
        notifUnread: json["notif_unread"] == null ? null : json["notif_unread"],
        guru: json["guru"],
        wali: json["wali"],
        kelasToday: json["kelas_today"] == null ? null : List<KelasToday>.from(json["kelas_today"].map((x) => KelasToday.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "kelas": kelas,
        "siswa": siswa,
        "guru": guru,
        "kelas_aktif": wali,
        "kelas_today": List<KelasToday>.from(kelasToday.map((x) => x)),
      };
}

class KelasToday {
  KelasToday({
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
    this.createdAt,
    this.updatedAt,
    this.hari,
    this.jamMulai,
    this.jamSelesai,
    this.notifUnread,
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
  DateTime createdAt;
  DateTime updatedAt;
  String hari;
  String jamMulai;
  String jamSelesai;
  int notifUnread;

  factory KelasToday.fromJson(Map<String, dynamic> json) => KelasToday(
        siswa: json["siswa"] == null ? null : json["siswa"],
        guru: json["guru"] == null ? null : json["guru"],
        mapel: json["mapel"] == null ? null : json["mapel"],
        id: json["id"] == null ? null : json["id"],
        idMapel: json["id_mapel"] == null ? null : json["id_mapel"],
        idGuru: json["id_guru"] == null ? null : json["id_guru"],
        idSiswa: json["id_siswa"] == null ? null : json["id_siswa"],
        spp: json["spp"] == null ? null : json["spp"],
        feeGuru: json["fee_guru"] == null ? null : json["fee_guru"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        hari: json["hari"] == null ? null : json["hari"],
        jamMulai: json["jam_mulai"] == null ? null : json["jam_mulai"],
        jamSelesai: json["jam_selesai"] == null ? null : json["jam_selesai"],
        notifUnread: json["notif_unread"] == null ? null : json["notif_unread"],
      );

  Map<String, dynamic> toJson() => {
        "siswa": siswa == null ? null : siswa,
        "guru": guru == null ? null : guru,
        "mapel": mapel == null ? null : mapel,
        "id": id == null ? null : id,
        "id_mapel": idMapel == null ? null : idMapel,
        "id_guru": idGuru == null ? null : idGuru,
        "id_siswa": idSiswa == null ? null : idSiswa,
        "spp": spp == null ? null : spp,
        "fee_guru": feeGuru == null ? null : feeGuru,
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "hari": hari == null ? null : hari,
        "jam_mulai": jamMulai == null ? null : jamMulai,
        "jam_selesai": jamSelesai == null ? null : jamSelesai,
        "notif_unread": notifUnread == null ? null : notifUnread,
      };
}
