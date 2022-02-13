import 'dart:convert';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/detailWali_model.dart';
import 'package:bigstars_mobile/model/wali_model.dart';
import 'package:http/http.dart' as http;

class WaliService {
  Future<List<WaliModel>> getWalis() async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.wali), headers: {'Authorization': token});

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      List<WaliModel> walis = data.map((item) => WaliModel.fromJson(item)).toList();
      return walis;
    } else {
      return [];
    }
  }

  Future<DetailWali> getDetail(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.wDetail + id), headers: {'Authorization': token});

    print(response.body);
    if (response.statusCode == 200) {
      var data = await jsonDecode(response.body);
      DetailWali detailWali = DetailWali.fromJson(data['data']);
      return detailWali;
    } else {
      return null;
    }
  }

  Future addSiswaByWali(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    print(data);
    var response = await http.post(Uri.parse(EndPoint.createByWali), headers: {'Authorization': token}, body: data);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    }
    return data;
  }

  Future editWali(String id, Map<String, dynamic> data) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.wUpadate + id), headers: {'Authorization': token}, body: data);
    print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }

  Future deleteWali(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.wDelete + id), headers: {'Authorization': token});
    print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }
}
