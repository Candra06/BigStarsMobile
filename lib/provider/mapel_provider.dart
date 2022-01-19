import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/service/mapel_service.dart';
import 'package:flutter/widgets.dart';

class MapelProvider with ChangeNotifier {
  MapelModel _mapelModel;
  List<MapelModel> _mapels = [];
  MapelModel get mapel => _mapelModel;
  List<MapelModel> get mapels => _mapels;
  set mapels(List<MapelModel> mapels) {
    _mapels = mapels;
    notifyListeners();
  }

  set mapel(MapelModel mapelModel) {
    _mapelModel = mapelModel;
    notifyListeners();
  }

  Future getMapel(String id) async {
    MapelModel mapel = await MapelService().detail(id);
    _mapelModel = mapel;
    notifyListeners();
  }

  Future<List<MapelModel>> getMapels() async {
    try {
      List<MapelModel> mapels = await MapelService().getData();
      _mapels = mapels;
      // for (var item in _mapels) {
      //   print(item.mapel);
      // }
      notifyListeners();
      return mapels;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> tambahMapel(String namaMapel) async {
    try {
      bool status = await MapelService().tambahMapel(namaMapel);
      List<MapelModel> mapels = await MapelService().getData();
      _mapels = mapels;
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> hapusMapel(String id) async {
    bool status = await MapelService().hapusMapel(id);
    if (status) {
      try {
        List<MapelModel> mapels = await MapelService().getData();
        _mapels = mapels;
        notifyListeners();
        return true;
      } catch (e) {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> updateMapel(String id, Map<String, dynamic> data) async {
    try {
      bool status = await MapelService().updateMapel(id, data);
      List<MapelModel> mapels = await MapelService().getData();
      _mapels = mapels;
      MapelModel mapel = await MapelService().detail(id);
      _mapelModel = mapel;
      notifyListeners();
      return status;
    } catch (e) {
      return false;
    }
  }
}
