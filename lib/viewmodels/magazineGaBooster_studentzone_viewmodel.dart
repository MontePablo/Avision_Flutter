
import 'package:avision/data_models/magazineStudentzoneResponse.dart';
import 'package:avision/data_models/trendingvideoVideosAppBarRequest.dart';
import 'package:avision/pages/currentaffairs_gkca_page.dart';
import 'package:avision/repositories/booster_studentzone_repo.dart';
import 'package:avision/repositories/currentAffairs_gkca_appbar_repo.dart';
import 'package:avision/repositories/currentAffairs_home_repo.dart';
import 'package:avision/repositories/datelist_news_appbar_Repo.dart';
import 'package:avision/repositories/gabooklet_studentzone_repo.dart';
import 'package:avision/repositories/lastdate_newslist_news_appbar_repo.dart';
import 'package:avision/repositories/magazine_studentzone_repo.dart';
import 'package:avision/repositories/newslist_news_appbar_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/multiApiOneHomeResponse.dart';
import '../utils/Utilities.dart';

class MagazineGaBoosterStudentzoneViewmodel  with ChangeNotifier{
  bool isLoading=false;
  int language=1  ;//1=english 2=hindi
  MagazineBoosterGaStudentzoneResponse? dataMagazine;
  List<Magazine> dataList=[];
  final boosterRepo=BoosterStudentzoneRepo();
  final gaBookletRepo=GabookletStudentzoneRepo();
  final magazineRepo=MagazineStudentzoneRepo();
  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }
  void filterDataWithLanguage(int lang){  //1 = english , 2=hindi
    if(dataMagazine!=null && dataMagazine?.magagineList!=null){
      dataList.clear();
      for(final mag in dataMagazine!.magagineList!){
        if(mag.pdfLang==lang.toString()){
          dataList.add(mag);
        }
      }
      notifyListeners();
    }
  }

  void setLanguage(int lang){
    language=lang;
    filterDataWithLanguage(lang);
  }

  void fetchBooster(BuildContext context) async{
    setLoading(true);
    boosterRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataMagazine = MagazineBoosterGaStudentzoneResponse.fromJson(value);
        filterDataWithLanguage(language);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchMagazine(BuildContext context) async{
    setLoading(true);
    magazineRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataMagazine = MagazineBoosterGaStudentzoneResponse.fromJson(value);
        filterDataWithLanguage(language);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchGaBooklet(BuildContext context) async{
    setLoading(true);
    gaBookletRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataMagazine = MagazineBoosterGaStudentzoneResponse.fromJson(value);
        filterDataWithLanguage(language);
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}