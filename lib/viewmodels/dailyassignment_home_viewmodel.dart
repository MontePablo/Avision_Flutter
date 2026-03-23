

import 'dart:convert';

import 'package:avision/data_models/JobAlertsHomeResponse.dart';
import 'package:avision/data_models/dailyAssignmentQuizlistRequest.dart';
import 'package:avision/data_models/multiapiBannerResponse.dart';
import 'package:avision/data_models/dailyassignmentQuizlistResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeRequest.dart';
import 'package:avision/data_models/multiApiOneHomeResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/data_models/popularCourseHomeResponse.dart';

import 'package:avision/repositories/daily_assignment_banner_home_repo.dart';
import 'package:avision/repositories/daily_assignment_quizlist_home_repo.dart';
import 'package:avision/repositories/multiapi_two_home_repo.dart';
import 'package:avision/repositories/job_alerts_home_repo.dart';
import 'package:avision/repositories/popular_course_home_repo.dart';
import 'package:avision/repositories/popup_banner_home_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../repositories/multiapi_one_home_repo.dart';
import '../utils/Utilities.dart';

class DailyassignmentHomeViewmodel with ChangeNotifier{
  bool isLoading=false;
  MultiApiBannerResponse? dataDailyAssignmentBanner;
  DailyAssignmentQuizListResponse? dataDailyAssigmentQuizlist;



 final dailyAssignmentBannerHomeRepo=DailyAssignmentBannerHomeRepo();
  final dailyAssignmentQuizlistHomeRepo=DailyAssignmentQuizlistHomeRepo();

  void fetchDailyAssignmentBanner(BuildContext context) async{
    setLoading(true);
    dailyAssignmentBannerHomeRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataDailyAssignmentBanner =
            MultiApiBannerResponse.fromJson(value);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchQuizList(BuildContext context,DailyassignmentQuizlistRequest data) async{
    setLoading(true);
    dailyAssignmentQuizlistHomeRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataDailyAssigmentQuizlist = DailyAssignmentQuizListResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }

  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
}