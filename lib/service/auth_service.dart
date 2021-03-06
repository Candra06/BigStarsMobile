import 'dart:convert';
import 'dart:io';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/dashboardGuru_model.dart';
import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/dashboard_wali.dart';
import 'package:bigstars_mobile/model/notif_model.dart';
import 'package:http/http.dart' as http;
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:async/async.dart';

class AuthService {
  String url = EndPoint.login;

  Future<UserModel> login({
    String username,
    String password,
  }) async {
    var body = {'username': username, 'password': password};
    var response = await http.post(Uri.parse(url), body: body);
    // print(response.body);
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

  Future<Map<String, dynamic>> lupaPassword({
    String username,
  }) async {
    var body = {
      'username': username,
    };
    var response = await http.post(Uri.parse(EndPoint.forgotPassword), body: body);
    // print(response.body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<Map<String, dynamic>> resetPassword({
    String password,
    String id,
  }) async {
    var body = {
      'id': id,
      'password': password,
    };
    var response = await http.post(Uri.parse(EndPoint.resetPassword), body: body);
    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return data;
    } else {
      return data;
    }
  }

  Future<bool> updateProfileAdmin({UserModel user}) async {
    var token = await Pref.getToken();
    var body;

    if (user.password.isNotEmpty) {
      body = user.editProfilAdmin();
    } else {
      body = user.editProfilAdminNoPass();
    }
    var response = await http.post(Uri.parse(EndPoint.editProfilAdm), headers: {'Authorization': token}, body: body);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<bool> updateProfileWali({UserModel user}) async {
    var token = await Pref.getToken();
    var body;

    if (user.password.isNotEmpty) {
      body = user.editProfilWali();
    } else {
      body = user.editProfilWaliNoPass();
    }
    var response = await http.post(Uri.parse(EndPoint.editProfilWali), headers: {'Authorization': token}, body: body);

    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Success") {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  Future<UserModel> updateFoto(File foto) async {
    var token = await Pref.getToken();
    var stream = new http.ByteStream(DelegatingStream.typed(foto.openRead()));
    Map<String, String> headers = {
      'Authorization': token,
    };
    final request = http.MultipartRequest('POST', Uri.parse(EndPoint.editFoto));
    request.files.add(await http.MultipartFile.fromPath('foto', foto.path));
    request.headers.addAll(headers);
    var response = await request.send();

    SharedPreferences pref = await SharedPreferences.getInstance();
    if (response.statusCode == 200) {
      response.stream.transform(utf8.decoder).listen((value) {
        // print(value);
        var data = json.decode(value);

        UserModel userModel = UserModel.fromJson(data["data"]);
        pref.setString('foto', data["data"]["foto"]);
        return userModel;
      });
    } else {
      throw Exception('Gagal update foto');
    }
    return null;
  }

  Future logout() async {
    var token = await Pref.getToken();
    var response = await http.post(Uri.parse(EndPoint.logout), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      if (jsonDecode(response.body)["message"] == "Logged out") {
        return jsonDecode(response.body)["message"];
      }
    }
    return "gagal logout";
  }

  Future<DashboardModel> dahsboardData() async {
    var token = await Pref.getToken();
    var response = await http.get(
      Uri.parse(EndPoint.dashboard),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200) {
      return DashboardModel.fromJson(jsonDecode(response.body)["data"]);
    } else {
      return null;
    }
  }

  Future<List<NotifikasiModel>> notifikasiList() async {
    var token = await Pref.getToken();
    var response = await http.get(
      Uri.parse(EndPoint.notifikasi),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"];
      return data.map((e) => NotifikasiModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }

  Future<bool> readNotif({String id}) async {
    var token = await Pref.getToken();
    var response = await http.post(
      Uri.parse(EndPoint.readNotif + id),
      headers: {'Authorization': token},
    );
    if (response.statusCode == 200) {
      // List data = jsonDecode(response.body)["data"];

      return true;
    } else {
      return false;
    }
  }

  Future<DashboardGuruModel> dashboardGuru() async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.dashboardGuru), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      return DashboardGuruModel.fromJson(jsonDecode(response.body)["data"]);
    } else {
      return null;
    }
    // print(response.body);
  }

  Future<DashboardWaliModel> getDashboardWali() async {
    var token = await Pref.getToken();
    http.Response response = await http.get(Uri.parse(EndPoint.dashboardWali), headers: {'Authorization': token});

    if (response.statusCode == 200) {
      return DashboardWaliModel.fromJson(jsonDecode(response.body)['data']);
    } else {
      return null;
    }
    // print(response.body);
  }
}
