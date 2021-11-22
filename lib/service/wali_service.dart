import 'dart:convert';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/wali_model.dart';
import 'package:http/http.dart' as http;

class WaliService {
  Future<List<WaliModel>> getWalis() async {
    var token = await Pref.getToken();
    var response = await http
        .get(Uri.parse(EndPoint.wali), headers: {'Authorization': token});

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      List<WaliModel> walis =
          data.map((item) => WaliModel.fromJson(item)).toList();
      return walis;
    } else {
      return [];
    }
  }
}
