import 'package:bigstars_mobile/model/siswa_model.dart';
import 'package:bigstars_mobile/service/siswa_service.dart';
import 'package:flutter/widgets.dart';

class SiswaProvider with ChangeNotifier {
  List<SiswaModel> _listSiswa;
  List<SiswaModel> get listSiswa => _listSiswa;
  Future<List<SiswaModel>> getSiswa() async {
    try {
      List<SiswaModel> data = await SiswaService().getSiswas();
      _listSiswa = data;
      notifyListeners();
      return data;
    } catch (e) {
      print(e);
      return [];
    }
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

  Future addSiswa(Map<String, dynamic> data) async {
    try {
      var hasil = await SiswaService().addSiswa(data);

      List<SiswaModel> temp = await SiswaService().getSiswas();
      _listSiswa = temp;
      notifyListeners();
      return hasil;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future editSiswa(int id, Map<String, dynamic> data) async {
    bool status = await SiswaService().edit(id, data);
    getSiswa();
    return status;
  }
}
