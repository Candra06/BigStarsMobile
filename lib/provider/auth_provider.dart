import 'package:bigstars_mobile/model/user_model.dart';
import 'package:bigstars_mobile/service/auth_service.dart';
import 'package:flutter/widgets.dart';
// import 'package:provider/provider.dart';

class AuthProvider with ChangeNotifier {
  UserModel _user;
  UserModel get user => _user;

  // set user(UserModel user) {
  //   _user = user;
  //   notifyListeners();
  // }

  void setUser(UserModel userModel) {
    _user = userModel;
    // notifyListeners();
  }

  Future<Map<dynamic, dynamic>> login({
    String username,
    String password,
  }) async {
    try {
      UserModel userModel =
          await AuthService().login(username: username, password: password);
      _user = userModel;
      return {
        "status": true,
        "message": "Berhasil Login",
      };
    } catch (e) {
      return {
        "status": false,
        "message": e.toString(),
      };
      ;
    }
  }
}
