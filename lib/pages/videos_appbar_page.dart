import 'package:avision/data_models/subjectwiseVideoVideosAppBarRequest.dart';
import 'package:avision/data_models/trendingvideoVideosAppBarRequest.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:avision/viewmodels/videos_appbar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/my_custom_widgets.dart';
import '../storage/shared_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const VideosAppBarPage());
}
class VideosAppBarPage extends StatefulWidget {
  const VideosAppBarPage({super.key});

  @override
  State<VideosAppBarPage> createState() => _VideosAppBarPageState();
}

class _VideosAppBarPageState extends State<VideosAppBarPage> {
  late VideosAppbarViewModel videosAppbarViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    videosAppbarViewmodel = Provider.of<VideosAppbarViewModel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    MySharedPreferences().getUserDetail().then((value) {
      videosAppbarViewmodel.fetchTrendingVideos(
        context,
        TrendingVideoVideosAppBarRequest(studentId: value?.userId ?? ""),
      );
      videosAppbarViewmodel.fetchSubjectWiseVideos(
        context,
        SubjectWiseVideoVideosAppBarRequest(studentId: value?.userId ?? ""),
      );
    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<VideosAppbarViewModel>(
        builder: (BuildContext context, VideosAppbarViewModel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Videos",style: TextStyle(color: MyColors.white,fontSize: 20),),

              iconTheme: const IconThemeData(
                  color: Colors.white), // Change the color here

            ),
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       crossAxisAlignment: CrossAxisAlignment.start,
                       children: [
                         const Text(
                           "Trending Videos",
                           style: TextStyle(
                               color: Colors.black87,
                               fontSize: 18,
                               fontWeight: FontWeight.bold),
                         ),
                        videosAppbarViewmodel.dataTrendingVideos!=null
                         ? ListView.builder(
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: videosAppbarViewmodel.dataTrendingVideos!.latestVideos!.length,
                            scrollDirection: Axis.vertical,
                            itemBuilder: (context, index) {
                              return MyVideoTileLong(
                                  video: videosAppbarViewmodel.dataTrendingVideos!.latestVideos!.elementAt(index));
                            })
                         :const SizedBox.shrink(),
                         SizedBox(height: MyConstants.sh*.02,),

                         videosAppbarViewmodel.dataSubjectWiseVideos!=null
                             ? ListView.builder(
                             shrinkWrap: true,
                             physics: const ScrollPhysics(),
                             itemCount: videosAppbarViewmodel.dataSubjectWiseVideos!.subjectWiseVideos!.length,
                             scrollDirection: Axis.vertical,
                             itemBuilder: (context, index) {
                               return MySubjectwiseVideoListItem(
                                   subjectWiseVideo: videosAppbarViewmodel.dataSubjectWiseVideos!.subjectWiseVideos!.elementAt(index));
                             })
                             :const SizedBox.shrink(),
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: videosAppbarViewmodel.isLoading,
                     child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                   ),
                 ),
               ],
             )
          );
        }
    );
  }
}
