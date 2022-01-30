import 'dart:io';

import 'package:bigstars_mobile/model/dashboardGuru_model.dart';
import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/dashboard_wali.dart';
import 'package:bigstars_mobile/model/kelasToday_model.dart';
import 'package:bigstars_mobile/model/notif_model.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/service/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
// import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  // inisialiasi
  UserModel _user;
  DashboardModel _dashboardModel;
  DashboardGuruModel _dashboardGuruModel;
  DashboardWaliModel _dashboardWali;
  List<KelasTodayModel> _listKelasToday;
  List<KelasTodayGuru> _listKelasTodayGuru;

  List<NotifikasiModel> _listNotifikasi = [];

  // getting
  DashboardModel get dashboardModel => _dashboardModel;
  DashboardGuruModel get dashboardGuruModel => _dashboardGuruModel;
  DashboardWaliModel get dashboardWaliModel => _dashboardWali;
  List<KelasTodayModel> get listKelasToday => _listKelasToday;
  List<KelasTodayGuru> get listKelasTodayGuru => _listKelasTodayGuru;
  List<NotifikasiModel> get listNotif => _listNotifikasi;
  UserModel get user => _user;

  void setUser(UserModel userModel) {
    _user = userModel;
    notifyListeners();
  }

  Future<Map<dynamic, dynamic>> login({
    String username,
    String password,
  }) async {
    try {
      UserModel userModel =
          await AuthService().login(username: username, password: password);
      _user = userModel;
      notifyListeners();
      return {
        "status": true,
        "message": "Berhasil Login",
      };
    } catch (e) {
      return {
        "status": false,
        "message": e.toString(),
      };
    }
  }

  Future<bool> editProfilAdmin({UserModel user, String password}) async {
    try {
      bool status = await AuthService().updateProfileAdmin(user: user);
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> editProfilWali({UserModel user}) async {
    try {
      bool status = await AuthService().updateProfileWali(user: user);
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<List<NotifikasiModel>> getNotif() async {
    try {
      List<NotifikasiModel> list = await AuthService().notifikasiList();
      notifyListeners();
      _listNotifikasi = list;
      return _listNotifikasi;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<bool> readNotif({String id}) async {
    try {
      bool status = await AuthService().readNotif(id: id);
      List<NotifikasiModel> list = await AuthService().notifikasiList();
      _listNotifikasi = list;
      _dashboardModel = await AuthService().dahsboardData();
      notifyListeners();
      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<Map<dynamic, dynamic>> editFoto(File image) async {
    try {
      UserModel data = await AuthService().updateFoto(image);
      notifyListeners();
      return {
        "status": true,
        "message": "Berhasil mengubah foto",
        "data": data,
      };
    } catch (e) {
      print(e);
      return {
        "status": false,
        "message": e.toString(),
      };
    }
  }

  Future logout() async {
    try {
      String status = await AuthService().logout();
      return status;
    } catch (e) {
      print(e);
      return "Terjadi kesalahan.";
    }
  }

  Future<DashboardModel> getDashboard() async {
    _dashboardModel = await AuthService().dahsboardData();

    notifyListeners();
    return _dashboardModel;
  }

  Future getDashboardGuru() async {
    _dashboardGuruModel = await AuthService().dashboardGuru();
    notifyListeners();
    return "ok";
  }

  Future getDashboardWali() async {
    _dashboardWali = await AuthService().getDashboardWali();
    notifyListeners();
    return _dashboardWali;
  }
}
