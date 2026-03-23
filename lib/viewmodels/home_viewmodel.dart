

import 'dart:convert';

import 'package:avision/data_models/JobAlertsHomeResponse.dart';
import 'package:avision/data_models/multiapiBannerResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeRequest.dart';
import 'package:avision/data_models/multiApiOneHomeResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/data_models/popularCourseHomeResponse.dart';

import 'package:avision/repositories/daily_assignment_banner_home_repo.dart';
import 'package:avision/repositories/multiapi_two_home_repo.dart';
import 'package:avision/repositories/job_alerts_home_repo.dart';
import 'package:avision/repositories/popular_course_home_repo.dart';
import 'package:avision/repositories/popup_banner_home_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/currentAffairsHomeResponse.dart';
import '../repositories/currentAffairs_home_repo.dart';
import '../repositories/multiapi_one_home_repo.dart';
import '../utils/Utilities.dart';

class HomeViewModel with ChangeNotifier{
  bool isLoading=false;
  JobAlertsHomeResponse? dataJobAlerts;
  MultiApiBannerResponse? dataDailyAssignmentBanner;
  MultiApiTwoHomeResponse? dataMultiApiTwoHome;
  MultiApiOneHomeResponse? dataMultiApiOneHome;
  PopularCourseResponse? dataPopularCourse;
  MultiApiBannerResponse? dataPopupBanner;
  CurrentAffairsHomeResponse? dataCurrentAffairs;
 final jobAlertsHomeRepo=JobAlertsHomeRepo();
 final dailyAssignmentBannerHomeRepo=DailyAssignmentBannerHomeRepo();
  final currentAffairsHomeRepo=CurrentAffairsHomeRepo();

  final multiApiTwoHomeRepo=MultiApiTwoHomeRepo();
  final multiApiOneHomeRepo=MultiApiOneHomeRepo();

  final popularCourseHomeRepo=PopularCourseHomeRepo();
 final popupBannerHomeRepo=PopupBannerHomeRepo();
  void fetchCurrentAffairs(BuildContext context) async{
    setLoading(true);
    currentAffairsHomeRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataCurrentAffairs = CurrentAffairsHomeResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchJobAlerts(BuildContext context) async{
    setLoading(true);
    jobAlertsHomeRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataJobAlerts = JobAlertsHomeResponse.fromJson(value);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
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
  void fetchMultiApiTwo(BuildContext context,MultiApiTwoHomeRequest data) async{
    setLoading(true);
    multiApiTwoHomeRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataMultiApiTwoHome = MultiApiTwoHomeResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchMultiApiOne(BuildContext context) async{
    setLoading(true);
    multiApiOneHomeRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataMultiApiOneHome = MultiApiOneHomeResponse.fromJson(value);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchPopularCourse(BuildContext context) async{
    setLoading(true);
    popularCourseHomeRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataPopularCourse = PopularCourseResponse.fromJson(value);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchPopupBanner(BuildContext context) async{
    setLoading(true);
    popupBannerHomeRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataPopupBanner = MultiApiBannerResponse.fromJson(value);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      // Utility.flushbarErrorMsg("$error", context);
    });
  }
  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
}