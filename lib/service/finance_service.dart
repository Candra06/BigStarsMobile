import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';
import 'package:bigstars_mobile/model/finance_model.dart';
import 'package:http/http.dart' as http;

class FinanceService {
  Future<List<FeeGuruModel>> feeGuru() async {
    var token = await Pref.getToken();
    var response = await http.get(
        Uri.parse('http://api.buildandservice.com/api/finance/list-fee'),
        headers: {'Authorization': token});
    print(token);
    if (response.statusCode == 200) {
      List fee = jsonDecode(response.body)["data"];
      return fee.map((e) => FeeGuruModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<FinanceModel> indexFinance() async {
    var token = await Pref.getToken();
    var response = await http.get(
      Uri.parse(EndPoint.finance + '2021-11-24'),
      headers: {"authorization": token},
    );

    if (response.statusCode == 200) {
      return FinanceModel.fromJson(jsonDecode(response.body)["data"]);
    }
  }
}
