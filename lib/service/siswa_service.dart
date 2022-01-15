import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:http/http.dart' as http;

class SiswaService {
  Future<List<SiswaModel>> getSiswas() async {
    var token = await Pref.getToken();
    var response = await http.get(
      Uri.parse(EndPoint.siswa),
      headers: {
        'Authorization': token,
      },
    );
    print(response.body);
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      List<SiswaModel> siswas = data.map((item) => SiswaModel.fromJson(item)).toList();
      return siswas;
    } else {
      return [];
    }
  }

  Future<bool> delSiswa(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.sDelete + id), headers: {'Authorization': token});
    print(response.statusCode);
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future addSiswa(Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.sCreate), headers: {'Authorization': token}, body: data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      return {"message": "Failed"};
    }
  }
}
