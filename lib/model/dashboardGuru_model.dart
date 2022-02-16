import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';

class DashboardGuruModel {
  DashboardGuruModel({
    this.fee,
    this.notifUnread,
    this.kelasToday,
    this.kelasAktif,
    this.sharing,
  });

  String fee;
  int notifUnread;
  List<KelasTodayGuru> kelasToday;
  int kelasAktif;
  List<KelasTodayGuru> sharing;

  factory DashboardGuruModel.fromJson(Map<String, dynamic> json) =>
      DashboardGuruModel(
        fee: json["fee"] == null ? null : json["fee"].toString(),
        notifUnread: json["notif_unread"] == null ? null : json["notif_unread"],
        kelasToday: json["kelas_today"] == null
            ? null
            : List<KelasTodayGuru>.from(
                json["kelas_today"].map((x) => KelasTodayGuru.fromJson(x))),
        kelasAktif: json["kelas_aktif"] == null ? null : json["kelas_aktif"],
        sharing: json["sharing"] == null
            ? null
            : List<KelasTodayGuru>.from(
                json["sharing"].map((x) => KelasTodayGuru.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fee": fee == null ? null : fee,
        "notif_unread": notifUnread == null ? null : notifUnread,
        "kelas_today": kelasToday == null
            ? null
            : List<dynamic>.from(kelasToday.map((x) => x.toJson())),
        "kelas_aktif": kelasAktif == null ? null : kelasAktif,
        "sharing":
            sharing == null ? null : List<dynamic>.from(sharing.map((x) => x)),
      };
}

class KelasTodayGuru {
  KelasTodayGuru({
    this.siswa,
    this.guru,
    this.mapel,
    this.idKelas,
    this.status,
    this.jamMulai,
    this.jamSelesai,
  });

  String siswa;
  String guru;
  String mapel;
  String idKelas;
  String status;
  String jamMulai;
  String jamSelesai;

  factory KelasTodayGuru.fromJson(Map<String, dynamic> json) => KelasTodayGuru(
        siswa: json["siswa"] == null ? null : json["siswa"],
        guru: json["guru"] == null ? null : json["guru"],
        mapel: json["mapel"] == null ? null : json["mapel"],
        idKelas: json["id_kelas"] == null ? null : json["id_kelas"],
        status: json["status"] == null ? null : json["status"],
        jamMulai: json["jam_mulai"] == null ? null : json["jam_mulai"],
        jamSelesai: json["jam_selesai"] == null ? null : json["jam_selesai"],
      );

  Map<String, dynamic> toJson() => {
        "siswa": siswa == null ? null : siswa,
        "guru": guru == null ? null : guru,
        "mapel": mapel == null ? null : mapel,
        "id_kelas": idKelas == null ? null : idKelas,
        "status": status == null ? null : status,
        "jam_mulai": jamMulai == null ? null : jamMulai,
        "jam_selesai": jamSelesai == null ? null : jamSelesai,
      };
}
