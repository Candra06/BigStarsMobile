import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:http/http.dart' as http;

class MapelService {
  String urlMapel = EndPoint.mapel;
  String urlCreate = EndPoint.mCreate;

  Future<List<MapelModel>> getData(String token) async {
    var response = await http.get(Uri.parse(urlMapel), headers: {
      "Authorization": token,
    });
    // print(urlMapel);
    // print(token);
    // print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      List<MapelModel> listMapel = [];
      for (var item in data) {
        listMapel.add(MapelModel.fromJson(item));
      }
      return listMapel;
      // print(listMapel);
    } else {
      throw Exception("Gagal Memuat data");
    }
  }

  Future<bool> tambahMapel(String token, String namaMapel) async {
    var body = {
      "mapel": namaMapel,
    };
    var header = {
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
}
