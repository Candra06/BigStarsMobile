import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:http/http.dart' as http;

class GuruService {
  Future<List<GuruModel>> getdata() async {
    var token = await Pref.getToken();
    var response = await http
        .get(Uri.parse(EndPoint.guru), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["data"];
      return data.map((e) => GuruModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future tambahGuru(Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    var response = await http.post(
      Uri.parse(EndPoint.gCreate),
      headers: {'Authorization': token},
      body: data,
    );
    print(response.body);
    if (response.statusCode == 200 &&
        jsonDecode(response.body)["message"] == "Success") {
      return jsonDecode(response.body);
    } else {
      return {
        "status_code": jsonDecode(response.body)["status_code"],
        "message": "Username & Nomer HP kemungkinan telah dipakai"
      };
    }
  }
}
