class FeeGuruModel {
  FeeGuruModel({
    this.noInvoice,
    this.nama,
    this.id,
    this.feeBulan,
    this.jumlah,
    this.status,
    this.totalPertemuan,
    this.createdAt,
    this.udpatedAt,
  });

  String noInvoice;
  String nama;
  DateTime feeBulan;
  int jumlah;
  int id;
  String status;
  int totalPertemuan;
  DateTime createdAt;
  dynamic udpatedAt;

  factory FeeGuruModel.fromJson(Map<String, dynamic> json) => FeeGuruModel(
        id: json["id"] == null ? null : json["id"],
        noInvoice: json["no_invoice"] == null ? null : json["no_invoice"],
        nama: json["nama"] == null ? null : json["nama"],
        feeBulan: json["tagihan_bulan"] == null ? null : DateTime.parse(json["tagihan_bulan"]),
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        status: json["status"] == null ? null : json["status"],
        totalPertemuan: json["total_pertemuan"] == null ? null : json["total_pertemuan"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        udpatedAt: json["udpated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "no_invoice": noInvoice == null ? null : noInvoice,
        "nama": nama == null ? null : nama,
        "fee_bulan": feeBulan == null ? null : "${feeBulan.year.toString().padLeft(4, '0')}-${feeBulan.month.toString().padLeft(2, '0')}-${feeBulan.day.toString().padLeft(2, '0')}",
        "jumlah": jumlah == null ? null : jumlah,
        "status": status == null ? null : status,
        "total_pertemuan": totalPertemuan == null ? null : totalPertemuan,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "udpated_at": udpatedAt,
      };
}
