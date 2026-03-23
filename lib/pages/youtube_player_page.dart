import 'package:avision/data_models/loginResponse.dart';
import 'package:avision/data_models/recordedvideosDrawerResponse.dart';
import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const YoutubePlayerPage(data: null,));
}
class YoutubePlayerPage extends StatefulWidget {
  final Video? data;
  const YoutubePlayerPage({super.key,required this.data});

  @override
  State<YoutubePlayerPage> createState() => _YoutubePlayerPageState();
}

class _YoutubePlayerPageState extends State<YoutubePlayerPage> {
  YoutubePlayerController? controller;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {
    // final LoginResponse? data = ModalRoute.of(context)!.settings.arguments as LoginResponse?;
    if (widget.data != null) {
      controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.data!.videoLink!)!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
          mute: false,
          loop: false,
        ),
      );
      setState(() {});
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.blue,
        title:  Text(widget.data!.typeName??"Video Player",style: const TextStyle(color: MyColors.white,fontSize: 18),),

        iconTheme: const IconThemeData(
            color: Colors.white), // Change the color here

      ),
       body:Column(
         children: [
           SizedBox(height: MyConstants.sh*.02,),
           YoutubePlayer(
            controller: controller!,
            bottomActions: [
              CurrentPosition(),
              ProgressBar(isExpanded: true),
              RemainingDuration(),
              const PlaybackSpeedButton(),
              FullScreenButton(),
            ],
          ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: SizedBox(
               width: MyConstants.sw*.8,
                 child: Text(widget.data!.videoName!,textAlign: TextAlign.center,style:const TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),
           ),
           Padding(
             padding: const EdgeInsets.all(8.0),
             child: Text(widget.data!.typeName!,style: const TextStyle(fontSize: 17),),
           )
         ],
       )
    );
  }
}
