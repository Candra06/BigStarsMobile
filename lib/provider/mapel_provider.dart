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

  Future<void> getMapels(token) async {
    try {
      List<MapelModel> mapels = await MapelService().getData(token);
      _mapels = mapels;
      // for (var item in _mapels) {
      //   print(item.mapel);
      // }
    } catch (e) {
      print(e);
    }
  }

  Future<void> tambahMapel(String token, String namaMapel) async {
    try {
      bool status = await MapelService().tambahMapel(token, namaMapel);
      print(status);
    } catch (e) {
      print(e);
    }
  }
}
