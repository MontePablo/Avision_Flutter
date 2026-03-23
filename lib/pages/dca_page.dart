import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/pages/currentaffairs_gkca_page.dart';
import 'package:avision/pages/datelist_news_appbar_page.dart';
import 'package:avision/pages/newslist_news_appbar_page.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/viewmodels/dca_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:avision/viewmodels/magazineGaBooster_studentzone_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const DcaStudentzonePage());
}
class DcaStudentzonePage extends StatefulWidget {
  const DcaStudentzonePage({super.key});
  @override
  State<DcaStudentzonePage> createState() => _DcaStudentzonePageState();
}

class _DcaStudentzonePageState extends State<DcaStudentzonePage> {
  late DcaStudentzoneViewmodel viewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewmodel = Provider.of<DcaStudentzoneViewmodel>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewmodel.fetchDcaList(context);
    });

  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    viewmodel.dataDcaResponse=null;
  }


  @override
  Widget build(BuildContext context) {

    return Consumer<DcaStudentzoneViewmodel>(
        builder: (BuildContext context, DcaStudentzoneViewmodel value, Widget? child) {
          return Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.blue,
                title:
                Text("Daily Current Affairs", style: TextStyle(color: MyColors.white,fontSize: 16),),
                iconTheme: const IconThemeData(
                    color: Colors.white), // Change the color here
              ),
              body:Stack(
                children: [
                  Column(
                    children: [

                      Expanded(
                        child: SingleChildScrollView(
                            physics:const ScrollPhysics(),
                            child: viewmodel.dataDcaResponse!=null ?
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const ScrollPhysics(),
                                itemCount: viewmodel.dataDcaResponse!.newsAnalysis!.currentAffairs!.length,
                                itemBuilder: (context, index) {
                                  return MyDcaItem(
                                      data: viewmodel.dataDcaResponse!.newsAnalysis!.currentAffairs!.elementAt(index));
                                }) :
                                const SizedBox.shrink()
                        ),
                      )
                    ],
                  ),
                  Center(
                    child: Visibility(
                      visible: viewmodel.isLoading,
                      child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                    ),
                  ),
                ]
              )
          );
        }
    );
  }
}
