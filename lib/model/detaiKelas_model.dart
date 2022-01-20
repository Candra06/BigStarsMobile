import 'package:bigstars_mobile/model/jadwal_model.dart';

class DetailKelas {
  DetailKelas({
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
  });

  String siswa;
  String guru;
  String mapel;
  int id;
  String idMapel;
  String idGuru;
  String idSiswa;
  String spp;
  String feeGuru;
  String status;
  DateTime createdAt;
  DateTime updatedAt;
  List<JadwalModel> hari;

  factory DetailKelas.fromJson(Map<String, dynamic> json) => DetailKelas(
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        hari: json["hari"] == null
            ? null
            : List<JadwalModel>.from(
                json["hari"].map((x) => JadwalModel.fromJson(x))),
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
      };
}
