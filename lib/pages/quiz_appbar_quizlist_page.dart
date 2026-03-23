import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/quizAppbarQuizlistRequest.dart';
import 'package:avision/data_models/quizAppbarSubjectlistResponse.dart';
import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/viewmodels/quiz_appbar_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/Utilities.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

void main(){
  runApp(const QuizAppbarQuizlistPage(data:null));
}
class QuizAppbarQuizlistPage extends StatefulWidget {
  final Subject? data; //subject
  const QuizAppbarQuizlistPage({super.key,required this.data});

  @override
  State<QuizAppbarQuizlistPage> createState() => _QuizAppbarQuizlistPageState();
}

class _QuizAppbarQuizlistPageState extends State<QuizAppbarQuizlistPage> {
  late QuizAppbarViewmodel quizAppbarViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizAppbarViewmodel = Provider.of<QuizAppbarViewmodel>(context, listen: false);
  }
  @override
  void dispose() {
    print("2 Disposed");
    super.dispose();
    quizAppbarViewmodel.dataQuizList=null;

  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var studentId=(await MySharedPreferences().getUserDetail())!.userId;
    quizAppbarViewmodel.fetchQuizList(context,
      QuizAppbarQuizlistRequest(studentId: studentId!, childTypeId: widget.data!.childTypeId.toString(), typeId: widget.data?.typeId??"")
    );
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
                         quizAppbarViewmodel.dataQuizList!=null
                             ?ListView.builder(
                             physics: const PageScrollPhysics(),
                             itemCount: quizAppbarViewmodel.dataQuizList!.questionList!.length,
                             scrollDirection: Axis.vertical,
                             shrinkWrap: true,
                             itemBuilder: (context, index) {
                               var type = MyEnumConstants.START_QUIZ;
                               var quiz = Utility.appbarQuizToQuizDetailConvert(quizAppbarViewmodel.dataQuizList!.questionList![index]);
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
                                         arguments: [MyEnumConstants.QUIZ_SECTION_APPBAR_QUIZ, quiz],
                                       );
                                     },
                                   );
                                 },
                                 type: type,
                               );
                             }):const SizedBox.shrink(),
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
