import 'package:avision/viewmodels/gkca_appbar_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../custom_widgets/my_custom_widgets.dart';
import '../data_models/quizlistGkcaResponse.dart';
import '../utils/Utilities.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

class QuizlistGkcaPage extends StatefulWidget {
  const QuizlistGkcaPage({super.key});

  @override
  State<QuizlistGkcaPage> createState() => _RecordedVideosDrawerPageState();
}

class _RecordedVideosDrawerPageState extends State<QuizlistGkcaPage> {
  late GkcaAppbarViewmodel gkcaAppbarViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    gkcaAppbarViewmodel = Provider.of<GkcaAppbarViewmodel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  gkcaAppbarViewmodel.fetchQuizlist(context);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    gkcaAppbarViewmodel.dataQuizlist=null;
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GkcaAppbarViewmodel>(
        builder: (BuildContext context, GkcaAppbarViewmodel value, Widget? child){
          return Scaffold(
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Column(
                     children: [
                       Container(
                         height: MyConstants.sh,
                         child: gkcaAppbarViewmodel.dataQuizlist!=null
                             ?ListView.builder(
                             itemCount: gkcaAppbarViewmodel.dataQuizlist!.scheduleList!.length,
                             itemBuilder: (context, index) {
                               List<GkcaQuiz> item=gkcaAppbarViewmodel.dataQuizlist!.scheduleList!;
                               var type = MyEnumConstants.START_QUIZ;
                               var quiz = Utility.gkcaQuizToQuizDetailConvert(item[index]);
                               return MyQuizListLong(
                               quiz: quiz,
                                 onClick: () async {
                                   MyQuizIntro(
                                     context: context,
                                     quizDetail: quiz,
                                     onClick: () async {
                                       Navigator.of(context).pop();
                                       Navigator.pushNamed(
                                         context,
                                         MyRoutes.quizTestPage,
                                         arguments: [MyEnumConstants.QUIZ_SECTION_APPBAR_GKCA, quiz],
                                       );
                                     },
                                   );
                                 },
                                 type: type,
                               );
                             }):const SizedBox.shrink(),
                       ),
                     ],
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: gkcaAppbarViewmodel.isLoading,
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
