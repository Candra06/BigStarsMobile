import 'dart:convert';

import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/DetailFee_model.dart';
import 'package:bigstars_mobile/model/DetailSpp_model.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';
import 'package:bigstars_mobile/model/finance_model.dart';
import 'package:bigstars_mobile/model/report_model.dart';
import 'package:bigstars_mobile/model/spp_model.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class FinanceService {
  Future<List<FeeGuruModel>> feeGuru(String filtered) async {
    String url = '';
    if (filtered != '') {
      url = EndPoint.fee + '?' + filtered;
    } else {
      url = EndPoint.fee;
    }
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(url), headers: {'Authorization': token});
    print(response.body);
    if (response.statusCode == 200) {
      List fee = jsonDecode(response.body)["data"];
      return fee.map((e) => FeeGuruModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<SppModel>> spp(String filtered) async {
    var token = await Pref.getToken();
    String url = '';
    if (filtered != '') {
      url = EndPoint.spp + '?' + filtered;
    } else {
      url = EndPoint.spp;
    }
    var response = await http.get(Uri.parse(url), headers: {'Authorization': token});
    print(response.body);
    if (response.statusCode == 200) {
      List fee = jsonDecode(response.body)["data"];
      return fee.map((e) => SppModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<List<ReportModel>> report(String filtered) async {
    var token = await Pref.getToken();
    String url = '';
    if (filtered != '') {
      url = EndPoint.report + '?' + filtered;
    } else {
      url = EndPoint.report;
    }

    var response = await http.get(Uri.parse(url), headers: {'Authorization': token});
    print(response.body);
    if (response.statusCode == 200) {
      List fee = jsonDecode(response.body)["data"];
      return fee.map((e) => ReportModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<FinanceModel> indexFinance(String filtered) async {
    DateTime now = DateTime.now();
    String bulan = DateFormat('MM').format(now);
    String tahun = DateFormat('yyyy').format(now);
    String url = '';
    if (filtered != '') {
      url = EndPoint.finance + '?' + filtered;
    } else {
      url = EndPoint.finance + '?bulan=' + bulan + '&tahun=' + tahun;
    }
    var token = await Pref.getToken();
    var response = await http.get(
      Uri.parse(url),
      headers: {"authorization": token},
    );

    if (response.statusCode == 200) {
      return FinanceModel.fromJson(jsonDecode(response.body)["data"]);
    } else {
      return null;
    }
  }

  Future generateFee() async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.generateFee), headers: {'Authorization': token});
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
    var response = await http.get(Uri.parse(EndPoint.generateSpp), headers: {'Authorization': token});
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
    var response = await http.get(Uri.parse(EndPoint.detailSpp + id), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      DetailSPPModel detailSPPModel = DetailSPPModel.fromJson(jsonDecode(response.body)["data"]);
      return detailSPPModel;
    }
    return null;
  }

  Future detailFee(String id) async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.detailFee + id), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      
      DetailFeeModel detailFee = DetailFeeModel.fromJson(jsonDecode(response.body)["data"]);
      return detailFee;
    } else {
      return null;
    }
  }

  Future<bool> konfirmasiFee(String id) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.konfirmasiFee + id), headers: {'Authorization': token});

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }

  Future<bool> konfirmasiSPP(String id) async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.konfirmasiSPP + id), headers: {'Authorization': token});

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      }
    }
    return false;
  }
}
