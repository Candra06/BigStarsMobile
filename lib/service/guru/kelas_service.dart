import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/absensi_model.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/model/detaiKelas_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:http/http.dart' as http;

class KelasService {
  Future<List<KelasModel>> getAllKelas(String filter) async {
    var token = await Pref.getToken();
    String url = '';
    if (filter != '') {
      url = EndPoint.kelas + '?' + filter;
    } else {
      url = EndPoint.kelas;
    }
    print(url);
    var response = await http.get(Uri.parse(url), headers: {"authorization": token});

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => KelasModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<KehadiranModel>> getKehadiran(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.kehadiran + id.toString()), headers: {"authorization": token});
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => KehadiranModel.fromJson(e)).toList();
    }
    return [];
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
      DetailKelasModel detailKelas = DetailKelasModel.fromJson(jsonDecode(response.body)["data"]);

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
    var response = await http.get(Uri.parse(EndPoint.filterKelas + param),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => KelasModel.fromJson(e)).toList();
    }
    return [];
  }
}
