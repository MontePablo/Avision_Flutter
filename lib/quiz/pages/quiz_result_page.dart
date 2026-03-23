import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/quiz.dart';
import 'package:avision/quiz/datamodels/resultResponse.dart';
import 'package:avision/quiz/datamodels/studentIdQuizIdRequest.dart';
import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/viewmodels/quiz_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../utils/routes.dart';
import '../datamodels/questionResponse.dart';

void main(){
  runApp(const QuizResultPage(data: []));
}
class QuizResultPage extends StatefulWidget {
  final List<dynamic> data;
  const QuizResultPage({super.key, required this.data});

  @override
  State<QuizResultPage> createState() => _QuizResultPageState();
}

class _QuizResultPageState extends State<QuizResultPage> {
  late MyEnumConstants section;
  late String quidId;
  late QuizViewmodel quizViewmodel;
   Result? offlineResult;
   List<QuestionDtl>? offlineQuesAns;
  late Map<String,double> dataMap;

  final gradientList = <List<Color>>[
    [
      Color.fromRGBO(223, 250, 92, 1),
      Color.fromRGBO(129, 250, 112, 1),
    ],
    [
      Color.fromRGBO(175, 63, 62, 1.0),
      Color.fromRGBO(254, 154, 92, 1),
    ],
    [
      Color.fromRGBO(129, 182, 205, 1),
      Color.fromRGBO(91, 221, 253, 1.0),
    ]
  ];
  // final colorList = <Color>[
  //   Colors.greenAccent,
  // ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quizViewmodel = Provider.of<QuizViewmodel>(context, listen: false);
    section=widget.data[0];
    quidId=widget.data[1];
    if(widget.data.length>2){
      offlineResult=widget.data[2];
      offlineQuesAns=widget.data[3];
    }
  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    String studentId=(await MySharedPreferences().getUserDetail())!.userId!;
    quizViewmodel.fetchResult(context,section,
      StudentIdQuizIdRequest(quizId: quidId, studentId:studentId )
    );
    quizViewmodel.fetchRank(context,section,
        StudentIdQuizIdRequest(quizId: quidId, studentId:studentId )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewmodel>(
        builder: (BuildContext context, QuizViewmodel value, Widget? child){
          return Scaffold(
             body:Stack(
               children: [
                 Positioned(
                   top: 0,
                     left: 0,
                     right: 0,
                     child: Image.asset("assets/images/back_drawing.png")),
                 SingleChildScrollView(
                   child: Column(
                     children: [
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: Column(
                           children: [
                             SizedBox(height: MyConstants.sh*.07,),
                             offlineResult!=null? marksToUi(offlineResult!)
                                 : quizViewmodel.dataResult!=null && quizViewmodel.dataResult?.statusCode=="200"
                                 ? marksToUi(quizViewmodel.dataResult!.message!) :const SizedBox.shrink(),
                             SizedBox(height: MyConstants.sh*.05,),
                             MyButtonRound(color: MyColors.blue, textColor: Colors.white, fontSize: 15, cornerRadius: 10,
                                 onClick:(){
                                   Navigator.pushNamed(context, MyRoutes.quizCorrectAnsPage,arguments:[section,quidId, offlineQuesAns],);
                                 }, title: "View Solution", paddingSides: 5),
                             quizViewmodel.dataRank!=null
                                 ?ListView.builder(
                                 shrinkWrap: true,
                                 physics: const ScrollPhysics(),
                                 itemCount: quizViewmodel.dataRank!.rankInfo!.studentArr!.length,
                                 scrollDirection: Axis.vertical,
                                 itemBuilder: (context, index) {
                                   return MyQuizRank(
                                     total: quizViewmodel.dataRank!.rankInfo!.studentArr!.length,
                                     studentRank: quizViewmodel.dataRank!.rankInfo!.studentArr![index],

                                   );
                                 }
                             ):const SizedBox.shrink()
                           ],
                         ),
                       ),
                     ],
                   ),
                 ),
                 quizViewmodel.dataRank!=null
                     ?Positioned(
                   left: MyConstants.sw*.05,
                   top: MyConstants.sh*.5,
                   bottom: 0,
                   child: SizedBox(
                     child: Column(
                       children: [
                         const Text("Rank *",style: TextStyle(color: Colors.black45),),
                         Row(
                           children: [
                             Text(quizViewmodel.dataRank!.rankInfo!.studentRank.toString(),style: const TextStyle(color: Colors.green,fontWeight: FontWeight.bold,fontSize: 25),),
                             Text(" /${quizViewmodel.dataRank!.rankInfo!.studentArr!.length}")

                           ],
                         )
                       ],
                     ),
                   ),
                 ):const SizedBox.shrink(),
                 Center(
                   child: Visibility(
                     visible: quizViewmodel.isLoading,
                     child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                   ),
                 ),
                 Positioned(
                   left: 0,
                   top: MyConstants.sh*.03,
                   child: Padding(
                     padding: const EdgeInsets.all(5.0),
                     child: InkWell(
                       child: const Icon(
                         Icons.arrow_back,
                         color: MyColors.white,
                       ),
                       onTap: () {
                         Navigator.of(context).pop();
                       },
                     ),
                   ),
                 ),
               ],
             )
          );
        }
    );
  }

  Widget marksToUi(Result result){
    return Column(
      children: [
        SizedBox(height: MyConstants.sh*.5,
          width: MyConstants.sw,
          child:  PieChart(
            dataMap: {
              "Correct":result.correctAnswer!.toDouble(),
              "Incorrect":result.wrongAnswer!.toDouble(),
              "NotAnswered":result.skip!.toDouble()
            },
            chartType: ChartType.disc,
            baseChartColor: Colors.grey[300]!,
            // colorList: colorList,
            gradientList: gradientList,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text("Correct",style: TextStyle(color: Colors.green),),
                Text(result.correctAnswer.toString(),style: const TextStyle(color: Colors.green))
              ],
            ),
            Column(
              children: [
                const Text("InCorrect",style: TextStyle(color: Colors.red),),
                Text(result.wrongAnswer.toString(),style:const TextStyle(color: Colors.red))
              ],
            ),
            Column(
              children: [
                const Text("Unattempted",),
                Text(result.skip.toString())
              ],
            )
          ],
        ),
      ],
    );
  }
}
