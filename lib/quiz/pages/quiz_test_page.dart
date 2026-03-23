import 'dart:async';

import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/quiz.dart';
import 'package:avision/database/quizDatabase.dart';
import 'package:avision/quiz/datamodels/ansSubmitRequest.dart';
import 'package:avision/quiz/datamodels/questionResponse.dart';
import 'package:avision/quiz/datamodels/resultResponse.dart';
import 'package:avision/quiz/datamodels/studentIdQuizIdRequest.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/viewmodels/quiz_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../storage/shared_preferences.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';
void main(){
  runApp(const QuizTestPage(data: []));
}

class QuizTestPage extends StatefulWidget {
  final List<dynamic> data;
  const QuizTestPage({super.key,required this.data});

  @override
  State<QuizTestPage> createState() => _QuizTestPageState();
}

class _QuizTestPageState extends State<QuizTestPage> {
  late QuizAnsSubmitRequest ansSubmit;
  late QuizIntroDetail quizIntroDetail;
  late MyEnumConstants section;
  QuizDtl? offlineQuiz;
  int _currentIndex=0;
  late QuizViewmodel quizViewmodel;
  late CountdownTimerWidget timer;
  final CarouselSliderController? _carouselSliderController = CarouselSliderController();

  @override
  void dispose() {
    quizViewmodel.dataQuestions=null;
    quizViewmodel.dataAnsSubmitResponse=null;
    super.dispose();
    timer.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    timer = CountdownTimerWidget(key: GlobalKey<CountdownTimerWidgetState>());
    quizViewmodel = Provider.of<QuizViewmodel>(context, listen: false);
    timer.setOnFinish(finishExam);
  }


  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    section=widget.data[0];
    quizIntroDetail=widget.data[1];
    if(widget.data.length>2) {
      offlineQuiz=widget.data[2];
    }
    String studentId=(await MySharedPreferences().getUserDetail())!.userId!;
    if(offlineQuiz==null){
      quizViewmodel.fetchQuestion(context, section,
          StudentIdQuizIdRequest(quizId: quizIntroDetail.quizId!, studentId: studentId)
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewmodel>(
        builder: (BuildContext context, QuizViewmodel value, Widget? child){
          if(quizViewmodel.dataQuestions!=null && offlineQuiz==null){
            offlineQuiz=quizViewmodel.dataQuestions?.questionList?[0];
          }
          Timer(const Duration(milliseconds:400 ), () {
            if(offlineQuiz!=null && (timer.isRunning()??false)==false){
              timer.setTime(offlineQuiz!.timeLeftInSec??offlineQuiz!.totalTime!);
            }
          });

          // WidgetsBinding.instance.addPostFrameCallback((_) {
          //   if(quizViewmodel.dataAnsSubmitResponse!=null){
          //     if(quizViewmodel.dataAnsSubmitResponse?.statusCode=="200"){
          //      gotoNextPage();
          //     }else{
          //       Utility.flushbarPositiveMsg(quizViewmodel.dataAnsSubmitResponse!.message??"", context);
          //     }
          //   }
          // });




          return PopScope(
            canPop: false,
             // onPopInvokedWithResult: (didPop, result) => {
             //   PauseExitDialog(context: context,onPause: (){
             //   Navigator.of(context).pop();
             //   onPause();
             //   })
             // },
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: MyColors.blue,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: MyButtonRound(color: Colors.white,textColor: MyColors.blue, fontSize: 14, cornerRadius: 10,
                      onClick: () async {
                      MyQuizFinalDialog(context:context,currentTime: timer.getTimeLeft(),
                          onClick: (){
                        Navigator.of(context).pop();
                        finishExam();
                        },ansSubmit: await getResult());
                    }, title: "finish", paddingSides: 20,),
                  )
                ],
                title: SizedBox(
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          child: Icon(CupertinoIcons.pause_circle,size: 30,),
                          onTap: (){
                            PauseExitDialog(context: context,onPause: (){
                              Navigator.of(context).pop();
                              onPause();
                            });
                          },
                        ),
                        SizedBox(width: MyConstants.sw*.03,),
                        timer,
                      ],
                    ),
                  ),
                ),
            
                iconTheme: const IconThemeData(
                    color: Colors.white), // Change the color here
            
              ),
               body:Stack(
                 children: [
                   SizedBox(
                     // height: MyConstants.sh*.84,
                     child: Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: Column(
                         children: [
                            offlineQuiz!=null?
                       CarouselSlider(
                         carouselController: _carouselSliderController, // Attach the controller
                         items: offlineQuiz?.questionDtls!.asMap().entries.map((entry) {
                         var index = entry.key;
                         var question = entry.value;
                         return QuizQuestion(usage:MyEnumConstants.LIVE_EXAM,questionDtl: question, index: index, onAnsClick: ansClick);
                       }).toList(),
                       options: CarouselOptions(
                         height: MyConstants.sh*.83,
                         enlargeCenterPage: true,
                         // autoPlay: true,
                         aspectRatio: 16/9,
                         viewportFraction: 1,
                         onPageChanged: (index, reason) {
                           setState(() {
                             _currentIndex = index;
                           });
                         },
                       ),
            
                     )
                       :const SizedBox.shrink(),
                         ],
                       ),
                     ),
                   ),
                   Positioned(
                     left: 0,right: 0,bottom: MyConstants.sh*.080,
                     child: Padding(
                       padding: const EdgeInsets.only(bottom: 4),
                       child: Container(
                         height: MyConstants.sh*.05,
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             MyButtonBordered(paddingSides:40,color: Colors.white, textColor: MyColors.blue,borderColor: MyColors.blue, fontSize: 15, cornerRadius: 10,borderWidth: 2,
                                 onClick:(){
                               markAsReview(offlineQuiz?.questionDtls?[_currentIndex]);
                               },
                                 title: "Mark for review"),
                             MyButtonBordered(paddingSides:40,color: Colors.white, textColor: MyColors.blue,borderColor: MyColors.blue, fontSize: 15, cornerRadius: 10,borderWidth: 2,
                                 onClick: (){
                                   clearSelection(offlineQuiz?.questionDtls?[_currentIndex]);
                               },
                                 title: "Clear selection"),
                           ],
                         ),
                       ),
                     ),
                   ),
                   Positioned(
                     left: 0,right: 0,bottom: 0,
                     child: SizedBox(
                       height: MyConstants.sh*.07,
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceAround,
                         children: [
                           MyButtonWithIcon(icon: Icons.chevron_left,direction: "left",width: MyConstants.sw*.5, iconSize: MyConstants.sw*.1,paddingSides: 1, color: MyColors.white, textColor: MyColors.blue, fontSize: 15, cornerRadius: 10, onClick: (){prevPage(context);}, title: "Prev"),
                           MyButtonWithIcon(icon: Icons.chevron_right,direction: "right",width: MyConstants.sw*.5, iconSize: MyConstants.sw*.1,paddingSides: 1, color: MyColors.white, textColor: MyColors.blue, fontSize: 15, cornerRadius: 10, onClick: (){nextPage(context);}, title: "Next")
            
            
                         ],
                       ),
                     ),
                   ),
            
            
                   Center(
                     child: Visibility(
                       visible: quizViewmodel.isLoading,
                       child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                     ),
                   ),
                 ],
               )
            ),
          );
        }
    );

  }
  void nextPage(BuildContext context){
    _carouselSliderController?.nextPage(
      duration:const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
  void prevPage(BuildContext context){
    _carouselSliderController?.previousPage(
      duration:const Duration(milliseconds: 300),
      curve: Curves.linear,
    );
  }
  void ansClick(int index,QuestionDtl question){
     question.selectedAnsPos=index;
     question.givenAnsStat=question.ans?[index].answerId;
     setState(() {});
  }
  void markAsReview(QuestionDtl? question){
    question?.isReviewed=!(question.isReviewed??false);
    setState(() {});
  }
  void clearSelection(QuestionDtl? question){
    question?.selectedAnsPos=null;
    setState(() {});
  }
  Future<QuizAnsSubmitRequest> getResult() async {
    int correct=0;int incorrect=0; int notAnswered=0;int posMark=0;double negMark=0;int reviewed=0;
    QuizAnsSubmitRequest ansSubmit=QuizAnsSubmitRequest();
    ansSubmit.quizId=offlineQuiz?.testId;
    ansSubmit.userId=(await MySharedPreferences().getUserDetail())?.userId;
    ansSubmit.questionAnswerList=[];
    for(var question in offlineQuiz!.questionDtls!){
      if(question.isReviewed??false){
        reviewed++;
      }
      if(question.selectedAnsPos==null){
        notAnswered++;
      }else if(question.ans?[question.selectedAnsPos!].answerStatus == "1" ){
        correct++;
      }else{
        incorrect++;
      }
      ansSubmit.questionAnswerList?.add(
          QuestionAnswerList(
              questionId: question.questionId,
              answerId: question.selectedAnsPos!=null?(question.ans?[question.selectedAnsPos!].answerId):"0")
      );
    }
    posMark=(correct*offlineQuiz!.correctMarks!);
    negMark=incorrect*(offlineQuiz!.negativeMarks??0);
    ansSubmit.marksObtained=posMark-negMark;
    ansSubmit.attempt=correct+incorrect;
    ansSubmit.notAttempt=notAnswered;
    ansSubmit.review=reviewed;
    ansSubmit.correct=correct;
    ansSubmit.incorrect=incorrect;
    print(ansSubmit.toJson().toString());
    return ansSubmit;
  }
  Future<void> finishExam() async {
    ansSubmit=await getResult();
    ansSubmit.timeTaken=timer.getTotalTimeTaken();
    quizViewmodel.submitAns(context, section, ansSubmit);
    gotoNextPage();
  }
  Future<void> onPause() async {
    offlineQuiz?.timeLeftInSec=timer.getTimeLeft();
    if(section==MyEnumConstants.QUIZ_SECTION_DAILYDOSE){
      await QuizDatabase().saveQuizDtl(offlineQuiz!);
    }
    dispose();
    Navigator.of(context).pop();
  }
  void gotoNextPage(){
    var offlineResult=Result();
    offlineResult.totalTime=ansSubmit.timeTaken;
    offlineResult.totalMarks=ansSubmit.marksObtained?.toInt();
    offlineResult.correctAnswer=ansSubmit.correct;
    offlineResult.skip=ansSubmit.notAttempt;
    offlineResult.wrongAnswer=ansSubmit.incorrect;
    offlineResult.totalCalculatedTime= "${ansSubmit.timeTaken??0 / 60} minutes";
    Navigator.pushReplacementNamed(context, MyRoutes.quizResultPage, arguments:[section,quizIntroDetail.quizId,offlineResult, offlineQuiz?.questionDtls!],);
    dispose();
  }
}
