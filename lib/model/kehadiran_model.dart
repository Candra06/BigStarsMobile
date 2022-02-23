
class KehadiranModel {
    KehadiranModel({
        this.aksesAdd,
        this.dataKehadiran,
    });

    bool aksesAdd;
    List<ListKehadiran> dataKehadiran;

    factory KehadiranModel.fromJson(Map<String, dynamic> json) => KehadiranModel(
        aksesAdd: json["akses_add"] == null ? null : json["akses_add"],
        dataKehadiran: json["data"] == null ? null : List<ListKehadiran>.from(json["data"].map((x) => ListKehadiran.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "akses_add": aksesAdd == null ? null : aksesAdd,
        "data": dataKehadiran == null ? null : List<dynamic>.from(dataKehadiran.map((x) => x.toJson())),
    };
}

class ListKehadiran {
    ListKehadiran({
        this.nama,
        this.id,
        this.idGuru,
        this.idKelas,
        this.tipe,
        this.spp,
        this.feePengajar,
        this.poinSiswa,
        this.status,
        this.materi,
        this.fileMateri,
        this.jurnal,
        this.latitude,
        this.longitude,
        this.createdAt,
        this.updatedAt,
    });

    String nama;
    int id;
    String idGuru;
    String idKelas;
    String tipe;
    String spp;
    String feePengajar;
    String poinSiswa;
    String status;
    String materi;
    String fileMateri;
    String jurnal;
    String latitude;
    String longitude;
    DateTime createdAt;
    DateTime updatedAt;

    factory ListKehadiran.fromJson(Map<String, dynamic> json) => ListKehadiran(
        nama: json["nama"] == null ? null : json["nama"],
        id: json["id"] == null ? null : json["id"],
        idGuru: json["id_guru"] == null ? null : json["id_guru"],
        idKelas: json["id_kelas"] == null ? null : json["id_kelas"],
        tipe: json["tipe"] == null ? null : json["tipe"],
        spp: json["spp"] == null ? null : json["spp"],
        feePengajar: json["fee_pengajar"] == null ? null : json["fee_pengajar"],
        poinSiswa: json["poin_siswa"] == null ? null : json["poin_siswa"],
        status: json["status"] == null ? null : json["status"],
        materi: json["materi"] == null ? null : json["materi"],
        fileMateri: json["file_materi"] == null ? null : json["file_materi"],
        jurnal: json["jurnal"] == null ? null : json["jurnal"],
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "nama": nama == null ? null : nama,
        "id": id == null ? null : id,
        "id_guru": idGuru == null ? null : idGuru,
        "id_kelas": idKelas == null ? null : idKelas,
        "tipe": tipe == null ? null : tipe,
        "spp": spp == null ? null : spp,
        "fee_pengajar": feePengajar == null ? null : feePengajar,
        "poin_siswa": poinSiswa == null ? null : poinSiswa,
        "status": status == null ? null : status,
        "materi": materi == null ? null : materi,
        "file_materi": fileMateri == null ? null : fileMateri,
        "jurnal": jurnal == null ? null : jurnal,
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
