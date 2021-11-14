import 'package:shared_preferences/shared_preferences.dart';

class Pref {
  static getToken() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('token');
    return token;
  }

  static isDiagnosa() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String isDiagnosa = preferences.getString('isDiagnosa');
    return isDiagnosa;
  }

  static getRole() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String token = preferences.getString('role');
    return token;
  }

  static getNama() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String nama = preferences.getString('username');
    return nama;
  }

  static getID() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String id = preferences.getString('id');
    return id;
  }

  static getEmail() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String email = preferences.getString('email');
    return email;
  }

  static getTelepon() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String telepon = preferences.getString('phone');
    return telepon;
  }

  static getGende() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String phone = preferences.getString('phone');
    return phone;
  }

  static getBirthDate() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String telepon = preferences.getString('birhDate');
    return telepon;
  }

  static getLevel() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String telepon = preferences.getString('level_diagnosa');
    return telepon;
  }

  static like(id) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool like = preferences.getBool(id);
    return like;
  }

  static getMember() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String membership = preferences.getString('membership');
    return membership;
  }
}
