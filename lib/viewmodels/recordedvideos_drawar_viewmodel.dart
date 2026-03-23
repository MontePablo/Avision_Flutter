
import 'package:avision/data_models/examListTestSeriesRequest.dart';
import 'package:avision/data_models/examListTestSeriesResponse.dart';
import 'package:avision/data_models/multiApiLiveCourseResponse.dart';
import 'package:avision/data_models/recordedvideosDrawerResponse.dart';
import 'package:avision/repositories/combinedrecordedvideos_drawer_repo.dart';
import 'package:avision/repositories/examlist_testseries_repo.dart';

import 'package:avision/repositories/multi_api_live_course_repo.dart';
import 'package:avision/repositories/recordedvideos_drawer_repo.dart';
import 'package:avision/utils/constants.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../utils/Utilities.dart';

class RecordedVideosDrawerViewModel with ChangeNotifier{
  bool isLoading=false;
  RecordedVideosDrawerResponse? dataVideos;
  final recordedVideosDrawerRepo= RecordedVideosDrawerRepo();
  final combinedRecordedVideosDrawerRepo= CombinedRecordedVideosDrawerRepo();

  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }


  void fetchRecordedVideos(BuildContext context,MyEnumConstants section) async{
    Future<dynamic>? call;

    if(section==MyEnumConstants.RECORDED_VIDEO_DRAWER){
      call= recordedVideosDrawerRepo.fetch();
    }else if(section==MyEnumConstants.COMBINED_RECORDED_VIDEO_DRAWER){
      call= combinedRecordedVideosDrawerRepo.fetch();
    }
    if(call!=null) {
      setLoading(true);
    }
    call?.then((value) {
      setLoading(false);
      if(value!=null) {
        dataVideos = RecordedVideosDrawerResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}