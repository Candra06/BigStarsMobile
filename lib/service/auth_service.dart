import 'dart:convert';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/kelasToday_model.dart';
import 'package:http/http.dart' as http;
import 'package:bigstars_mobile/model/user_model.dart';

class AuthService {
  String url = EndPoint.login;

  Future<UserModel> login({
    String username,
    String password,
  }) async {
    var body = {'username': username, 'password': password};
    var response = await http.post(Uri.parse(url), body: body);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      if (data["status_code"] == 200) {
        UserModel userModel = UserModel.fromJson(data["data"]);
        userModel.token = data["token_type"] + " " + data["access_token"];
        return userModel;
      } else {
        throw Exception('username dan password salah');
      }
    } else {
      throw Exception('Server lagi bermasalah');
    }
  }

  Future logout() async {
    var token = await Pref.getToken();
    var response = await http
        .post(Uri.parse(EndPoint.logout), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Logged out") {
        return jsonDecode(response.body)["message"];
      }
    }
    return "gagal logout";
  }

  Future<DashboardModel> dahsboardData() async {
    var token = await Pref.getToken();
    var response = await http
        .get(Uri.parse(EndPoint.dashboard), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      return DashboardModel.fromJson(jsonDecode(response.body)["data"]);
    }
  }

  Future<List<KelasTodayModel>> kelasToday() async {
    var token = await Pref.getToken();
    var response = await http
        .get(Uri.parse(EndPoint.dashboard), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"]["kelas_today"];
      return data.map((e) => KelasTodayModel.fromJson(e)).toList();
    }
  }
}
