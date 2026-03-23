
import 'package:avision/data_models/PostsFeedRequest.dart';
import 'package:avision/data_models/PostsFeedResponse.dart';
import 'package:avision/data_models/examListTestSeriesRequest.dart';
import 'package:avision/data_models/examListTestSeriesResponse.dart';
import 'package:avision/data_models/multiApiLiveCourseResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/repositories/examlist_testseries_repo.dart';

import 'package:avision/repositories/multi_api_live_course_repo.dart';
import 'package:avision/repositories/posts_feed_repo.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import '../utils/Utilities.dart';

class FeedViewModel with ChangeNotifier{
  bool isLoading=false;
   PostsFeedResponse? dataPostsFeed;
  List<Post> dataPostList = [];
  final postsFeedRepo= PostsFeedRepo();
  void setLoading(bool value){
    isLoading=value;
    notifyListeners();
  }


  void fetchPosts(BuildContext context,PostsFeedRequest data) async{
    setLoading(true);
    postsFeedRepo.fetch(data.toJson())
        .then((value) {
      setLoading(false);
      if(value!=null) {
        dataPostsFeed = PostsFeedResponse.fromJson(value);
        if (dataPostsFeed!.postArray != null) {
          dataPostList.addAll(dataPostsFeed!.postArray!);
        }
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      setLoading(false);
      kDebugMode?print("$error\n$stackTrace"):"";
      Utility.flushbarErrorMsg("$error", context);
    });
  }
}