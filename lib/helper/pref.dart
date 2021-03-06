import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    return token;
  }

   static getSetuju() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String setuju = preferences.getString('setuju');
    return setuju;
  }

  static getNama() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String nama = preferences.getString('nama');
    return nama;
  }

  static getPhone() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String phone = preferences.getString('phone');
    return phone;
  }

  static getUsername() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String username = preferences.getString('username');
    return username;
  }

  static getFoto() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String foto = preferences.getString('foto');
    return foto;
  }

  static getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String role = preferences.getString('role');
    return role;
  }

  static getAlamat() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String alamat = preferences.getString('alamat');
    return alamat;
  }

  static getUserModel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String user = preferences.getString('user');
    return user;
  }
}
