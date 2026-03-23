import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/subjectwiseAllVideoVideosAppBarRequest.dart';
import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:avision/viewmodels/videos_appbar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main() {
  runApp(const VideolistPage(data: [],
  ));
}

class VideolistPage extends StatefulWidget {
  final List<dynamic> data;
  const VideolistPage({super.key, required this.data});

  @override
  State<VideolistPage> createState() => _VideolistPageState();
}

class _VideolistPageState extends State<VideolistPage> {
  late RecordedVideosDrawerViewModel recordedVideosDrawerViewModel;
  late VideosAppbarViewModel videosAppbarViewModel;
  late MyEnumConstants section;
  @override
  void initState() {
    super.initState();
    section=widget.data[0];
    videosAppbarViewModel =
        Provider.of<VideosAppbarViewModel>(context, listen: false);
    recordedVideosDrawerViewModel =
        Provider.of<RecordedVideosDrawerViewModel>(context, listen: false);
  }

  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    await callApi();
  }
  Future<void> callApi() async {
    if (section== MyEnumConstants.SUBJECTWISE_VIDEO_LIST) {
      String? subjectId = widget.data[1];
      var userid=(await MySharedPreferences().getUserDetail())!.userId;
    videosAppbarViewModel.fetchSubjectwiseAllVideos(context, SubjectwiseAllVideosVideoAppBarRequest(studentId: userid!, subjectId: subjectId!));}
    else {recordedVideosDrawerViewModel.fetchRecordedVideos(context,section);}
  }

  @override
  void dispose() {
    videosAppbarViewModel.dataSubjectwiseAllVideos=null;
    recordedVideosDrawerViewModel.dataVideos=null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<RecordedVideosDrawerViewModel,VideosAppbarViewModel>(builder:
        (BuildContext context, RecordedVideosDrawerViewModel value,VideosAppbarViewModel value2,
            Widget? child) {
      return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.blue,
            title: const Text(
              "Recorded Videos",
              style: TextStyle(color: MyColors.white, fontSize: 20),
            ),

            iconTheme: const IconThemeData(
                color: Colors.white), // Change the color here
          ),
          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      getList(),
                    ],
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  // visible: recordedVideosDrawerViewModel.dataRecordedVideos!=null?recordedVideosDrawerViewModel.isLoading
                  //         :videosAppbarViewModel.dataSubjectwiseAllVideos!=null?videosAppbarViewModel.isLoading:false,
                  visible: getVisibility(),
                  child: SpinKitFadingCircle(
                    color: MyColors.blue,
                    size: MyConstants.sh * .1,
                  ),
                ),
              ),
            ],
          ));
    });
  }
 bool getVisibility(){
     if (section == MyEnumConstants.SUBJECTWISE_VIDEO_LIST) {
       return videosAppbarViewModel.isLoading;
     }
    return recordedVideosDrawerViewModel.isLoading;
 }
  Widget getList(){
    if(recordedVideosDrawerViewModel.dataVideos != null){
      return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: recordedVideosDrawerViewModel
              .dataVideos!.videoDtls!.length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return MyVideoTileLong(
                video: recordedVideosDrawerViewModel
                    .dataVideos!.videoDtls!
                    .elementAt(index));
          });
   }else if(videosAppbarViewModel.dataSubjectwiseAllVideos !=
        null){
      return ListView.builder(
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          itemCount: videosAppbarViewModel
              .dataSubjectwiseAllVideos!
              .subjectWiseVideos!
              .length,
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return MyVideoTileLong(
                video: videosAppbarViewModel
                    .dataSubjectwiseAllVideos!
                    .subjectWiseVideos!
                    .elementAt(index));
          });
    } else{
      return const SizedBox.shrink();
    }
  }
}
