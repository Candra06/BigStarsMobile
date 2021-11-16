import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/service/mapel_service.dart';
import 'package:flutter/widgets.dart';

class MapelProvider with ChangeNotifier {
  List<MapelModel> _mapels = [];
  List<MapelModel> get mapels => _mapels;
  set mapels(List<MapelModel> mapels) {
    _mapels = mapels;
    notifyListeners();
  }

  Future<bool> getMapels(token) async {
    try {
      List<MapelModel> mapels = await MapelService().getData(token);
      _mapels = mapels;
      // for (var item in _mapels) {
      //   print(item.mapel);
      // }
      // notifyListeners();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> tambahMapel(String token, String namaMapel) async {
    try {
      bool status = await MapelService().tambahMapel(token, namaMapel);
      List<MapelModel> mapels = await MapelService().getData(token);
      _mapels = mapels;
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
