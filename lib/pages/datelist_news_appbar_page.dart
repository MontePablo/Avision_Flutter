import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
import '../viewmodels/news_appbar_viewmodel.dart';

class DateListNewsAppbarPage extends StatefulWidget {
  final TabController tabController;
  final ValueNotifier<DateTime?> valueNotifier;
  const DateListNewsAppbarPage({super.key,required this.tabController,required this.valueNotifier});

  @override
  State<DateListNewsAppbarPage> createState() => _DateListNewsAppbarPageState();
}

class _DateListNewsAppbarPageState extends State<DateListNewsAppbarPage> {
  late NewsAppbarViewmodel newsAppbarViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    newsAppbarViewmodel = Provider.of<NewsAppbarViewmodel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    newsAppbarViewmodel.fetchDateList(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<NewsAppbarViewmodel>(
        builder: (BuildContext context, NewsAppbarViewmodel value, Widget? child){
          return Scaffold(
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       children: [
                          newsAppbarViewmodel.dataDateList!=null
                         ?GridView.builder(
                            shrinkWrap: true,
                            itemCount:newsAppbarViewmodel.dataDateList!.newsAnalysis!.length ,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.33,
                            ),
                            physics: const ScrollPhysics(),
                            itemBuilder: (context,index){
                              return MyDateItemNewsAppbar(
                                  date: newsAppbarViewmodel.dataDateList!.newsAnalysis!.elementAt(index),
                                  onClick: (){
                                    widget.tabController.animateTo(0);
                                    widget.valueNotifier.value= newsAppbarViewmodel.dataDateList!.newsAnalysis!.elementAt(index).postedDate!;
                                  },
                              );
                            },
                          ):const SizedBox.shrink()
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: newsAppbarViewmodel.isLoading,
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
