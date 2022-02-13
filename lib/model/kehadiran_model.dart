class KehadiranModel {
  KehadiranModel({
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

  factory KehadiranModel.fromJson(Map<String, dynamic> json) => KehadiranModel(
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
        "nama": nama,
        "id": id,
        "id_guru": idGuru,
        "id_kelas": idKelas,
        "tipe": tipe,
        "spp": spp,
        "fee_pengajar": feePengajar,
        "poin_siswa": poinSiswa,
        "status": status,
        "materi": materi,
        "file_materi": fileMateri,
        "jurnal": jurnal,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
