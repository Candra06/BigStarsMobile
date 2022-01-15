import 'dart:convert';
import 'dart:io';
import 'package:bigstars_mobile/helper/network.dart';
import 'package:bigstars_mobile/helper/pref.dart';
import 'package:bigstars_mobile/model/dashboard_model.dart';
import 'package:bigstars_mobile/model/kelasToday_model.dart';
import 'package:bigstars_mobile/provider/auth_provider.dart';
import 'package:http/http.dart' as http;
import 'package:bigstars_mobile/model/user_model.dart';
import 'package:provider/provider.dart';
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
      print(data['data']);
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

  Future<bool> updateProfileAdmin({UserModel user}) async {
    var token = await Pref.getToken();
    var body;

    if (user.password.isNotEmpty) {
      body = user.editProfilAdmin();
    } else {
      body = user.editProfilAdminNoPass();
    }
    print(body);
    var response = await http.post(Uri.parse(EndPoint.editProfilAdm), headers: {'Authorization': token}, body: body);
    print(response.body);
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
        print(value);
        var data = json.decode(value);

        UserModel userModel = UserModel.fromJson(data["data"]);
        return userModel;
      });
    } else {
       throw Exception('Gagal update foto');
    }
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
    var response = await http.get(Uri.parse(EndPoint.dashboard), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      return DashboardModel.fromJson(jsonDecode(response.body)["data"]);
    } else {
      return null;
    }
  }

  Future<List<KelasTodayModel>> kelasToday() async {
    var token = await Pref.getToken();
    var response = await http.get(Uri.parse(EndPoint.dashboard), headers: {'Authorization': token});
    if (response.statusCode == 200) {
      List data = jsonDecode(response.body)["data"]["kelas_today"];
      return data.map((e) => KelasTodayModel.fromJson(e)).toList();
    } else {
      return null;
    }
  }
}
