import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:avision/viewmodels/study_examstudypractice_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

void main(){
  runApp(const StudyExamstudypracticePage());
}
class StudyExamstudypracticePage extends StatefulWidget {
  const StudyExamstudypracticePage({super.key});

  @override
  State<StudyExamstudypracticePage> createState() => _StudyExamstudypracticePageState();
}

class _StudyExamstudypracticePageState extends State<StudyExamstudypracticePage> {
  late StudyExamstudypracticeViewmodel studyExamstudypracticeViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    studyExamstudypracticeViewmodel = Provider.of<StudyExamstudypracticeViewmodel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // recordedVideosDrawerViewModel.fetchRecordedVideos(context);
    studyExamstudypracticeViewmodel.fetchBanner(context);
    studyExamstudypracticeViewmodel.fetchSubjectlist(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<StudyExamstudypracticeViewmodel>(
        builder: (BuildContext context, StudyExamstudypracticeViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Study",style: TextStyle(color: MyColors.white,fontSize: 20),),

              iconTheme: const IconThemeData(
                  color: Colors.white), // Change the color here

            ),
             body:Stack(
               children: [
                 SingleChildScrollView(
                   child: Column(
                     children: [
                       studyExamstudypracticeViewmodel.dataBanner!=null?
                       SizedBox(
                         height: MyConstants.sh*.18,
                         child: Image.network( studyExamstudypracticeViewmodel.dataBanner!.banner!.bannerImage!),
                       ): const SizedBox.shrink(),
                       studyExamstudypracticeViewmodel.dataSubjectlist!=null
                           ? ListView.builder(
                         shrinkWrap: true,
                         itemCount:studyExamstudypracticeViewmodel.dataSubjectlist?.subjectList?.length ,
                         physics: const ScrollPhysics(),
                         itemBuilder: (context,index){
                           return MySubjectStudyExamstudypractice(subject: studyExamstudypracticeViewmodel.dataSubjectlist!.subjectList![index], onClick: (){
                             Navigator.pushNamed(context, MyRoutes.quizAppbarQuizlistPage,arguments: studyExamstudypracticeViewmodel.dataSubjectlist!.subjectList![index]);
                           });
                         },
                       ):const SizedBox.shrink()
                     ],
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: studyExamstudypracticeViewmodel.isLoading,
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
