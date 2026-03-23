
import 'package:avision/data_models/examListTestSeriesRequest.dart';
import 'package:avision/data_models/examListTestSeriesResponse.dart';
import 'package:avision/data_models/multiApiLiveCourseResponse.dart';
import 'package:avision/data_models/recordedvideosDrawerResponse.dart';
import 'package:avision/data_models/subjectwiseAllVideoVideosAppBarRequest.dart';
import 'package:avision/data_models/subjectwiseAllvideoVideosAppBarResponse.dart';
import 'package:avision/data_models/subjectwiseVideoVideosAppBarRequest.dart';
import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';
import 'package:avision/data_models/trendingvideoVideosAppBarRequest.dart';
import 'package:avision/data_models/trendingvideoVideosAppBarResponse.dart';
import 'package:avision/repositories/examlist_testseries_repo.dart';

import 'package:avision/repositories/multi_api_live_course_repo.dart';
import 'package:avision/repositories/recordedvideos_drawer_repo.dart';
import 'package:avision/repositories/subjectwiseallvideo_videos_appbar_repo.dart';
import 'package:avision/repositories/subjectwisevideo_videos_appbar_repo.dart';
import 'package:avision/repositories/trendingvideo_videos_appbar_repo.dart';
import 'package:avision/storage/shared_preferences.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../utils/Utilities.dart';

class VideosAppbarViewModel with ChangeNotifier{
  bool isLoading=false;
  TrendingVideoVideosAppBarResponse? dataTrendingVideos;
  SubjectWiseVideoVideosAppBarResponsse? dataSubjectWiseVideos;
  SubjectwiseAllvideoVideosAppBarResponse? dataSubjectwiseAllVideos;
  final trendingVideoRepo= TrendingVideoVideosAppBarRepo();
  final subjectWiseVideoRepo= SubjectWiseVideoVideosAppBarRepo();
  final subjectWiseAllVideoRepo=SubjectWiseAllVideoVideosAppBarRepo();
  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }


  void fetchTrendingVideos(BuildContext context,TrendingVideoVideosAppBarRequest data) async{
    setLoading(true);
    trendingVideoRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataTrendingVideos = TrendingVideoVideosAppBarResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
  void fetchSubjectWiseVideos(BuildContext context,SubjectWiseVideoVideosAppBarRequest data) async{
    setLoading(true);
      dataSubjectWiseVideos=await MySharedPreferences().getZZ();
      notifyListeners();

      if(dataSubjectWiseVideos==null){
        subjectWiseVideoRepo.fetch(data.toJson())
            .then((value) {
          setLoading(false);
          if(value!=null) {
            dataSubjectWiseVideos = SubjectWiseVideoVideosAppBarResponsse.fromJson(value);
            MySharedPreferences().saveZZ(SubjectWiseVideoVideosAppBarResponsse.fromJson(value));
            notifyListeners();
          }
        }).onError((error, stackTrace) {
          setLoading(false);
          kDebugMode?print("$error\n$stackTrace"):"";
          Utility.flushbarErrorMsg("$error", context);
        });
      }
  }
  void fetchSubjectwiseAllVideos(BuildContext context,SubjectwiseAllVideosVideoAppBarRequest data) async{
    setLoading(true);
    subjectWiseAllVideoRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataSubjectwiseAllVideos = SubjectwiseAllvideoVideosAppBarResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}