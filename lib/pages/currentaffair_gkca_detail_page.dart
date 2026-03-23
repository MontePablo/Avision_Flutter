import 'package:avision/data_models/currentAffairsGkcaResponse.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const CurrentAffairGkcaDetailPage(data:null,));
}
class CurrentAffairGkcaDetailPage extends StatefulWidget {
  final CurrentAffairGkca? data;
  const CurrentAffairGkcaDetailPage({super.key,required this.data});

  @override
  State<CurrentAffairGkcaDetailPage> createState() => _CurrentAffairGkcaDetailPageState();
}

class _CurrentAffairGkcaDetailPageState extends State<CurrentAffairGkcaDetailPage> {
  @override
  void initState() {
    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordedVideosDrawerViewModel>(
        builder: (BuildContext context, RecordedVideosDrawerViewModel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("",style: TextStyle(color: MyColors.white,fontSize: 16),),

              iconTheme: const IconThemeData(
                  color: Colors.white), // Change the color here

            ),
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       children: [
                         CachedNetworkImage(
                           imageUrl: widget.data!.shareLink!,
                           placeholder: (context, url) =>const CircleAvatar(backgroundColor: Colors.white,
                             child: CircularProgressIndicator(),
                           ),
                           // progressIndicatorBuilder: (context, url, downloadProgress) =>
                           //     CircularProgressIndicator(value: downloadProgress.progress),
                           errorWidget: (context, url, error) =>const Icon(Icons.image_not_supported),
                         ),
                         SizedBox(height: MyConstants.sh*.01,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                           Text(widget.data!.postType!),
                           Text(widget.data!.postDate!)
                         ],),
                         SizedBox(height: MyConstants.sh*.01,),
                         Text(widget.data!.postTitle!,style: TextStyle(fontWeight: FontWeight.bold),),
                         SizedBox(height: MyConstants.sh*.01,),
                         Text(widget.data!.postContent!),
                       ],
                     ),
                   ),
                 ),
               ],
             )
          );
        }
    );
  }
}
