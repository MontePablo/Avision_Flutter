

import 'dart:convert';

import 'package:avision/data_models/JobAlertsHomeResponse.dart';
import 'package:avision/data_models/dailyAssignmentQuizlistRequest.dart';
import 'package:avision/data_models/multiapiBannerResponse.dart';
import 'package:avision/data_models/dailyassignmentQuizlistResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeRequest.dart';
import 'package:avision/data_models/multiApiOneHomeResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/data_models/popularCourseHomeResponse.dart';
import 'package:avision/data_models/quizAppbarQuizlistResponse.dart';
import 'package:avision/data_models/quizAppbarSubjectlistResponse.dart';

import 'package:avision/repositories/daily_assignment_banner_home_repo.dart';
import 'package:avision/repositories/daily_assignment_quizlist_home_repo.dart';
import 'package:avision/repositories/multiapi_two_home_repo.dart';
import 'package:avision/repositories/job_alerts_home_repo.dart';
import 'package:avision/repositories/popular_course_home_repo.dart';
import 'package:avision/repositories/popup_banner_home_repo.dart';
import 'package:avision/repositories/quizlist_quiz_appbar_repo.dart';
import 'package:avision/repositories/subjectlist_quiz_appbar_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/quizAppbarQuizlistRequest.dart';
import '../repositories/multiapi_one_home_repo.dart';
import '../utils/Utilities.dart';

class QuizAppbarViewmodel with ChangeNotifier{
  bool isLoading=false;
  QuizAppbarSubjectlistResponse? dataSubjectList;
  QuizAppbarQuizlistResponse? dataQuizList;
 final subjectlistRepo=SubjectlistQuizAppbarRepo();
 final quizlistRepo=QuizlistQuizAppbarRepo();
  void fetchSubjectList(BuildContext context) async{
    setLoading(true);
    subjectlistRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataSubjectList =
            QuizAppbarSubjectlistResponse.fromJson(value);
      }
      notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchQuizList(BuildContext context,QuizAppbarQuizlistRequest data) async{
    setLoading(true);
    quizlistRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataQuizList = QuizAppbarQuizlistResponse.fromJson(value);
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