
import 'package:avision/data_models/currentAffairsGkcaResponse.dart';
import 'package:avision/data_models/currentAffairsHomeRequest.dart';
import 'package:avision/data_models/currentAffairsHomeResponse.dart';
import 'package:avision/data_models/dateListNewsAppbarResponse.dart';
import 'package:avision/data_models/newsListNewsAppBarResponse.dart';
import 'package:avision/data_models/newsListNewsAppbarRequest.dart';

import 'package:avision/data_models/trendingvideoVideosAppBarRequest.dart';
import 'package:avision/pages/currentaffairs_gkca_page.dart';
import 'package:avision/repositories/currentAffairs_gkca_appbar_repo.dart';
import 'package:avision/repositories/currentAffairs_home_repo.dart';
import 'package:avision/repositories/datelist_news_appbar_Repo.dart';
import 'package:avision/repositories/lastdate_newslist_news_appbar_repo.dart';
import 'package:avision/repositories/newslist_news_appbar_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../data_models/multiApiOneHomeResponse.dart';
import '../utils/Utilities.dart';

class NewsAppbarViewmodel with ChangeNotifier{
  bool isLoading=false;
  NewsListNewsAppbarResponse? dataNewsList;
  DateListNewsAppbarResponse? dataDateList;
  final newsListRepo=NewsListNewsAppbarRepo();
  final lastdateNewslistRepo=LastdateNewsListNewsAppbarRepo();
  final dateListRepo=DateListNewsAppbarRepo();
  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }


  void fetchDateList(BuildContext context) async{
    setLoading(true);
    dateListRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataDateList = DateListNewsAppbarResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchNewsList(BuildContext context,NewsListNewsAppbarRequest data) async{
    setLoading(true);
    newsListRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataNewsList = NewsListNewsAppbarResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchLastdateNewsList(BuildContext context) async{
    setLoading(true);
    lastdateNewslistRepo.fetch()
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataNewsList = NewsListNewsAppbarResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}