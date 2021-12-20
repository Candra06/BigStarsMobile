import 'package:bigstars_mobile/model/finance_model.dart';
import 'package:bigstars_mobile/page/admin/finance/financePage.dart';
import 'package:bigstars_mobile/page/admin/finance/listFeeGuru.dart';
import 'package:bigstars_mobile/service/finance_service.dart';
import 'package:flutter/widgets.dart';
import 'package:bigstars_mobile/model/feeGuru_model.dart';

class FinanceProvider with ChangeNotifier {
  FeeGuruModel _feeGuru;
  FinanceModel _finance;
  get Finance => _finance;

  List<FeeGuruModel> _listFeeGuru;

  get ListFeeGuru => _listFeeGuru;

  Future getFinance() async {
    FinanceModel finance = await FinanceService().indexFinance();
    _finance = finance;
    notifyListeners();
    print(_finance.laba);
    return _finance;
  }

  Future<List<FeeGuruModel>> getFeeGuru() async {
    List data = await FinanceService().feeGuru();
    _listFeeGuru = data;
    notifyListeners();
    return _listFeeGuru;
  }
}
