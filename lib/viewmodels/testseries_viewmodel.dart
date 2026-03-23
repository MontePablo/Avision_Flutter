
import 'package:avision/data_models/examListTestSeriesRequest.dart';
import 'package:avision/data_models/examListTestSeriesResponse.dart';
import 'package:avision/data_models/multiApiLiveCourseResponse.dart';
import 'package:avision/repositories/examlist_testseries_repo.dart';

import 'package:avision/repositories/multi_api_live_course_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../utils/Utilities.dart';

class TestSeriesViewModel with ChangeNotifier{
  bool isLoading=false;
  ExamListTestSeriesResponse? dataExamListTestSeries;
  final examListTestSeriesRepo= ExamListTestSeriesRepo();
  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }


  void fetchExamList(BuildContext context,ExamListTestSeriesRequest data) async{
    setLoading(true);
    examListTestSeriesRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataExamListTestSeries = ExamListTestSeriesResponse.fromJson(value);
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}