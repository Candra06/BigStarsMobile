import 'dart:convert';
import 'dart:io';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/absensi_model.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

class KelasService {
  Future<List<KelasModel>> getAllKelas(String filter) async {
    var token = await Pref.getToken();
    String url = '';
    print(filter);
    if (filter.isNotEmpty) {
      print('sini');
      url = EndPoint.kelas + '?' + filter;
    } else {
      url = EndPoint.kelas;
    }
    var response = await http.get(Uri.parse(url), headers: {"authorization": token});

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => KelasModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<KehadiranModel> getKehadiran(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.kehadiran + id.toString()), headers: {"authorization": token});
    // print(response.body);
    if (response.statusCode == 200) {
      KehadiranModel data = KehadiranModel.fromJson(jsonDecode(response.body)["data"]);
      return data;
    }
    return null;
  }

  Future<List<Absensi>> getAbsensi(String id) async {
    // print(id);
    var token = await Pref.getToken();
    // print(token);
    var response = await http.get(Uri.parse(EndPoint.absensi + id), headers: {"authorization": token});
    print(EndPoint.absensi + id);
    print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => Absensi.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future addKehadiran(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.addKehadiran + id), headers: {'Authorization': token}, body: data);
    print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future updateKelas(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.updateKelas + id), headers: {'Authorization': token}, body: data);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future addKelas(Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    print(data);
    var response = await http.post(Uri.parse(EndPoint.addKelas), headers: {'Authorization': token}, body: data);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<DetailKelasModel> getDetail(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.kelasDetail + id.toString()), headers: {'Authorization': token});

    if (response.statusCode == 200) {
      DetailKelasModel detailKelas = DetailKelasModel.fromJson(jsonDecode(response.body));
      List data = jsonDecode(response.body)["hari"];
      List<JadwalModel> result = data.map((e) => JadwalModel.fromJson(e)).toList();
      // return result;
      return detailKelas;
    }
    return null;
  }

  Future<DetailKelasModel> getDetailKelas(int id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.kelasDetail + id.toString()), headers: {'Authorization': token});
    print(response.body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      DetailKelasModel detailKelas = DetailKelasModel.fromJson(data);

      return detailKelas;
    }
    return null;
  }

  Future deleteJadwal(int id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.deleteJadwal + id.toString()), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }

  Future deleteKelas(int id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.deleteKelas + id.toString()), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }

  Future updateStatusKelas(int id, String status) async {
    var token = await Pref.getToken();
    Map<dynamic, String> body;
    // body['status'] = status;
    print(body);
    var response = await http.post(Uri.parse(EndPoint.updateStatus + id.toString()), body: {'status': status}, headers: {'Authorization': token});
    if (response.statusCode == 200) {
      print(response.body);
      return true;
    }
    return false;
  }

  Future addJadwal(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.addJadwal + id.toString()), headers: {'Authorization': token}, body: data);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }

  Future filterKelas(String param) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.filterKelas + param), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => KelasModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<Map<String, dynamic>> addKehadiranGuru(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    Map<String, dynamic> hasil = {'status': true, 'message': 'Berhasil menambahkan kehadiran'};
    if (data['file_materi'] == '-') {
      http.Response response = await http.post(Uri.parse(EndPoint.addKehadiranGuru + id), body: data, headers: {'Authorization': token});
      print(response.body);
      var respon = json.decode(response.body);
      if (response.statusCode == 200) {
        respon['status'] = true;
        return respon;
      } else if (respon['status_code'] == 402) {
        respon['status'] = false;
        return respon;
      } else {
        respon['status'] = false;
        return respon;
      }
    } else {
      print('here');
      Map<String, String> headers = {
        'Authorization': token,
      };
      final request = http.MultipartRequest('POST', Uri.parse(EndPoint.addKehadiranGuru + id));
      request.fields["materi"] = data["materi"];
      request.fields["jurnal"] = data["jurnal"];
      request.fields["status"] = data["status"];
      request.fields["poin"] = data["poin"];
      request.fields["latitude"] = data["latitude"];
      request.fields["longitude"] = data["longitude"];
      request.files.add(await http.MultipartFile.fromPath('file_materi', data['file_materi'].path));
      request.headers.addAll(headers);
      var response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          var respon = json.decode(value);
          hasil = respon;
          return respon;
        });
      } else if (response.statusCode == 402) {
        var tmp = {'status': false, 'message': 'Waktu absensi sudah ditutup, silahkan menghubungi admin'};
        hasil = tmp;
        return tmp;
      } else {}
    }
    return hasil;
    // if (response.statusCode == 200) {}
  }

  Future<Map<String, dynamic>> updateKehadiranGuru(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    print(token);
    Map<String, dynamic> hasil = {'status': true, 'message': 'Berhasil menambahkan kehadiran'};
    if (data['file_materi'] == '-') {
      print('sini');
      http.Response response = await http.post(Uri.parse(EndPoint.updateKehadiranGuru + id), body: data, headers: {'Authorization': token});
      print(response.body);
      var respon = json.decode(response.body);
      if (response.statusCode == 200) {
        respon['status'] = true;
        return respon;
      } else if (respon['status_code'] == 402) {
        respon['status'] = false;
        return respon;
      } else {
        respon['status'] = false;
        return respon;
      }
    } else {
      Map<String, String> headers = {
        'Authorization': token,
      };
      final request = http.MultipartRequest('POST', Uri.parse(EndPoint.updateKehadiranGuru + id));
      request.fields["materi"] = data["materi"];
      request.fields["jurnal"] = data["jurnal"];
      request.fields["status"] = data["status"];
      request.fields["poin"] = data["poin"];
      request.fields["latitude"] = data["latitude"];
      request.fields["longitude"] = data["longitude"];
      request.files.add(await http.MultipartFile.fromPath('file_materi', data['file_materi'].path));
      request.headers.addAll(headers);
      var response = await request.send();
      if (response.statusCode == 200) {
        response.stream.transform(utf8.decoder).listen((value) {
          print(value);
          var respon = json.decode(value);
          hasil = respon;
          return respon;
        });
      } else if (response.statusCode == 402) {
        var tmp = {'status': false, 'message': 'Waktu absensi sudah ditutup, silahkan menghubungi admin'};
        hasil = tmp;
        return tmp;
      } else {}
      // response.stream.transform(utf8.decoder).listen((value) {
      //   print(value);
      //   print(data);

      // });
    }

    return hasil;
    // if (response.statusCode == 200) {}
  }

  Future<Map<String, dynamic>> addSharing(String id, var data) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.addSharing + id.toString()),
        headers: {
          'Authorization': token,
        },
        body: data);
    Map<String, dynamic> hasil = {};
    print(response.body);
    var respon = jsonDecode(response.body);
    if (response.statusCode == 200) {
      if (respon['message'] == "Success") {
        hasil['status'] = true;
        hasil['message'] = "Sharing kelas berhasil";
        return hasil;
      } else {
        hasil['status'] = false;
        hasil['message'] = respon['message'];
        return hasil;
      }
    } else {
      hasil['status'] = false;
      hasil['status'] = respon['message'];
      return hasil;
    }
  }

  Future deleteKehadiran(int id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.deleteKehadiran + id.toString()), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      return true;
    }
    return false;
  }
}
