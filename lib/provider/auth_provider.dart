import 'dart:io';

import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/kelasToday_model.dart';
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/service/auth_service.dart';
import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  DashboardModel _dashboardModel;
  List<KelasTodayModel> _listKelasToday;
  DashboardModel get dashboardModel => _dashboardModel;
  List<KelasTodayModel> get listKelasToday => _listKelasToday;
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
      UserModel userModel = await AuthService().login(username: username, password: password);
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

  Future<Map<dynamic, dynamic>> editFoto(File image) async {
    try {
      UserModel data = await AuthService().updateFoto(image);
      // _user = data;
      // print(data.toJson());
      // print("auth");
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
}
