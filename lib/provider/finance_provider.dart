import 'package:bigstars_mobile/model/finance_model.dart';
import 'package:bigstars_mobile/model/spp_model.dart';
import 'package:bigstars_mobile/page/admin/finance/financePage.dart';
import 'package:bigstars_mobile/page/admin/finance/listFeeGuru.dart';
import 'package:bigstars_mobile/service/finance_service.dart';
import 'package:flutter/widgets.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';

class FinanceProvider with ChangeNotifier {
  FeeGuruModel _feeGuru;
  SppModel _sppModel;

  FinanceModel _finance;
  get Finance => _finance;

  List<FeeGuruModel> _listFeeGuru;
  List<SppModel> _listSppModel;

  List<SppModel> get ListSppModel => _listSppModel;
  get ListFeeGuru => _listFeeGuru;

  Future getFinance() async {
    FinanceModel finance = await FinanceService().indexFinance();
    _finance = finance;
    notifyListeners();
    return _finance;
  }

  Future<List<FeeGuruModel>> getFeeGuru() async {
    List data = await FinanceService().feeGuru();
    _listFeeGuru = data;
    print(data);
    notifyListeners();
    return _listFeeGuru;
  }

  Future<List<SppModel>> getSpp() async {
    List data = await FinanceService().spp();
    _listSppModel = data;
    notifyListeners();
    return _listSppModel;
  }

  Future<bool> generateFEE() async {
    try {
      bool status = await FinanceService().generateFee();
      return status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> generateSpp() async {
    try {
      bool status = await FinanceService().generateFee();
      return status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> konfirmasi(String id) async {
    try {
      bool status = await FinanceService().konfirmasiFee(id);
      getFeeGuru();
      notifyListeners();
      return status;
    } catch (e) {
      return false;
    }
  }
}
