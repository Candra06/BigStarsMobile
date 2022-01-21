import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/DetailSpp_model.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';
import 'package:bigstars_mobile/model/finance_model.dart';
import 'package:bigstars_mobile/model/spp_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FinanceService {
  Future<List<FeeGuruModel>> feeGuru() async {
    DateTime now = new DateTime.now();
    String nowFormat = DateFormat.ABBR_MONTH;
    var token = await Pref.getToken();
    var response = await http.get(
      Uri.parse(EndPoint.fee),
      headers: {'Authorization': token},
    );

    if (response.statusCode == 200) {
      List fee = jsonDecode(response.body)["data"];
      return fee.map((e) => FeeGuruModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<SppModel>> spp() async {
    var token = await Pref.getToken();
    var response = await http
        .get(Uri.parse(EndPoint.spp), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      List fee = jsonDecode(response.body)["data"];
      return fee.map((e) => SppModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<SppModel>> filterSpp(String param) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.filterSpp + param),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      List fee = jsonDecode(response.body)["data"];
      return fee.map((e) => SppModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<FinanceModel> indexFinance() async {
    var token = await Pref.getToken();
    var response = await http.get(
      Uri.parse(EndPoint.finance + '2022-01-24'),
      headers: {"authorization": token},
    );

    if (response.statusCode == 200) {
      return FinanceModel.fromJson(jsonDecode(response.body)["data"]);
    }
  }

  Future generateFee() async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.generateFee),
        headers: {'Authorization': token});
    print(response.body);
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future generateSpp() async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.generateSpp),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future detailSpp(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.detailSpp + id),
        headers: {'Authorization': token});
    if (response.statusCode == 200) {
      DetailSPPModel detailSPPModel =
          DetailSPPModel.fromJson(jsonDecode(response.body)["data"]);
      return detailSPPModel;
    }
    return null;
  }

  Future<bool> konfirmasiFee(String id) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.konfirmasiFee + id),
        headers: {'Authorization': token});

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> konfirmasiSPP(String id) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.konfirmasiSPP + id),
        headers: {'Authorization': token});

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }
}
