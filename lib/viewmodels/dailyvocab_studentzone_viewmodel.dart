
import 'package:avision/data_models/dailyVocabContentStudentzoneRequest.dart';
import 'package:avision/data_models/dailyVocabContentStudentzoneResponse.dart';
import 'package:avision/data_models/dailyVocabListStudentzoneResponse.dart';
import 'package:avision/data_models/magazineStudentzoneResponse.dart';
import 'package:avision/data_models/trendingvideoVideosAppBarRequest.dart';
import 'package:avision/pages/currentaffairs_gkca_page.dart';
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

class DailyvocabStudentzoneViewmodel  with ChangeNotifier{
  bool isLoading=false;
  DailyVocabListStudentzoneResponse? dataDailyVocabList;
  DailyVocabContentStudentzoneResponse? dataDailyVocabContent;
  final dailyVocabListRepo=DailyVocabListStudentzoneRepo();
  final dailyVocabContentRepo=DailyVocabContentStudentzoneRepo();

  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  void fetchDailyVocabList(BuildContext context) async{
    setLoading(true);
    dailyVocabListRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataDailyVocabList = DailyVocabListStudentzoneResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchDailyVocabContent(BuildContext context,DailyVocabContentStudentzoneRequest data) async{
    setLoading(true);
    dailyVocabContentRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataDailyVocabContent = DailyVocabContentStudentzoneResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}