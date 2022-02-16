import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/rules_model.dart';
import 'package:http/http.dart' as http;

class RuleService {
  Future<List<RulesModel>> getData() async {
    var token = await Pref.getToken();
    http.Response response = await http.get(Uri.parse(EndPoint.listRules), headers: {
      "Authorization": token,
    });

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body)["data"];

      return data.map((e) => RulesModel.fromJson(e)).toList();
    } else {
      throw Exception("Gagal Memuat data");
    }
  }

  Future<RulesModel> detail(String param) async {
    var token = await Pref.getToken();
    http.Response response = await http.get(EndPoint.detailRules + param, headers: {'Authorization': token});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["data"] != null) {
        RulesModel rulesModel = RulesModel.fromJson(jsonDecode(response.body)["data"]);
        return rulesModel;
      } else {
        throw Exception("data kosong");
      }
    } else {
      throw Exception("Gagal memuat data");
    }
  }

  Future<bool> updateRules(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();

    http.Response response = await http.post(Uri.parse(EndPoint.updateRules + id), headers: {'Authorization': token}, body: data);
    if (response.statusCode == 200 && jsonDecode(response.body)["message"] == "Success") {
      return true;
    } else {
      return false;
    }
  }
}
