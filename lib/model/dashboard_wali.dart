
class DashboardWaliModel {
    DashboardWaliModel({
        this.statusCode,
        this.data,
    });

    int statusCode;
    Data data;

    factory DashboardWaliModel.fromJson(Map<String, dynamic> json) => DashboardWaliModel(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.spp,
        this.notifUnread,
        this.kelasToday,
    });

    int spp;
    int notifUnread;
    List<KelasTodayWali> kelasToday;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        spp: json["spp"] == null ? null : json["spp"],
        notifUnread: json["notif_unread"] == null ? null : json["notif_unread"],
        kelasToday: json["kelas_today"] == null ? null : List<KelasTodayWali>.from(json["kelas_today"].map((x) => KelasTodayWali.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "spp": spp == null ? null : spp,
        "notif_unread": notifUnread == null ? null : notifUnread,
        "kelas_today": kelasToday == null ? null : List<dynamic>.from(kelasToday.map((x) => x.toJson())),
    };
}

class KelasTodayWali {
    KelasTodayWali({
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

    factory KelasTodayWali.fromJson(Map<String, dynamic> json) => KelasTodayWali(
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
