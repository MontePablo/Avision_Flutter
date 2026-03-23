import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/viewmodels/gkca_appbar_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const CurrentAffairsGkcaPage());
}
class CurrentAffairsGkcaPage extends StatefulWidget {
  const CurrentAffairsGkcaPage({super.key});

  @override
  State<CurrentAffairsGkcaPage> createState() => _CurrentAffairsGkcaPageState();
}

class _CurrentAffairsGkcaPageState extends State<CurrentAffairsGkcaPage> {
  late GkcaAppbarViewmodel gkcaViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gkcaViewmodel = Provider.of<GkcaAppbarViewmodel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    gkcaViewmodel.fetchCurrentAffairs(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gkcaViewmodel.dataCurrentAffairs=null;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GkcaAppbarViewmodel>(
        builder: (BuildContext context, GkcaAppbarViewmodel value, Widget? child){
          return Scaffold(
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       children: [
                         gkcaViewmodel.dataCurrentAffairs!=null
                         ?
                         Container(
                           height: MyConstants.sh,
                           child: ListView.builder(
                             itemCount: gkcaViewmodel.dataCurrentAffairs!.message!.length,
                             itemBuilder: (context, index) {
                               // print("size:"+gkcaViewmodel.dataCurrentAffairs!.message!.length.toString());
                               return MyCurrentAffairGkcaItem(currentAffair: gkcaViewmodel.dataCurrentAffairs!.message!.elementAt(index));
                             },
                           ),
                         ): const SizedBox.shrink(),

                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: gkcaViewmodel.isLoading,
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
