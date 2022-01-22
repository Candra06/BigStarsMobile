import 'package:bigstars_mobile/model/detailWali_model.dart';
import 'package:bigstars_mobile/model/wali_model.dart';
import 'package:bigstars_mobile/service/wali_service.dart';
import 'package:flutter/widgets.dart';

class WaliProvider with ChangeNotifier {
  WaliModel _waliModel;
  DetailWali detailWali;
  List<WaliModel> _waliModels;
  get waliModel => _waliModel;
  get waliModels => _waliModels;
  List<WaliModel> get listWali => _waliModels;
  Future<List<WaliModel>> getWalis() async {
    try {
      List<WaliModel> waliModels = await WaliService().getWalis();
      _waliModels = waliModels;
      notifyListeners();
      return _waliModels;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<DetailWali> getDetail(String id) async {
    try {
      detailWali= await WaliService().getDetail(id);
      return detailWali;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future addSiswaBywali(String id, Map<String, dynamic> data) async {
    return WaliService().addSiswaByWali(id, data);
  }

  Future editWali(String id, Map<String, dynamic> data) async {
    bool status = await WaliService().editWali(id, data);
    getWalis();
    return true;
  }
}
