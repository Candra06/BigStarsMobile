import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/model/wali_model.dart';

class DetailWali {
  DetailWali({
    this.detail,
    this.siswa,
  });

  WaliModel detail;
  List<SiswaModel> siswa;

  factory DetailWali.fromJson(Map<String, dynamic> json) => DetailWali(
        detail: WaliModel.fromJson(json["detail"]),
        siswa: List<SiswaModel>.from(
            json["siswa"].map((x) => SiswaModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "wali": detail.toJson(),
        "siswa": List<dynamic>.from(siswa.map((x) => x.toJson())),
      };
}
