
class DetailKelasModel {
    DetailKelasModel({
        this.statusCode,
        this.message,
        this.data,
        this.hari,
    });

    int statusCode;
    String message;
    Data data;
    List<Hari> hari;

    factory DetailKelasModel.fromJson(Map<String, dynamic> json) => DetailKelasModel(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
        hari: json["hari"] == null ? null : List<Hari>.from(json["hari"].map((x) => Hari.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
        "hari": hari == null ? null : List<dynamic>.from(hari.map((x) => x.toJson())),
    };
}

class Data {
    Data({
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

    factory Data.fromJson(Map<String, dynamic> json) => Data(
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
    };
}

class Hari {
    Hari({
        this.id,
        this.idKelas,
        this.hari,
        this.jamMulai,
        this.jamSelesai,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    int idKelas;
    String hari;
    String jamMulai;
    String jamSelesai;
    DateTime createdAt;
    DateTime updatedAt;

    factory Hari.fromJson(Map<String, dynamic> json) => Hari(
        id: json["id"] == null ? null : json["id"],
        idKelas: json["id_kelas"] == null ? null : json["id_kelas"],
        hari: json["hari"] == null ? null : json["hari"],
        jamMulai: json["jam_mulai"] == null ? null : json["jam_mulai"],
        jamSelesai: json["jam_selesai"] == null ? null : json["jam_selesai"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_kelas": idKelas == null ? null : idKelas,
        "hari": hari == null ? null : hari,
        "jam_mulai": jamMulai == null ? null : jamMulai,
        "jam_selesai": jamSelesai == null ? null : jamSelesai,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
