import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/viewmodels/quiz_appbar_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

void main(){
  runApp(const QuizAppbarSubjectlistPage());
}
class QuizAppbarSubjectlistPage extends StatefulWidget {
  const QuizAppbarSubjectlistPage({super.key});

  @override
  State<QuizAppbarSubjectlistPage> createState() => _QuizAppbarSubjectlistPageState();
}

class _QuizAppbarSubjectlistPageState extends State<QuizAppbarSubjectlistPage> {
  late QuizAppbarViewmodel quizAppbarViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizAppbarViewmodel = Provider.of<QuizAppbarViewmodel>(context, listen: false);
  }
  @override
  void dispose() {
    print("1 Disposed");
    // TODO: implement dispose
    super.dispose();
    quizAppbarViewmodel.dataSubjectList=null;
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    quizAppbarViewmodel.fetchSubjectList(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizAppbarViewmodel>(
        builder: (BuildContext context, QuizAppbarViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Quiz",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                          quizAppbarViewmodel.dataSubjectList!=null
                         ? GridView.builder(
                            shrinkWrap: true,
                            itemCount:quizAppbarViewmodel.dataSubjectList?.scheduleList?.length ,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 1,
                            ),
                            physics: const ScrollPhysics(),
                            itemBuilder: (context,index){
                              return QuizSubjectList(subject: quizAppbarViewmodel.dataSubjectList!.scheduleList![index], onClick: (){
                                Navigator.pushNamed(context, MyRoutes.quizAppbarQuizlistPage,arguments: quizAppbarViewmodel.dataSubjectList!.scheduleList![index]);
                              });
                            },
                          ):const SizedBox.shrink()
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: quizAppbarViewmodel.isLoading,
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
