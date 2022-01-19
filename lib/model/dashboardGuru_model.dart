import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/kelasToday_model.dart';

class DashboardGuruModel {
  DashboardGuruModel({
    this.fee,
    this.kelasToday,
    this.kelasAktif,
    this.sharing,
  });

  String fee;
  int kelasAktif;
  List<KelasModel> kelasToday;
  List<KelasModel> sharing;

  factory DashboardGuruModel.fromJson(Map<String, dynamic> json) =>
      DashboardGuruModel(
        fee: json["fee"],
        kelasAktif: json["kelas_aktif"],
        kelasToday: List<KelasModel>.from(
            json["kelas_today"].map((x) => KelasModel.fromJson(x))),
        sharing: List<KelasModel>.from(
            json["sharing"].map((x) => KelasModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "fee": fee,
        "kelas_aktif": kelasAktif,
        "kelas_today": List<dynamic>.from(kelasToday.map((x) => x.toJson())),
        "sharing": List<dynamic>.from(sharing.map((x) => x)),
      };
}

class KelasTodayGuruModel {
  KelasTodayGuruModel({
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

  factory KelasTodayGuruModel.fromJson(Map<String, dynamic> json) =>
      KelasTodayGuruModel(
        siswa: json["siswa"],
        guru: json["guru"],
        mapel: json["mapel"],
        idKelas: json["id_kelas"],
        status: json["status"],
        jamMulai: json["jam_mulai"],
        jamSelesai: json["jam_selesai"],
      );

  Map<String, dynamic> toJson() => {
        "siswa": siswa,
        "guru": guru,
        "mapel": mapel,
        "id_kelas": idKelas,
        "status": status,
        "jam_mulai": jamMulai,
        "jam_selesai": jamSelesai,
      };
}

class SharingModel {
  SharingModel({
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

  factory SharingModel.fromJson(Map<String, dynamic> json) => SharingModel(
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
