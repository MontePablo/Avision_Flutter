import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/dailyAssignmentQuizlistRequest.dart';
import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/viewmodels/dailyassignment_home_viewmodel.dart';
import 'package:avision/viewmodels/quiz_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../data_models/multiApiTwoHomeResponse.dart';
import '../data_models/quiz.dart';
import '../database/quizDatabase.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

void main(){
  runApp(const DailyAssignmentPage());
}
class DailyAssignmentPage extends StatefulWidget {
  const DailyAssignmentPage({super.key});

  @override
  State<DailyAssignmentPage> createState() => _DailyAssignmentPageState();
}

class _DailyAssignmentPageState extends State<DailyAssignmentPage> {
  late DailyassignmentHomeViewmodel dailyassignmentViewmodel;
  late List<String> dateList;
   String studentId="";
  int selectedDateIndex=0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dailyassignmentViewmodel = Provider.of<DailyassignmentHomeViewmodel>(context, listen: false);
    dateList=Utility.getListOfCalculatedDate(-60);
  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    studentId=(await MySharedPreferences().getUserDetail())!.userId!;
    fetchData();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<DailyassignmentHomeViewmodel>(

        builder: (BuildContext context, DailyassignmentHomeViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Daily Assignment",style: TextStyle(color: MyColors.white,fontSize: 20),),

              iconTheme: const IconThemeData(
                  color: Colors.white), // Change the color here

            ),
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Padding(
                     padding: const EdgeInsets.all(8.0),
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         SizedBox(
                           height: MyConstants.sh*.06,
                           child: ListView.builder(
                               itemCount: dateList.length,
                               scrollDirection: Axis.horizontal,
                               itemBuilder: (context, index) {
                                 return GestureDetector(
                                   onTap: (){
                                     setState(() {
                                       selectedDateIndex=index;
                                       fetchData();
                                     });
                                   },
                                   child: MyCalenderDate(date: dateList[index],isSelected: selectedDateIndex==index,),
                                 );
                               }
                           ),
                         ),
                         dailyassignmentViewmodel.dataDailyAssigmentQuizlist != null && dailyassignmentViewmodel.dataDailyAssigmentQuizlist!.dailyAssignment!.length>0
                             ? ListView.builder(
                           shrinkWrap: true,
                           itemCount: dailyassignmentViewmodel.dataDailyAssigmentQuizlist!.dailyAssignment![0].quizList!.length,
                           scrollDirection: Axis.vertical,
                           itemBuilder: (context, index) {
                             var quiz = Utility.dailydoseQuizToQuizDetailConvert(dailyassignmentViewmodel.dataDailyAssigmentQuizlist!.dailyAssignment![0].quizList![index]);

                             return FutureBuilder(
                               future: QuizDatabase().getQuizDtlById(quiz.quizId!),
                               builder: (context, snapshot) {
                                 MyEnumConstants type;

                                 if (quiz.status == 2) {
                                   type = MyEnumConstants.RESULT_QUIZ;
                                 } else if (snapshot.hasData) {
                                   type = MyEnumConstants.RESUME_QUIZ;
                                 } else {
                                   type = MyEnumConstants.START_QUIZ;
                                 }

                                 return MyQuizListSquare(
                                   quiz: quiz,
                                   onClick: () async {
                                     if (quiz.status == 2) {
                                       Navigator.pushNamed(
                                         context,
                                         MyRoutes.quizResultPage,
                                         arguments: [MyEnumConstants.QUIZ_SECTION_DAILYDOSE, quiz.quizId],
                                       );
                                     } else if (snapshot.hasData) {
                                       Navigator.pushNamed(
                                         context,
                                         MyRoutes.quizTestPage,
                                         arguments: [MyEnumConstants.QUIZ_SECTION_DAILYDOSE, quiz, snapshot.data],
                                       );
                                     } else {
                                       MyQuizIntro(
                                         context: context,
                                         quizDetail: quiz,
                                         onClick: () async {
                                           Navigator.pushNamed(
                                             context,
                                             MyRoutes.quizTestPage,
                                             arguments: [MyEnumConstants.QUIZ_SECTION_DAILYDOSE, quiz],
                                           );
                                         },
                                       );
                                     }
                                   },
                                   type: type,
                                 );
                               },
                             );
                           },
                         )
                             : Center(heightFactor: MyConstants.sh*.04,child: Text("No Quiz Found!"),),
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: dailyassignmentViewmodel.isLoading,
                     child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                   ),
                 ),
               ],
             )
          );
        }
    );
  }

  void fetchData()  {
    var date=dateList[selectedDateIndex];
    dailyassignmentViewmodel.fetchQuizList(context, DailyassignmentQuizlistRequest(date: date, studentId: studentId!));
  }

  QuizIntroDetail convertToQuizDetail(DailyDoseQuiz quiz){
    QuizIntroDetail data=QuizIntroDetail();
    data.totalMarks= quiz.totalMarks;
    data.totalTime=quiz.totalTime;
    data.totalQuestion=quiz.totalQuestion;
    data.quizName=quiz.quizName;
    data.quizId=quiz.quizId;
    data.date=quiz.createdDate;
    data.status=quiz.status;
    return data;
  }
}
