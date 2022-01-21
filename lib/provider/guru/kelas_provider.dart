import 'package:bigstars_mobile/model/absensi_model.dart';
import 'package:bigstars_mobile/model/detaiKelas_model.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:bigstars_mobile/service/guru/kelas_service.dart';

import 'package:provider/provider.dart';
import 'package:flutter/widgets.dart';

class KelasProvider with ChangeNotifier {
  List<KelasModel> _allKelas = [];

  List<Absensi> _absensiList = [];
  List<KehadiranModel> _listKehadiranModel = [];
  DetailKelasModel _detailKelasModel;
  KelasModel _kelasModel;
  KehadiranModel _kehadiranModel;
  DetailKelas detailKelas;

  DetailKelasModel get detailKelasModel => _detailKelasModel;
  KelasModel get kelasModel => _kelasModel;
  List<KelasModel> get allKelas => _allKelas;
  List<KehadiranModel> get listKehadiranModel => _listKehadiranModel;

  List<Absensi> get listAbsensi => _absensiList;

  BuildContext get context => null;

  Future<List<KelasModel>> getKelas({String filtered}) async {
    try {
      print(filtered);
      List<KelasModel> data = await KelasService().getAllKelas(filtered);
      _allKelas = data;
      notifyListeners();
      return _allKelas;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<Absensi>> getAbsensi(String id) async {
    try {
      List<Absensi> data = await KelasService().getAbsensi(id.toString());
      print(id);
      _absensiList = data;
      notifyListeners();
      return _absensiList;
    } catch (e) {
      print('errornya ' + e.toString());
      return [];
    }
  }

  Future<List<KehadiranModel>> getKehadiran(String id) async {
    try {
      _listKehadiranModel = await KelasService().getKehadiran(id);
      notifyListeners();
      return _listKehadiranModel;
    } catch (e) {
      return [];
    }
  }

  Future<DetailKelasModel> getDetail(String id) async {
    try {
      _detailKelasModel = await KelasService().getDetail(id);
      notifyListeners();
      return _detailKelasModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DetailKelas> getDetailAdmin(int id) async {
    try {
      detailKelas = await KelasService().getDetailKelas(id);
      notifyListeners();

      return detailKelas;
    } catch (e) {
      print(e);
      return detailKelas;
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
      getDetail(id.toString());
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addJadwal(String id, Map<String, dynamic> data) async {
    bool status = await KelasService().addJadwal(id, data);
    getDetail(id);
    return status;
  }
}
