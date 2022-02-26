import 'package:bigstars_mobile/model/DetailSpp_model.dart';
import 'package:bigstars_mobile/model/finance_model.dart';
import 'package:bigstars_mobile/model/report_model.dart';
import 'package:bigstars_mobile/model/spp_model.dart';
import 'package:bigstars_mobile/page/admin/finance/financePage.dart';
import 'package:bigstars_mobile/page/admin/finance/listFeeGuru.dart';
import 'package:bigstars_mobile/service/finance_service.dart';
import 'package:flutter/widgets.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';

class FinanceProvider with ChangeNotifier {
  FeeGuruModel _feeGuru;
  SppModel _sppModel;
  DetailSPPModel _detailSPPModel;
  FinanceModel _finance;
  get Finance => _finance;
  List<FeeGuruModel> _listFeeGuru;
  List<SppModel> _listSppModel;
  List<ReportModel> _listReport;

  DetailSPPModel get detailSPPModel => _detailSPPModel;
  List<SppModel> get ListSppModel => _listSppModel;
  List<ReportModel> get ListReportModel => _listReport;
  get ListFeeGuru => _listFeeGuru;

  Future getFinance(String filtered) async {
    FinanceModel finance = await FinanceService().indexFinance(filtered);
    _finance = finance;
    notifyListeners();
    return _finance;
  }

  Future<List<FeeGuruModel>> getFeeGuru(String filtered) async {
    try {
      List data = await FinanceService().feeGuru(filtered);
      _listFeeGuru = data;
      notifyListeners();
      return _listFeeGuru;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<SppModel>> getSpp(String filtered) async {
    try {
      print(filtered);
      List data = await FinanceService().spp(filtered);
      _listSppModel = data;
      notifyListeners();
      return _listSppModel;
    } catch (e) {
      print(e);
      return [];
    }
  }

  Future<List<ReportModel>> getReport({String filtered}) async {
    try {
      List data = await FinanceService().report(filtered);
      _listReport = data;
      notifyListeners();
      return _listReport;
    } catch (e) {
      print(e);
      return [];
    }
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

  Future detailSpp(String id) async {
    DetailSPPModel detailSPPModel = await FinanceService().detailSpp(id);
    _detailSPPModel = detailSPPModel;
    notifyListeners();
    return _detailSPPModel;
  }

  Future<bool> konfirmasiFee(String id) async {
    try {
      bool status = await FinanceService().konfirmasiFee(id);
      getFeeGuru('');
      notifyListeners();
      return status;
    } catch (e) {
      return false;
    }
  }

  Future<bool> konfirmasiSPP(String id) async {
    try {
      bool status = await FinanceService().konfirmasiSPP(id);
      DetailSPPModel detailSPPModel = await FinanceService().detailSpp(id);
      _detailSPPModel = detailSPPModel;
      notifyListeners();
      getSpp('');
      notifyListeners();
      return status;
    } catch (e) {
      return false;
    }
  }

  // Future filterSpp(String param) async {
  //   List data = await FinanceService().filterSpp(param);
  //   _listSppModel = data;
  //   notifyListeners();
  //   return _listSppModel;
  // }
}
