

import 'dart:convert';

import 'package:avision/data_models/JobAlertsHomeResponse.dart';
import 'package:avision/data_models/courseListMainpageRequest.dart';
import 'package:avision/data_models/multiapiBannerResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeRequest.dart';
import 'package:avision/data_models/multiApiOneHomeResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/data_models/popularCourseHomeResponse.dart';
import 'package:avision/repositories/courselist_mainpage_repo.dart';

import 'package:avision/repositories/daily_assignment_banner_home_repo.dart';
import 'package:avision/repositories/multiapi_two_home_repo.dart';
import 'package:avision/repositories/job_alerts_home_repo.dart';
import 'package:avision/repositories/popular_course_home_repo.dart';
import 'package:avision/repositories/popup_banner_home_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/courseListMainpageResponse.dart';
import '../repositories/multiapi_one_home_repo.dart';
import '../utils/Utilities.dart';

class MainPageViewModel with ChangeNotifier{
  bool isLoading=false;
  CourseListMainpageResponse? dataCourseList;
 final courseListMainPageRepo=CourseListMainPageRepo();

  void fetchCourseList(BuildContext context,CourseListHomepageRequest data) async{
    setLoading(true);
    courseListMainPageRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataCourseList = CourseListMainpageResponse.fromJson(value);
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