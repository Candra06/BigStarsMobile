class MapelModel {
  MapelModel({
    this.id,
    this.mapel,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String mapel;
  String status;
  DateTime createdAt;
  DateTime updatedAt;

  factory MapelModel.fromJson(Map<String, dynamic> json) => MapelModel(
        id: json["id"],
        mapel: json["mapel"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "mapel": mapel,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
