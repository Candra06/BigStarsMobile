import 'package:bigstars_mobile/model/mapel_model.dart';
import 'package:bigstars_mobile/model/rules_model.dart';
import 'package:bigstars_mobile/service/rules_service.dart';
import 'package:flutter/widgets.dart';

class RulesProvider with ChangeNotifier {
  RulesModel _ruleModel;
  List<RulesModel> _rules = [];
  RulesModel get rule => _ruleModel;
  List<RulesModel> get rules => _rules;
  set rules(List<RulesModel> rules) {
    _rules = rules;
    notifyListeners();
  }

  set rule(RulesModel ruleModel) {
    _ruleModel = ruleModel;
    notifyListeners();
  }

  Future getMapel(String id) async {
    RulesModel mapel = await RuleService().detail(id);
    _ruleModel = mapel;
    notifyListeners();
  }

  Future<List<RulesModel>> getRules() async {
    try {
      List<RulesModel> mapels = await RuleService().getData();
      _rules = mapels;
      // for (var item in _mapels) {
      //   print(item.mapel);
      // }
      notifyListeners();
      return mapels;
    } catch (e) {
      print(e);
      return [];
    }
  }

    Future<RulesModel> getDetail(String param) async {
    try {
      _ruleModel = await RuleService().detail(param);
      
      // for (var item in _mapels) {
      //   print(item.mapel);
      // }
      return _ruleModel;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<bool> update(String id, Map<String, dynamic> data) async {
    try {
      bool status = await RuleService().updateRules(id, data);
     
      notifyListeners();
      return status;
    } catch (e) {
      return false;
    }
  }
}
