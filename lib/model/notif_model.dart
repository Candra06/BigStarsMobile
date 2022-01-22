class NotifikasiModel {
  NotifikasiModel({
    this.id,
    this.judul,
    this.konten,
    this.status,
    this.createdAt,
  });

  int id;
  String judul;
  String konten;
  String status;
  DateTime createdAt;

  factory NotifikasiModel.fromJson(Map<String, dynamic> json) => NotifikasiModel(
        id: json["id"] == null ? null : json["id"],
        judul: json["judul"] == null ? null : json["judul"],
        konten: json["konten"] == null ? null : json["konten"],
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "judul": judul == null ? null : judul,
        "konten": konten == null ? null : konten,
        "status": status == null ? null : status,
      };
}
