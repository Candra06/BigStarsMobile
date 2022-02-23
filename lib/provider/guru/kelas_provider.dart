import 'dart:io';

import 'package:bigstars_mobile/model/absensi_model.dart';
import 'package:bigstars_mobile/model/detaiKelas_model.dart';
import 'package:bigstars_mobile/model/detail_model.dart';
import 'package:bigstars_mobile/model/guru/kelas.dart';
import 'package:bigstars_mobile/model/jadwal_model.dart';
import 'package:bigstars_mobile/model/kehadiran_model.dart';
import 'package:bigstars_mobile/service/guru/kelas_service.dart';

import 'package:flutter/widgets.dart';

class KelasProvider with ChangeNotifier {
  List<KelasModel> _allKelas = [];

  List<Absensi> _absensiList = [];
  DetailKelasModel _detailKelasModel;
  KelasModel _kelasModel;
  KehadiranModel _kehadiranModel;
  DetailKelas detailKelas;
  DetailKelasModel detailKelasAdmin;

  DetailKelasModel get detailKelasModel => _detailKelasModel;
  KelasModel get kelasModel => _kelasModel;
  List<KelasModel> get allKelas => _allKelas;
  KehadiranModel get kehadiranModel => _kehadiranModel;

  List<Absensi> get listAbsensi => _absensiList;

  BuildContext get context => null;

  Future<List<KelasModel>> getKelas({String filtered}) async {
    try {
      // print(filtered);
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

  Future<KehadiranModel> getKehadiran(String id) async {
    try {
      _kehadiranModel = await KelasService().getKehadiran(id);

      notifyListeners();
      return _kehadiranModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<List<KelasModel>> getFilterKelas(String param) async {
    _allKelas = await KelasService().filterKelas(param);
    notifyListeners();
    return _allKelas;
  }

  Future<DetailKelasModel> getDetail(String id) async {
    try {
      _detailKelasModel = await KelasService().getDetail(id);
      notifyListeners();
      print(_detailKelasModel.message);
      return _detailKelasModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<DetailKelasModel> getDetailAdmin(int id) async {
    try {
      detailKelasAdmin = await KelasService().getDetailKelas(id);
      notifyListeners();

      return detailKelasAdmin;
    } catch (e) {
      print(e);
      return detailKelasAdmin;
    }
  }

  Future<bool> addKelas(Map<String, dynamic> data) async {
    try {
      bool status = await KelasService().addKelas(data);
      getKelas();

      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateKelas(Map<String, dynamic> data, String id) async {
    try {
      bool status = await KelasService().updateKelas(id, data);
      getKelas();

      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future addKehadiran(String id, Map<String, dynamic> data) async {
    bool status = await KelasService().addKehadiran(id, data);
    _kehadiranModel = await getKehadiran(id);
    notifyListeners();
    return status;
  }

  Future<bool> addKehadiranGuru(String id, Map<String, dynamic> data) async {
    try {
      bool status = await KelasService().addKehadiranGuru(id, data);

      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> updateKehadiranGuru(String id, Map<String, dynamic> data) async {
    try {
      bool status = await KelasService().updateKehadiranGuru(id, data);

      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> addSharing(String id, var data) async {
    try {
      bool status = await KelasService().addSharing(id, data);
      return status;
    } catch (e) {
      return false;
    }
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

  Future deleteKelas(int id) async {
    try {
      bool status = await KelasService().deleteKelas(id);
      getDetail(id.toString());
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future updateStatusKelas(int id, String status) async {
    try {
      print(status);
      bool res = await KelasService().updateStatusKelas(id, status);
      getDetail(id.toString());
      notifyListeners();
      return res;
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

  Future deleteKehadiran(int id, String idKelas) async {
    try {
      bool status = await KelasService().deleteKehadiran(id);
      getKehadiran(idKelas.toString());
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
