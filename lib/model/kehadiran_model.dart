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
  DateTime createdAt;
  DateTime updatedAt;

  factory KehadiranModel.fromJson(Map<String, dynamic> json) => KehadiranModel(
        nama: json["nama"],
        id: json["id"],
        idGuru: json["id_guru"],
        idKelas: json["id_kelas"],
        tipe: json["tipe"],
        spp: json["spp"],
        feePengajar: json["fee_pengajar"],
        poinSiswa: json["poin_siswa"],
        status: json["status"],
        materi: json["materi"],
        fileMateri: json["file_materi"],
        jurnal: json["jurnal"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
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
