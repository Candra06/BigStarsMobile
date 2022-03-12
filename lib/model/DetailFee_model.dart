class DetailFeeModel {
  DetailFeeModel({
    this.noInvoice,
    this.nama,
    this.tagihanBulan,
    this.jumlah,
    this.status,
    this.keterangan,
    this.totalPertemuan,
    this.createdAt,
    this.udpatedAt,
    this.historiKehadiranGuru,
  });

  String noInvoice;
  String nama;
  DateTime tagihanBulan;
  int jumlah;
  String status;
  String keterangan;
  int totalPertemuan;
  DateTime createdAt;
  dynamic udpatedAt;
  List<HistoriKehadiranGuru> historiKehadiranGuru;

  factory DetailFeeModel.fromJson(Map<String, dynamic> json) => DetailFeeModel(
        noInvoice: json["no_invoice"] == null ? null : json["no_invoice"],
        nama: json["nama"] == null ? null : json["nama"],
        tagihanBulan: json["tagihan_bulan"] == null ? null : DateTime.parse(json["tagihan_bulan"]),
        jumlah: json["jumlah"] == null ? null : json["jumlah"],
        status: json["status"] == null ? null : json["status"],
        keterangan: json["keterangan"] == null ? null : json["keterangan"],
        totalPertemuan: json["total_pertemuan"] == null ? null : json["total_pertemuan"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        udpatedAt: json["udpated_at"],
        historiKehadiranGuru: json["history_kehadiran"] == null ? null : List<HistoriKehadiranGuru>.from(json["history_kehadiran"].map((x) => HistoriKehadiranGuru.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "no_invoice": noInvoice == null ? null : noInvoice,
        "nama": nama == null ? null : nama,
        "tagihan_bulan":
            tagihanBulan == null ? null : "${tagihanBulan.year.toString().padLeft(4, '0')}-${tagihanBulan.month.toString().padLeft(2, '0')}-${tagihanBulan.day.toString().padLeft(2, '0')}",
        "jumlah": jumlah == null ? null : jumlah,
        "status": status == null ? null : status,
        "total_pertemuan": totalPertemuan == null ? null : totalPertemuan,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "udpated_at": udpatedAt,
        "histori_kehadiran": historiKehadiranGuru == null ? null : List<dynamic>.from(historiKehadiranGuru.map((x) => x.toJson())),
      };
}

class HistoriKehadiranGuru {
  HistoriKehadiranGuru({
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
    this.latitude,
    this.longitude,
    this.createdAt,
    this.updatedAt,
    this.mapel,
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
  String latitude;
  String longitude;
  DateTime createdAt;
  DateTime updatedAt;
  String mapel;
  String nama;

  factory HistoriKehadiranGuru.fromJson(Map<String, dynamic> json) => HistoriKehadiranGuru(
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
        latitude: json["latitude"] == null ? null : json["latitude"],
        longitude: json["longitude"] == null ? null : json["longitude"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        mapel: json["mapel"] == null ? null : json["mapel"],
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
        "latitude": latitude == null ? null : latitude,
        "longitude": longitude == null ? null : longitude,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "mapel": mapel == null ? null : mapel,
        "nama": nama == null ? null : nama,
      };
}
