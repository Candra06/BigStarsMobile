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

  String idSiswa;
  String nama;
  int id;
  String noInvoice;
  DateTime tagihanBulan;
  String jumlah;
  String status;
  String createdBy;
  String updatedBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory SppModel.fromJson(Map<String, dynamic> json) => SppModel(
        idSiswa: json["id_siswa"] == null ? null : json["id_siswa"],
        nama: json["nama"] == null ? null : json["nama"],
        id: json["id"] == null ? null : json["id"],
        noInvoice: json["no_invoice"] == null ? null : json["no_invoice"],
        tagihanBulan: json["tagihan_bulan"] == null
            ? null
            : DateTime.parse(json["tagihan_bulan"]),
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        status: json["status"] == null ? null : json["status"],
        createdBy: json["created_by"] == null ? null : json["created_by"],
        updatedBy: json["updated_by"] == null ? null : json["updated_by"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id_siswa": idSiswa == null ? null : idSiswa,
        "nama": nama == null ? null : nama,
        "id": id == null ? null : id,
        "no_invoice": noInvoice == null ? null : noInvoice,
        "tagihan_bulan": tagihanBulan == null
            ? null
            : "${tagihanBulan.year.toString().padLeft(4, '0')}-${tagihanBulan.month.toString().padLeft(2, '0')}-${tagihanBulan.day.toString().padLeft(2, '0')}",
        "jumlah": jumlah == null ? null : jumlah,
        "status": status == null ? null : status,
        "created_by": createdBy == null ? null : createdBy,
        "updated_by": updatedBy == null ? null : updatedBy,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
