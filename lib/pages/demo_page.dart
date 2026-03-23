import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const RecordedVideosDrawerPage(data:null));
}
class RecordedVideosDrawerPage extends StatefulWidget {
  final MyEnumConstants? data;
  const RecordedVideosDrawerPage({super.key,required this.data});

  @override
  State<RecordedVideosDrawerPage> createState() => _RecordedVideosDrawerPageState();
}

class _RecordedVideosDrawerPageState extends State<RecordedVideosDrawerPage> {
  late RecordedVideosDrawerViewModel recordedVideosDrawerViewModel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    recordedVideosDrawerViewModel = Provider.of<RecordedVideosDrawerViewModel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // recordedVideosDrawerViewModel.fetchRecordedVideos(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordedVideosDrawerViewModel>(
        builder: (BuildContext context, RecordedVideosDrawerViewModel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Recorded Videos",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                          
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: recordedVideosDrawerViewModel.isLoading,
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
