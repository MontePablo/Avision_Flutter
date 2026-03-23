
import 'package:avision/data_models/currentAffairsGkcaResponse.dart';
import 'package:avision/data_models/currentAffairsHomeRequest.dart';
import 'package:avision/data_models/currentAffairsHomeResponse.dart';
import 'package:avision/data_models/quizlistGkcaResponse.dart';

import 'package:avision/data_models/trendingvideoVideosAppBarRequest.dart';
import 'package:avision/pages/currentaffairs_gkca_page.dart';
import 'package:avision/repositories/currentAffairs_gkca_appbar_repo.dart';
import 'package:avision/repositories/currentAffairs_home_repo.dart';
import 'package:avision/repositories/quizlist_gkca_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/multiApiOneHomeResponse.dart';
import '../utils/Utilities.dart';

class GkcaAppbarViewmodel with ChangeNotifier{
  bool isLoading=false;
  CurrentAffairsGkcaResponse? dataCurrentAffairs;
  QuizlistGkcaResponse? dataQuizlist;
  final currentAffairsRepo=CurrentAffairsGkcaAppbarRepo();
  final quizlistRepo=QuizlistGkcaRepo();
  void setLoading(bool value){
    isLoading=value;
    // notifyListeners();
  }


  void fetchCurrentAffairs(BuildContext context) async{
    setLoading(true);
    currentAffairsRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataCurrentAffairs = CurrentAffairsGkcaResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchQuizlist(BuildContext context) async{
    setLoading(true);
    quizlistRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataQuizlist = QuizlistGkcaResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}