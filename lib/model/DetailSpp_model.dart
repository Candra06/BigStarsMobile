class DetailSPPModel {
  DetailSPPModel({
    this.noInvoice,
    this.nama,
    this.tagihanBulan,
    this.jumlah,
    this.status,
    this.totalPertemuan,
    this.createdAt,
    this.udpatedAt,
  });

  String noInvoice;
  String nama;
  DateTime tagihanBulan;
  String jumlah;
  String status;
  int totalPertemuan;
  DateTime createdAt;
  DateTime udpatedAt;

  factory DetailSPPModel.fromJson(Map<String, dynamic> json) => DetailSPPModel(
        noInvoice: json["no_invoice"] == null ? null : json["no_invoice"],
        nama: json["nama"] == null ? null : json["nama"],
        tagihanBulan: json["tagihan_bulan"] == null
            ? null
            : DateTime.parse(json["tagihan_bulan"]),
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        status: json["status"] == null ? null : json["status"],
        totalPertemuan:
            json["total_pertemuan"] == null ? null : json["total_pertemuan"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        udpatedAt: json["udpated_at"] == null
            ? null
            : DateTime.parse(json["udpated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "no_invoice": noInvoice == null ? null : noInvoice,
        "nama": nama == null ? null : nama,
        "tagihan_bulan": tagihanBulan == null
            ? null
            : "${tagihanBulan.year.toString().padLeft(4, '0')}-${tagihanBulan.month.toString().padLeft(2, '0')}-${tagihanBulan.day.toString().padLeft(2, '0')}",
        "jumlah": jumlah == null ? null : jumlah,
        "status": status == null ? null : status,
        "total_pertemuan": totalPertemuan == null ? null : totalPertemuan,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "udpated_at": udpatedAt == null ? null : udpatedAt.toIso8601String(),
      };
}
