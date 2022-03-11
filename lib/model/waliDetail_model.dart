class DetailWali {
    DetailWali({
        this.statusCode,
        this.message,
        this.data,
    });

    int statusCode;
    String message;
    Data data;

    factory DetailWali.fromJson(Map<String, dynamic> json) => DetailWali(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
    };
}

class Data {
    Data({
        this.detail,
        this.siswa,
    });

    Detail detail;
    List<Siswa> siswa;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        detail: json["detail"] == null ? null : Detail.fromJson(json["detail"]),
        siswa: json["siswa"] == null ? null : List<Siswa>.from(json["siswa"].map((x) => Siswa.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "detail": detail == null ? null : detail.toJson(),
        "siswa": siswa == null ? null : List<dynamic>.from(siswa.map((x) => x.toJson())),
    };
}

class Detail {
    Detail({
        this.id,
        this.idUsers,
        this.nama,
        this.alamat,
        this.createdAt,
        this.updatedAt,
        this.username,
        this.phone,
        this.status,
    });

    int id;
    int idUsers;
    String nama;
    String alamat;
    DateTime createdAt;
    DateTime updatedAt;
    String username;
    String phone;
    String status;

    factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        id: json["id"] == null ? null : json["id"],
        idUsers: json["id_users"] == null ? null : json["id_users"],
        nama: json["nama"] == null ? null : json["nama"],
        alamat: json["alamat"] == null ? null : json["alamat"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
        username: json["username"] == null ? null : json["username"],
        phone: json["phone"] == null ? null : json["phone"],
        status: json["status"] == null ? null : json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_users": idUsers == null ? null : idUsers,
        "nama": nama == null ? null : nama,
        "alamat": alamat == null ? null : alamat,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
        "username": username == null ? null : username,
        "phone": phone == null ? null : phone,
        "status": status == null ? null : status,
    };
}

class Siswa {
    Siswa({
        this.id,
        this.idWali,
        this.kodeReferal,
        this.nama,
        this.birthDate,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String idWali;
    String kodeReferal;
    String nama;
    DateTime birthDate;
    String status;
    DateTime createdAt;
    DateTime updatedAt;

    factory Siswa.fromJson(Map<String, dynamic> json) => Siswa(
        id: json["id"] == null ? null : json["id"],
        idWali: json["id_wali"] == null ? null : json["id_wali"],
        kodeReferal: json["kode_referal"] == null ? null : json["kode_referal"],
        nama: json["nama"] == null ? null : json["nama"],
        birthDate: json["birth_date"] == null ? null : DateTime.parse(json["birth_date"]),
        status: json["status"] == null ? null : json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "id_wali": idWali == null ? null : idWali,
        "kode_referal": kodeReferal == null ? null : kodeReferal,
        "nama": nama == null ? null : nama,
        "birth_date": birthDate == null ? null : "${birthDate.year.toString().padLeft(4, '0')}-${birthDate.month.toString().padLeft(2, '0')}-${birthDate.day.toString().padLeft(2, '0')}",
        "status": status == null ? null : status,
        "created_at": createdAt == null ? null : createdAt.toIso8601String(),
        "updated_at": updatedAt == null ? null : updatedAt.toIso8601String(),
    };
}
