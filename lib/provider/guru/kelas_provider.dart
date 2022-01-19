import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/service/guru/kelas_service.dart';

import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class KelasProvider with ChangeNotifier {
  List<KelasModel> _allKelas = [];
  List<JadwalModel> _allJadwal = [];
  List<KehadiranModel> _listKehadiranModel = [];
  KelasModel _kelasModel;
  KehadiranModel _kehadiranModel;

  KelasModel get kelasModel => _kelasModel;
  List<KelasModel> get allKelas => _allKelas;
  List<KehadiranModel> get listKehadiranModel => _listKehadiranModel;
  List<JadwalModel> get allJadwal => _allJadwal;

  BuildContext get context => null;

  Future<List<KelasModel>> getKelas() async {
    try {
      List<KelasModel> data = await KelasService().getAllKelas();
      _allKelas = data;
      notifyListeners();
      return _allKelas;
    } catch (e) {
      print("ok");
    }
  }

  Future<List<KehadiranModel>> getKehadiran(String id) async {
    try {
      _listKehadiranModel = await KelasService().getKehadiran(id);
      notifyListeners();
      return _listKehadiranModel;
    } catch (e) {
      print("ok");
      print(e);
    }
  }

  Future getDetail(int id) async {
    try {
      _allJadwal = await KelasService().getDetail(id);
      notifyListeners();

      return _allJadwal;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addKelas(Map<String, dynamic> data) async {
    try {
      bool status = await KelasService().addKelas(data);
      _allKelas = await getKelas();

      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future addKehadiran(String id, Map<String, dynamic> data) async {
    bool status = await KelasService().addKehadiran(id, data);
    _listKehadiranModel = await getKehadiran(id);
    notifyListeners();
    return status;
  }

  Future deleteJadwal(int id) async {
    try {
      bool status = await KelasService().deleteJadwal(id);
      getDetail(id);
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
