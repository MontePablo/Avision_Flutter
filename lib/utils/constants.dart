import 'package:avision/data_models/loginResponse.dart';
import 'package:avision/storage/shared_preferences.dart';
import 'package:flutter/cupertino.dart';

enum MyEnumConstants{
  USER_DETAILS, COURSE_DETAILS, SUBJECTWISE_VIDEO_LIST , RECORDED_VIDEO_DRAWER,COMBINED_RECORDED_VIDEO_DRAWER,
  MONTHLY_BOOSTER_PAGE, MONTHLY_MAGAZINE_PAGE, MONTHLY_GA_PAGE,

  QUIZ_SECTION_DAILYDOSE,QUIZ_SECTION_TESTSERIES,QUIZ_SECTION_APPBAR_QUIZ,QUIZ_SECTION_PRACTICE,
  QUIZ_SECTION_PREVYEARPAPER,QUIZ_SECTION_APPBAR_GKCA,

  LIVE_EXAM,CORRECT_ANS_VIEW ,START_QUIZ,RESUME_QUIZ,RESULT_QUIZ
}
class MyConstants{
  LoginResponse? userDetails;
  static double sh=0;
  static double sw=0;
  static int homeBannerCount=0;
   BuildContext context;

 MyConstants(this.context) {
   sh=MediaQuery.of(context).size.height;
   sw=MediaQuery.of(context).size.width;
   print("sh="+sh.toString()+"sw="+sw.toString());
 }
}
