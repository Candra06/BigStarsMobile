import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/service/siswa_service.dart';
import 'package:flutter/widgets.dart';

class SiswaProvider with ChangeNotifier {
  List<SiswaModel> _listSiswa;
  get listSiswa => _listSiswa;
  Future<List<SiswaModel>> getSiswa() async {
    List<SiswaModel> data = await SiswaService().getSiswas();
    _listSiswa = data;
    notifyListeners();
    return data;
  }

  Future<bool> deleteSiswa(String id) async {
    try {
      bool status = await SiswaService().delSiswa(id);
      List<SiswaModel> data = await SiswaService().getSiswas();
      _listSiswa = data;
      notifyListeners();
      return status;
    } catch (e) {
      return false;
    }
  }
}
