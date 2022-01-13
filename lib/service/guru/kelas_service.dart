import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:http/http.dart' as http;

class KelasService {
  Future<List<KelasModel>> getAllKelas() async {
    var token = await Pref.getToken();
    var response = await http
        .get(Uri.parse(EndPoint.kelas), headers: {"authorization": token});
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => KelasModel.fromJson(e)).toList();
    }
    return [];
  }

  Future<List<KehadiranModel>> getKehadiran(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.kehadiran + id),
        headers: {"authorization": token});
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      print(data);
      return data.map((e) => KehadiranModel.fromJson(e)).toList();
    }
    return [];
  }

  Future addKehadiran(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.addKehadiran + id),
        headers: {'Authorization': token}, body: data);
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
    var response = await http.post(Uri.parse(EndPoint.addKelas),
        headers: {'Authorization': token}, body: data);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<List<JadwalModel>> getDetail(int id) async {
    var token = await Pref.getToken();
    var response = await http.get(
        Uri.parse(EndPoint.kelasDetail + id.toString()),
        headers: {'Authorization': token});

    if (response.statusCode == 200) {
      // List data = jsonDecode(response.body)["data"];
      // print(jsonDecode(response.body)["hari"]);
      List data = jsonDecode(response.body)["hari"];
      List<JadwalModel> result =
          data.map((e) => JadwalModel.fromJson(e)).toList();
      return result;
    }
  }

  Future deleteJadwal(int id) async {
    var token = await Pref.getToken();
    var response = await http.get(
        Uri.parse(EndPoint.deleteJadwal + id.toString()),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }
}
