class DashboardModel {
  DashboardModel({
    this.kelas,
    this.siswa,
    this.guru,
    this.kelasAktif,
    this.kelasToday,
  });

  int kelas;
  int siswa;
  int guru;
  int kelasAktif;
  List<dynamic> kelasToday;

  factory DashboardModel.fromJson(Map<String, dynamic> json) => DashboardModel(
        kelas: json["kelas"],
        siswa: json["siswa"],
        guru: json["guru"],
        kelasAktif: json["kelas_aktif"],
        kelasToday: List<dynamic>.from(json["kelas_today"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "kelas": kelas,
        "siswa": siswa,
        "guru": guru,
        "kelas_aktif": kelasAktif,
        "kelas_today": List<dynamic>.from(kelasToday.map((x) => x)),
      };
}
