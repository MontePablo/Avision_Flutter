import 'package:avision/data_models/currentAffairsGkcaResponse.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../data_models/newsListNewsAppBarResponse.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const NewsDetailNewsAppbarPage(data:null,));
}
class NewsDetailNewsAppbarPage extends StatefulWidget {
  final News? data;
  const NewsDetailNewsAppbarPage({super.key,required this.data});

  @override
  State<NewsDetailNewsAppbarPage> createState() => _NewsDetailNewsAppbarPageState();
}

class _NewsDetailNewsAppbarPageState extends State<NewsDetailNewsAppbarPage> {
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
                         SizedBox(height: MyConstants.sh*.01,),
                         Text(widget.data!.title!,style: const TextStyle(fontWeight: FontWeight.bold),),
                         SizedBox(height: MyConstants.sh*.01,),
                         CachedNetworkImage(
                           imageUrl: widget.data!.imageUrl!,
                           placeholder: (context, url) =>const CircleAvatar(backgroundColor: Colors.white,
                             child: CircularProgressIndicator(),
                           ),
                           // progressIndicatorBuilder: (context, url, downloadProgress) =>
                           //     CircularProgressIndicator(value: downloadProgress.progress),
                           errorWidget: (context, url, error) =>const Icon(Icons.image_not_supported),
                         ),
                         SizedBox(height: MyConstants.sh*.01,),
                          Html(data: widget.data!.content!),
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
