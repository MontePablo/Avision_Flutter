import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/examListExaminfoExamstudypracticeRequest.dart';
import 'package:avision/viewmodels/exam_examstudypractice_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../storage/shared_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const ExaminfoExamstudypracticePage());
}
class ExaminfoExamstudypracticePage extends StatefulWidget {
  const ExaminfoExamstudypracticePage({super.key});

  @override
  State<ExaminfoExamstudypracticePage> createState() => _ExaminfoExamstudypracticePageState();
}

class _ExaminfoExamstudypracticePageState extends State<ExaminfoExamstudypracticePage> {
  late ExamExamstudypracticeViewmodel examViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    examViewmodel = Provider.of<ExamExamstudypracticeViewmodel>(context, listen: false);
  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    var courceId=(await MySharedPreferences().getCourseDetail())?.coursesId;

    examViewmodel.fetchExamlist(context,ExamlistExaminfoExamstudypracticeRequest(courseId:courceId ));
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<ExamExamstudypracticeViewmodel>(
        builder: (BuildContext context, ExamExamstudypracticeViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Exams",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                          examViewmodel.dataExamlist!=null
                         ?
                          GridView.builder(
                            shrinkWrap: true,
                            itemCount:examViewmodel.dataExamlist!.examCategory!.length ,
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              childAspectRatio: 1.1,
                            ),
                            physics: const ScrollPhysics(),
                            itemBuilder: (context,index){
                              return MyExamlistExamstudypractice(exam: examViewmodel.dataExamlist!.examCategory![index]);
                            },
                          )
                              :
                              const SizedBox.shrink()

                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: examViewmodel.isLoading,
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
