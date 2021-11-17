import 'dart:convert';
import 'package:bigstars_mobile/helper/network.dart';
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
}
