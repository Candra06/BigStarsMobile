import 'package:bigstars_mobile/model/guru_model.dart';
import 'package:bigstars_mobile/model/wali_model.dart';
import 'package:bigstars_mobile/service/guru_service.dart';
import 'package:flutter/widgets.dart';

class GuruProvider with ChangeNotifier {
  GuruModel _guruModel;
  List<GuruModel> _listGuru;

  GuruModel get guru => _guruModel;
  List<GuruModel> get listGuru => _listGuru;

  Future<List<GuruModel>> getData() async {
    try {
      _listGuru = await GuruService().getdata();
      notifyListeners();
      return _listGuru;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<Map<String, dynamic>> tambahGuru(Map<String, dynamic> data) async {
    Map<String, dynamic> message = await GuruService().tambahGuru(data);
    _listGuru = await GuruService().getdata();
    notifyListeners();
    return message;
  }

  Future<bool> delete(var id) async {
    try {
      bool status = await GuruService().deleteGuru(id);

      _listGuru = await GuruService().getdata();
      notifyListeners();

      return status;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future editGuru(int id, Map<String, dynamic> data) async {
    try {
      return await GuruService().editGuru(id, data);
    } catch (e) {
      print(e);
      return false;
    }
  }
}
