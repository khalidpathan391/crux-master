// import 'dart:developer';

import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:crux/redux/models/case_study.dart';
import 'package:crux/redux/models/case_study_ans.dart';
import 'package:crux/redux/models/evaluate_model.dart';

class LocalStorageService {
  final SharedPreferences pref;

  LocalStorageService(this.pref);
  bool get isRegistered => pref.containsKey('registered');
  bool get isCaseStudyAnsAvailable => pref.containsKey("caseStudyAns");
  bool get isCaseStudyAvailable => pref.containsKey("caseStudy");
  bool get isEvaluated => pref.containsKey("evaluationAns");
  CaseStudyAns get getSavedCaseStudyAns {
    Map<String, dynamic> abc = jsonDecode(pref.getString('caseStudyAns') ?? "");
    // log(abc.toString());
    CaseStudyAns casestudy = CaseStudyAns.fromJson(abc);
    return casestudy;
  }

  CaseStudy get getSavedCaseStudy {
    Map<String, dynamic> abc = jsonDecode(pref.getString('caseStudy') ?? "");
    // log(abc.toString());
    CaseStudy casestudy = CaseStudy.fromJson(abc);
    return casestudy;
  }

  EvaluateAns get getSavedEvaluation {
    if (isEvaluated) {
      Map<String, dynamic> abc = jsonDecode(pref.getString('evaluationAns'));
      // log(abc.toString());
      EvaluateAns casestudy = EvaluateAns.fromJson(abc);
      return casestudy;
    }
  }

  setCaseStudyAns(CaseStudyAns caseStudyAns) {
    String data = jsonEncode(CaseStudyAns.fromJson(caseStudyAns.toJson()));
    log("set" + data);
    pref.setString("caseStudyAns", data);
  }

  setCaseStudy(CaseStudy caseStudy) {
    String data = jsonEncode(CaseStudy.fromJson(caseStudy.toJson()));
    log("set" + data);
    pref.setString("caseStudy", data);
  }

  setEvaluationAns(EvaluateAns evalAns) {
    String data = jsonEncode(EvaluateAns.fromJson(evalAns.toJson()));
    log("set" + data);
    pref.setString("evaluationAns", data);
  }

  Future<bool> setRegistered() async {
    return await pref.setBool('registered', true);
  }

  Future<void> clear() async {
    await pref.clear();
  }

  Future<bool> clearIsRegistered() async {
    return await pref.remove('registered');
  }

  Future<bool> clearCaseStudyAns() async {
    return await pref.remove('caseStudyAns');
  }
}
