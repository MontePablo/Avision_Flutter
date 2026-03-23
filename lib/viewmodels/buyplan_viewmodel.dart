

import 'dart:convert';

import 'package:avision/data_models/JobAlertsHomeResponse.dart';
import 'package:avision/data_models/banner_buyplan_response.dart';
import 'package:avision/data_models/buyPlanRequest.dart';
import 'package:avision/data_models/commonResponse.dart';
import 'package:avision/data_models/courselist_buyplan_response.dart';
import 'package:avision/data_models/dailyAssignmentQuizlistRequest.dart';
import 'package:avision/data_models/multiapiBannerResponse.dart';
import 'package:avision/data_models/dailyassignmentQuizlistResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeRequest.dart';
import 'package:avision/data_models/multiApiOneHomeResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/data_models/planlist_buyplan_response.dart';
import 'package:avision/data_models/popularCourseHomeResponse.dart';
import 'package:avision/data_models/quizAppbarQuizlistResponse.dart';
import 'package:avision/data_models/quizAppbarSubjectlistResponse.dart';
import 'package:avision/data_models/studentreviews_buyplan_response.dart';
import 'package:avision/repositories/banner_buyplan_repo.dart';
import 'package:avision/repositories/buyplan_buyplan_repo.dart';
import 'package:avision/repositories/courselist_buyplan_repo.dart';

import 'package:avision/repositories/daily_assignment_banner_home_repo.dart';
import 'package:avision/repositories/daily_assignment_quizlist_home_repo.dart';
import 'package:avision/repositories/multiapi_two_home_repo.dart';
import 'package:avision/repositories/job_alerts_home_repo.dart';
import 'package:avision/repositories/planlist_buyplan_repo.dart';
import 'package:avision/repositories/popular_course_home_repo.dart';
import 'package:avision/repositories/popup_banner_home_repo.dart';
import 'package:avision/repositories/quizlist_quiz_appbar_repo.dart';
import 'package:avision/repositories/studentreview_buyplan_repo.dart';
import 'package:avision/repositories/subjectlist_quiz_appbar_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/quizAppbarQuizlistRequest.dart';
import '../repositories/multiapi_one_home_repo.dart';
import '../utils/Utilities.dart';

class BuyplanViewmodel with ChangeNotifier{
  bool isLoading=false;
  BannerBuyplanResponse? dataBanner;
  PlanlistBuyplanResponse? dataPlanlist;
  CourselistBuyplanResponse? dataCourselist;
  StudentreviewsBuyplanResponse? dataStudentreviews;
  CommonResponse? dataBuyplanResponse;
 final bannerRepo=BannerBuyplanRepo();
 final planlistRepo=PlanlistBuyplanRepo();
 final courselistRepo=CourselistBuyplanRepo();
 final studentreviewRepo=StudentreviewBuyplanRepo();
 final buyplanRepo=BuyplanBuyplanRepo();
  void fetchBanner(BuildContext context) async{
    setLoading(true);
    bannerRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataBanner =
            BannerBuyplanResponse.fromJson(value);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchPlanlist(BuildContext context) async{
    setLoading(true);
    planlistRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataPlanlist = PlanlistBuyplanResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchCourselist(BuildContext context) async{
    setLoading(true);
    courselistRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataCourselist = CourselistBuyplanResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchStudentreviewlist(BuildContext context) async{
    setLoading(true);
    studentreviewRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataStudentreviews = StudentreviewsBuyplanResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void setPlan(BuildContext context,BuyPlanRequest data) async{
    setLoading(true);
    buyplanRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataBuyplanResponse = CommonResponse.fromJson(value);
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