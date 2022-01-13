class SppModel {
  SppModel({
    this.idSiswa,
    this.nama,
    this.id,
    this.noInvoice,
    this.tagihanBulan,
    this.jumlah,
    this.status,
    this.createdBy,
    this.updatedBy,
    this.createdAt,
    this.updatedAt,
  });

  int idSiswa;
  String nama;
  int id;
  String noInvoice;
  DateTime tagihanBulan;
  int jumlah;
  String status;
  int createdBy;
  int updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory SppModel.fromJson(Map<String, dynamic> json) => SppModel(
        idSiswa: json["id_siswa"],
        nama: json["nama"],
        id: json["id"],
        noInvoice: json["no_invoice"],
        tagihanBulan: DateTime.parse(json["tagihan_bulan"]),
        jumlah: json["jumlah"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_siswa": idSiswa,
        "nama": nama,
        "id": id,
        "no_invoice": noInvoice,
        "tagihan_bulan":
            "${tagihanBulan.year.toString().padLeft(4, '0')}-${tagihanBulan.month.toString().padLeft(2, '0')}-${tagihanBulan.day.toString().padLeft(2, '0')}",
        "jumlah": jumlah,
        "status": status,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
