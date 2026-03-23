
import 'package:avision/data_models/multiApiLiveCourseResponse.dart';

import 'package:avision/repositories/multi_api_live_course_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../utils/Utilities.dart';

class LiveCourseViewModel with ChangeNotifier{
  bool isLoading=false;
  MultiApiLiveCourseResponse? dataMultiApiLiveCourse;
  final multiApiLiveCourseRepo= MultiApiLiveCourseRepo();
  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }


  void fetchMultiApiLiveCourse(BuildContext context) async{
    setLoading(true);
    multiApiLiveCourseRepo.fetch()
        .then((value) {
          setLoading(false);
          if(value!=null) {
            dataMultiApiLiveCourse = MultiApiLiveCourseResponse.fromJson(value);
          }
          notifyListeners();
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}