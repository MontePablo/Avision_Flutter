import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/prevyearpaperSubjectsRequest.dart';
import 'package:avision/data_models/prevyearpaperTestsRequest.dart';
import 'package:avision/viewmodels/prevyearpaper_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../storage/shared_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const PrevyearpaperTestsPage(data:null));
}
class PrevyearpaperTestsPage extends StatefulWidget {
  const PrevyearpaperTestsPage({super.key,required this.data});
  final List<String>? data;

  @override
  State<PrevyearpaperTestsPage> createState() => _RecordedVideosDrawerPageState();
}

class _RecordedVideosDrawerPageState extends State<PrevyearpaperTestsPage> {
  late PrevyearpaperStudentzoneViewmodel prevyearpaperStudentzoneViewmodel;
  @override
  void initState() {
    super.initState();
    prevyearpaperStudentzoneViewmodel = Provider.of<PrevyearpaperStudentzoneViewmodel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    MySharedPreferences().getUserDetail().then((value) {
      prevyearpaperStudentzoneViewmodel.fetchTestList(
        context,
          PrevyearpaperTestsRequest(
              studentId: value!.userId??"",
              sectionId: widget.data![0],
              subCatId: widget.data![1])
      );

    });
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<RecordedVideosDrawerViewModel>(
        builder: (BuildContext context, RecordedVideosDrawerViewModel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Previous year papers",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                         prevyearpaperStudentzoneViewmodel.dataPrevyrpaperTests!=null
                         ? ListView.builder(
                             shrinkWrap: true,
                             physics: const ScrollPhysics(),
                             itemCount: prevyearpaperStudentzoneViewmodel.dataPrevyrpaperSubjects!.previousYearTestList!.length,
                             itemBuilder: (context, index) {
                               return MyPrevYrPaperTestItem(
                                 test: prevyearpaperStudentzoneViewmodel
                                     .dataPrevyrpaperTests!.previousYearQuizList![index],
                                 onClick: (){

                                 },
                               );
                             })
                         : const SizedBox.shrink()
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: prevyearpaperStudentzoneViewmodel.isLoading,
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
