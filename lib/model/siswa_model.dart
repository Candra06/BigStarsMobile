class SiswaModel {
  SiswaModel({
    this.wali,
    this.alamat,
    this.id,
    this.idWali,
    this.nama,
    this.status,
    this.birthDate,
    this.createdAt,
    this.poinSiswa,
    this.updatedAt,
    this.kodeReferal,
  });

  String wali;
  String alamat;
  int id;
  String kodeReferal;
  String idWali;
  String nama;
  String status;
  DateTime birthDate;
  String createdAt;
  dynamic poinSiswa;
  String updatedAt;

  factory SiswaModel.fromJson(Map<String, dynamic> json) => SiswaModel(
        wali: json["wali"],
        alamat: json["alamat"],
        id: json["id"],
        idWali: json["id_wali"],
        kodeReferal: json["kode_referal"] == null ? null : json["kode_referal"],
        nama: json["nama"],
        status: json["status"] == null ? null : json["status"],
        birthDate: DateTime.parse(json["birth_date"]),
        createdAt: json["created_at"] == null ? null : json["created_at"],
        poinSiswa: json["poin_siswa"] == null ? null : json["poin_siswa"],
        updatedAt: json["updated_at"] == null ? null : json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "wali": wali,
        "alamat": alamat,
        "id": id,
        "id_wali": idWali,
        "nama": nama,
        "birth_date": "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}
