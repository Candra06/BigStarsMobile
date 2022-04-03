class Absensi {
  Absensi({
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
    this.nama,
  });

  int id;
  int idGuru;
  int idKelas;
  String tipe;
  int spp;
  int feePengajar;
  int poinSiswa;
  String status;
  String materi;
  String fileMateri;
  String jurnal;
  DateTime createdAt;
  DateTime updatedAt;
  String nama;

  factory Absensi.fromJson(Map<String, dynamic> json) => Absensi(
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
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        nama: json["nama"] == null ? null : json["nama"],
      );

  Map<String, dynamic> toJson() => {
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
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "nama": nama == null ? null : nama,
      };
}
