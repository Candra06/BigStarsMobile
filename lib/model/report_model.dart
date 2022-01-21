class ReportModel {
  ReportModel({
    this.id,
    this.tipe,
    this.invoice,
    this.nama,
    this.status,
    this.nominal,
    this.tagihanBulan,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String tipe;
  String invoice;
  String nama;
  String status;
  String nominal;
  DateTime tagihanBulan;
  DateTime createdAt;
  DateTime updatedAt;

  factory ReportModel.fromJson(Map<String, dynamic> json) => ReportModel(
        id: json["id"] == null ? null : json["id"],
        tipe: json["tipe"] == null ? null : json["tipe"],
        invoice: json["invoice"] == null ? null : json["invoice"],
        nama: json["nama"] == null ? null : json["nama"],
        status: json["status"] == null ? null : json["status"],
        nominal: json["nominal"] == null ? null : json["nominal"],
        tagihanBulan: json["tagihan_bulan"] == null ? null : DateTime.parse(json["tagihan_bulan"]),
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "tipe": tipe == null ? null : tipe,
        "invoice": invoice == null ? null : invoice,
        "nama": nama == null ? null : nama,
        "status": status == null ? null : status,
        "nominal": nominal == null ? null : nominal,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
      };
}
