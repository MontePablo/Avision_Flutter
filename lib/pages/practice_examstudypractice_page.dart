import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/viewmodels/practice_examstudypractice_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:provider/provider.dart';

import '../data_models/studentIdRequest.dart';
import '../storage/shared_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const PracticeExamstudypracticePage());
}
class PracticeExamstudypracticePage extends StatefulWidget {
  const PracticeExamstudypracticePage({super.key});

  @override
  State<PracticeExamstudypracticePage> createState() => _PracticeExamstudypracticePageState();
}

class _PracticeExamstudypracticePageState extends State<PracticeExamstudypracticePage> {
  late PracticeExamstudypracticeViewmodel practiceExamstudypracticeViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    practiceExamstudypracticeViewmodel = Provider.of<PracticeExamstudypracticeViewmodel>(context, listen: false);
  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var userId=(await MySharedPreferences().getUserDetail())?.userId;
    practiceExamstudypracticeViewmodel.fetchSubjects(context, StudentIdRequest(studentId: userId!));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PracticeExamstudypracticeViewmodel>(
        builder: (BuildContext context, PracticeExamstudypracticeViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Practice",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Your Progress"),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(width: 1,color: Colors.green),
                                ),
                                child:const  Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Row(
                                    children: [
                                       Icon(Icons.share,color: Colors.green,size: 16,),
                                    Text("Share Result",style: TextStyle(color: Colors.green,fontSize: 12),)
                                  ],),
                                ),
                              )
                            ],
                          ),
                         SizedBox(height: 10,),
                         practiceExamstudypracticeViewmodel.dataSubjectlist!=null?
                         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                         children: [
                            Column(
                              children: [
                              const Text("Total Attempt",style: TextStyle(fontWeight: FontWeight.bold),),
                                SizedBox(height: MyConstants.sh*.15,
                                  width: MyConstants.sw*.35,
                                  child:  PieChart(
                                    legendOptions: LegendOptions(showLegends: false),
                                    chartValuesOptions: ChartValuesOptions(
                                      showChartValues: false, // Disables the values inside the chart
                                    ),
                                    dataMap: {
                                      "Attempted":double.parse(practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.totalQuestionAttempted!),
                                      "NotAttempted":double.parse(practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.totalQuestion!)-double.parse(practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.totalQuestionAttempted!),
                                    },
                                    chartType: ChartType.disc,
                                    baseChartColor: Colors.blue[100]!,
                                    colorList: [Colors.red,Colors.blue[100]!], // gradientList: gradientList,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.totalQuestionAttempted!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red,fontSize: 20),),
                                    SizedBox(width: 5,),
                                    Text("out of ${practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.totalQuestion}")
                                  ],
                                )
                            ],),
                           Column(
                             children: [
                               const Text("Your Accuracy  ",style: TextStyle(fontWeight: FontWeight.bold),),
                               SizedBox(height: MyConstants.sh*.15,
                                 width: MyConstants.sw*.35,
                                 child:  PieChart(
                                   legendOptions: LegendOptions(showLegends: false),
                                   chartValuesOptions: ChartValuesOptions(
                                     showChartValues: false, // Disables the values inside the chart
                                   ),
                                   dataMap: {
                                     "percentage":(practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.accuracy!).toDouble(),
                                     "total":100-(practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.accuracy!).toDouble(),
                                   },
                                   chartType: ChartType.disc,
                                   baseChartColor: Colors.blue[100]!,
                                   colorList: [Colors.green,Colors.blue[100]!],
                                   // gradientList: gradientList,
                                 ),
                               ),
                               Row(
                                 children: [
                                   Text(practiceExamstudypracticeViewmodel.dataSubjectlist!.result!.questionAnalysis!.accuracy.toString()+"%",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 20),),
                                   SizedBox(width: 5,),
                                   Text("Accuracy")
                                 ],
                               )
                             ],)
                         ],):const SizedBox.shrink(),
                         SizedBox(height: 10,),

                         Row(
                           mainAxisAlignment: MainAxisAlignment.start,
                           children: [  
                             Icon(Icons.circle_rounded,color: Colors.blue,size: 15,),
                             SizedBox(width: 5,),
                             Text("Exam Topic",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                         ],),
                         practiceExamstudypracticeViewmodel.dataSubjectlist!=null
                             ?ListView.builder(
                             shrinkWrap: true,
                             physics: const ScrollPhysics(),
                             itemCount: practiceExamstudypracticeViewmodel
                                 .dataSubjectlist!.result!.subjectCount!.length,
                             itemBuilder: (context, index) {
                               var item=practiceExamstudypracticeViewmodel
                                   .dataSubjectlist!.result!.subjectCount![index];
                               return MySubjectsExamstudypractice(
                                   subject:item,onClick: (){},);
                             }):const SizedBox.shrink(),
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: practiceExamstudypracticeViewmodel.isLoading,
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
