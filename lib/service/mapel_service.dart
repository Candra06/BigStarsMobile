import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:http/http.dart' as http;

class MapelService {
  String urlMapel = EndPoint.mapel;
  String urlCreate = EndPoint.mCreate;
  String urlDelete = EndPoint.mDelete;
  String urlDetail = EndPoint.mDetail;
  String urlUpdate = EndPoint.mUpdate;

  Future<List<MapelModel>> getData() async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(urlMapel), headers: {
      "Authorization": token,
    });
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      List<MapelModel> listMapel = [];
      for (var item in data) {
        listMapel.add(MapelModel.fromJson(item));
      }
      return listMapel;
    } else {
      throw Exception("Gagal Memuat data");
    }
  }

  Future<bool> tambahMapel(String namaMapel) async {
    var token = await Pref.getToken();
    var body = {
      "mapel": namaMapel,
    };
    Map<String, String> header = {
      "Authorization": token,
    };
    var response =
        await http.post(Uri.parse(urlCreate), headers: header, body: body);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> hapusMapel(String id) async {
    var token = await Pref.getToken();

    var response = await http.get(Uri.parse(EndPoint.mDelete + id),
        headers: {'Authorization': token});

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<MapelModel> detail(String id) async {
    var token = await Pref.getToken();
    var response =
        await http.get(urlDetail + id, headers: {'Authorization': token});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["data"] != null) {
        MapelModel mapelModel =
            MapelModel.fromJson(jsonDecode(response.body)["data"]);
        return mapelModel;
      } else {
        throw Exception("data kosong");
      }
    } else {
      throw Exception("Gagal memuat data");
    }
  }

  Future<bool> updateMapel(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();

    var response = await http.post(Uri.parse(urlUpdate + id),
        headers: {'Authorization': token}, body: data);
    if (response.statusCode == 200 &&
        jsonDecode(response.body)["message"] == "Success") {
      return true;
    } else {
      return false;
    }
  }
}
