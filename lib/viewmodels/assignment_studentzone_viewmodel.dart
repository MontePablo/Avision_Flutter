
import 'package:avision/data_models/assigmentSubjectStudentzoneResponse.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneRequest.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneResponse.dart';
import 'package:avision/data_models/dailyVocabContentStudentzoneRequest.dart';
import 'package:avision/data_models/dailyVocabContentStudentzoneResponse.dart';
import 'package:avision/data_models/dailyVocabListStudentzoneResponse.dart';
import 'package:avision/data_models/magazineStudentzoneResponse.dart';
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

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/multiApiOneHomeResponse.dart';
import '../utils/Utilities.dart';

class AssignmentStudentzoneViewmodel  with ChangeNotifier{
  bool isLoading=false;
  AssignmentSubjectStudentzoneResponse? dataAssignmentSubject;
  AssignmentChapterStudentzoneResponse? dataAssignmentChapter;
  final subjectRepo=AssignmentSubjectStudentzoneRepo();
  final chapterRepo=AssignmentChapterStudentzoneRepo();

  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  void fetchSubjectList(BuildContext context) async{
    setLoading(true);
    subjectRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataAssignmentSubject = AssignmentSubjectStudentzoneResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchChapterList(BuildContext context,AssignmentChapterStudentzoneRequest data) async{
    setLoading(true);
    chapterRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataAssignmentChapter = AssignmentChapterStudentzoneResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}