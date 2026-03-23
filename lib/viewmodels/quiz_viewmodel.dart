
import 'package:avision/data_models/assigmentSubjectStudentzoneResponse.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneRequest.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneResponse.dart';
import 'package:avision/data_models/commonResponse.dart';
import 'package:avision/data_models/dailyVocabContentStudentzoneRequest.dart';
import 'package:avision/data_models/dailyVocabContentStudentzoneResponse.dart';
import 'package:avision/data_models/dailyVocabListStudentzoneResponse.dart';
import 'package:avision/data_models/magazineStudentzoneResponse.dart';
import 'package:avision/data_models/prevyearpaperSubjectsRequest.dart';
import 'package:avision/data_models/prevyearpaperSubjectsResponse.dart';
import 'package:avision/data_models/prevyearpaperTestsRequest.dart';
import 'package:avision/data_models/prevyearpaperTestsResponse.dart';
import 'package:avision/data_models/trendingvideoVideosAppBarRequest.dart';
import 'package:avision/pages/currentaffairs_gkca_page.dart';
import 'package:avision/quiz/datamodels/ansSubmitRequest.dart';
import 'package:avision/quiz/datamodels/studentIdQuizIdRequest.dart';
import 'package:avision/quiz/datamodels/questionResponse.dart';
import 'package:avision/quiz/datamodels/rankResponse.dart';
import 'package:avision/quiz/datamodels/resultResponse.dart';
import 'package:avision/quiz/datamodels/resultWithGivenAnsResponse.dart';

import 'package:avision/repositories/assignment_chapter_studentzone_repo.dart';
import 'package:avision/repositories/assignment_subject_studentzone_repo.dart';
import 'package:avision/repositories/booster_studentzone_repo.dart';
import 'package:avision/repositories/currentAffairs_gkca_appbar_repo.dart';
import 'package:avision/repositories/currentAffairs_home_repo.dart';
import 'package:avision/repositories/dailyvocab_content_studentzone_repo.dart';
import 'package:avision/repositories/dailyvocab_list_studentzone_repo.dart';
import 'package:avision/repositories/datelist_news_appbar_Repo.dart';
import 'package:avision/repositories/gabooklet_studentzone_repo.dart';
import 'package:avision/repositories/lastdate_newslist_news_appbar_repo.dart';
import 'package:avision/repositories/magazine_studentzone_repo.dart';
import 'package:avision/repositories/newslist_news_appbar_repo.dart';
import 'package:avision/repositories/prevyearpaper_subjects_studentzone_repo.dart';
import 'package:avision/repositories/prevyearpaper_tests_studentzone_repo.dart';
import 'package:avision/utils/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/multiApiOneHomeResponse.dart';
import '../quiz/repo/dailyDose_dailyAssignment/ans_submit_repo.dart';
import '../quiz/repo/dailyDose_dailyAssignment/question_repo.dart';
import '../quiz/repo/dailyDose_dailyAssignment/rank_repo.dart';
import '../quiz/repo/dailyDose_dailyAssignment/result_repo.dart';
import '../quiz/repo/dailyDose_dailyAssignment/result_with_given_ans.dart';
import '../utils/Utilities.dart';

class QuizViewmodel with ChangeNotifier{
  bool isLoading=false;
  QuizQuestionResponse? dataQuestions;
  CommonResponse? dataAnsSubmitResponse;
  QuizRankResponse? dataRank;
  QuizResultResponse? dataResult;
  QuizResultWithGivenAnsResponse? dataResultWithGivenAns;
  final dailydoseRank=DailydoseRankRepo();
  final dailydoseResult=DailydoseResultRepo();
  final dailydoseAnsSubmit=DailydoseAnsSubmitRepo();
  final dailydoseQuestions=DailydoseQuizQuestionsRepo();
  final dailydoseResultGivenAns=DailydoseResultWithGivenAnsRepo();

  final appbarQuizQuestions=AppbarQuizQuizQuestionsRepo();


  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  void fetchQuestion(BuildContext context,MyEnumConstants section,StudentIdQuizIdRequest data) async{
    Future<dynamic>? call;
    if(section==MyEnumConstants.QUIZ_SECTION_DAILYDOSE){
     call= dailydoseQuestions.fetch(data.toJson());
    }else if(section==MyEnumConstants.QUIZ_SECTION_APPBAR_QUIZ){
      call= appbarQuizQuestions.fetch(data.toJson());
    }
    if(call!=null) {
      setLoading(true);
    }
    call?.then((value) {
      setLoading(false);
      if(value!=null) {
        dataQuestions = QuizQuestionResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void submitAns(BuildContext context,MyEnumConstants section,QuizAnsSubmitRequest data) async{
    Future<dynamic>? call;
    if(section==MyEnumConstants.QUIZ_SECTION_DAILYDOSE){
      call= dailydoseAnsSubmit.fetch(data.toJson());
    }
    if(call!=null) {
      setLoading(true);
    }
    call?.then((value) {
      setLoading(false);
      if(value!=null) {
        dataAnsSubmitResponse = CommonResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchRank(BuildContext context,MyEnumConstants section,StudentIdQuizIdRequest data) async{
    Future<dynamic>? call;
    if(section==MyEnumConstants.QUIZ_SECTION_DAILYDOSE){
      call= dailydoseRank.fetch(data.toJson());
    }
    if(call!=null) {
      setLoading(true);
    }
    call?.then((value) {
      setLoading(false);
      if(value!=null) {
        dataRank = QuizRankResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchResult(BuildContext context,MyEnumConstants section,StudentIdQuizIdRequest data) async{
    Future<dynamic>? call;

    if(section==MyEnumConstants.QUIZ_SECTION_DAILYDOSE){
      call= dailydoseResult.fetch(data.toJson());
    }
    if(call!=null) {
      setLoading(true);
    }
    call?.then((value) {
      setLoading(false);
      if(value!=null) {
        dataResult = QuizResultResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchResultWithAns(BuildContext context,MyEnumConstants section,StudentIdQuizIdRequest data) async{
    Future<dynamic>? call;
    if(section==MyEnumConstants.QUIZ_SECTION_DAILYDOSE){
      call= dailydoseResultGivenAns.fetch(data.toJson());
    }
    if(call!=null) {
      setLoading(true);
    }
    call?.then((value) {
      setLoading(false);
      if(value!=null) {
        dataResultWithGivenAns = QuizResultWithGivenAnsResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}