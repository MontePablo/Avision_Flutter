
import 'package:avision/data_models/assigmentSubjectStudentzoneResponse.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneRequest.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneResponse.dart';
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/multiApiOneHomeResponse.dart';
import '../utils/Utilities.dart';

class PrevyearpaperStudentzoneViewmodel  with ChangeNotifier{
  bool isLoading=false;
  PrevyearpaperTestsResponse? dataPrevyrpaperTests;
  PrevyearpaperSubjectsResponse? dataPrevyrpaperSubjects;
  final prevyrpaperSubjectRepo=PrevyearpaperSubjectsStudentzoneRepo();
  final prevyrpaperTestRepo=PrevyearpaperTestsStudentzoneRepo();

  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  void fetchSubjectList(BuildContext context,PrevyearpaperSubjectsRequest data) async{
    setLoading(true);
    prevyrpaperSubjectRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataPrevyrpaperSubjects = PrevyearpaperSubjectsResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchTestList(BuildContext context,PrevyearpaperTestsRequest data) async{
    setLoading(true);
    prevyrpaperTestRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataPrevyrpaperTests = PrevyearpaperTestsResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}