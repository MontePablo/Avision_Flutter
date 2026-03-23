import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/dailyVocabContentStudentzoneRequest.dart';
import 'package:avision/viewmodels/dailyvocab_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

void main(){
  runApp(const DailyVocabStudentzonePage());
}
class DailyVocabStudentzonePage extends StatefulWidget {
  const DailyVocabStudentzonePage({super.key});

  @override
  State<DailyVocabStudentzonePage> createState() => _DailyVocabStudentzonePageState();

}

class _DailyVocabStudentzonePageState extends State<DailyVocabStudentzonePage> {
  late DailyvocabStudentzoneViewmodel dailyvocabStudentzoneViewmodel;
  bool isNavigated = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dailyvocabStudentzoneViewmodel = Provider.of<DailyvocabStudentzoneViewmodel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    dailyvocabStudentzoneViewmodel.fetchDailyVocabList(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    dailyvocabStudentzoneViewmodel.dataDailyVocabList=null;
  }
  @override
  Widget build(BuildContext context) {

    return Consumer<DailyvocabStudentzoneViewmodel>(
        builder: (BuildContext context, DailyvocabStudentzoneViewmodel value, Widget? child){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if(dailyvocabStudentzoneViewmodel.dataDailyVocabContent!=null){
              if (!isNavigated) {
                isNavigated = true;

                Navigator.pushNamed(
                  context,
                  MyRoutes.webviewPage,
                  arguments: dailyvocabStudentzoneViewmodel.dataDailyVocabContent!.dailyVocabList!.postContent,
                ).then((_) {
                  // Reset the flag when coming back to the page
                  isNavigated = false;
                  dailyvocabStudentzoneViewmodel.dataDailyVocabContent=null;
                });
              }
            }
          });
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Daily Vocabulary",style: TextStyle(color: MyColors.white,fontSize: 20),),

              iconTheme: const IconThemeData(
                  color: Colors.white), // Change the color here

            ),
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: dailyvocabStudentzoneViewmodel.dataDailyVocabList!=null?
                     ListView.builder(
                         shrinkWrap: true,
                         physics: const ScrollPhysics(),
                         itemCount: dailyvocabStudentzoneViewmodel.dataDailyVocabList!.result!.length,
                         itemBuilder: (context, index) {
                           return MyDailyVocabItem(
                             vocab: dailyvocabStudentzoneViewmodel
                                 .dataDailyVocabList!.result!
                                 .elementAt(index),
                             onClick: (){
                               dailyvocabStudentzoneViewmodel.fetchDailyVocabContent(context,
                                   DailyVocabContentStudentzoneRequest(
                                       postId: dailyvocabStudentzoneViewmodel
                                           .dataDailyVocabList!.result!
                                           .elementAt(index).id!)
                               );
                             },
                           );
                         })
                         :const SizedBox.shrink()
                     ,
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: dailyvocabStudentzoneViewmodel.isLoading,
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