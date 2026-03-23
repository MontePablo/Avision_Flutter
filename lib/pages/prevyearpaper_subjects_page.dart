import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/prevyearpaperSubjectsRequest.dart';
import 'package:avision/data_models/prevyearpaperSubjectsResponse.dart';
import 'package:avision/viewmodels/prevyearpaper_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import '../storage/shared_preferences.dart';
import '../utils/colors.dart';
import '../utils/constants.dart';
import '../utils/routes.dart';

void main(){
  runApp(const PrevyearpaperSubjectsPage());
}
class PrevyearpaperSubjectsPage extends StatefulWidget {
  const PrevyearpaperSubjectsPage({super.key});

  @override
  State<PrevyearpaperSubjectsPage> createState() => _RecordedVideosDrawerPageState();
}

class _RecordedVideosDrawerPageState extends State<PrevyearpaperSubjectsPage> {
  late PrevyearpaperStudentzoneViewmodel prevyearpaperStudentzoneViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    prevyearpaperStudentzoneViewmodel = Provider.of<PrevyearpaperStudentzoneViewmodel>(context, listen: false);
  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    String courseId=(await MySharedPreferences().getCourseDetail())!.coursesId!;
    String studentId=(await MySharedPreferences().getUserDetail())!.userId!;
    print("studentid: $studentId courseId: $courseId");
    prevyearpaperStudentzoneViewmodel.fetchSubjectList(
        context,PrevyearpaperSubjectsRequest(studentId: studentId, courseId: courseId)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PrevyearpaperStudentzoneViewmodel>(
        builder: (BuildContext context, PrevyearpaperStudentzoneViewmodel value, Widget? child){
          print("=="+ (prevyearpaperStudentzoneViewmodel.dataPrevyrpaperSubjects!=null).toString());
          print("object==" + prevyearpaperStudentzoneViewmodel.dataPrevyrpaperSubjects!.toJson().toString());
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Previous year papers",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                         prevyearpaperStudentzoneViewmodel.dataPrevyrpaperSubjects!=null
                         ? GridView.builder(
                           shrinkWrap: true,
                           itemCount:prevyearpaperStudentzoneViewmodel.dataPrevyrpaperSubjects!.previousYearTestList!.length ,
                           gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                             crossAxisCount: 2,
                             childAspectRatio: 1.6,
                             crossAxisSpacing: 10,
                             mainAxisSpacing: 10,
                           ),
                           physics:const ScrollPhysics(),
                           itemBuilder: (context, index) {
                             return MyPrevYrPaperSubjectItem(
                               subject: prevyearpaperStudentzoneViewmodel
                                   .dataPrevyrpaperSubjects!.previousYearTestList![index],
                               onClick: (){
                                 dialog( prevyearpaperStudentzoneViewmodel
                                     .dataPrevyrpaperSubjects!.previousYearTestList![index]);
                               },
                             );
                           },
                         ):const SizedBox.shrink(),
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: prevyearpaperStudentzoneViewmodel.isLoading,
                     child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                   ),
                 ),
               ],
             )
          );
        }
    );
  }

  void dialog(PrevYrSubject subject){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Colors.transparent, // Set background color to transparent
            contentPadding: EdgeInsets.zero,
            elevation: 0,
            content: SizedBox(
              height: MyConstants.sh * .7,
              width: MyConstants.sw,
              child: Stack(
                children: [
                  Text(subject.subCategoryName??"",style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.blue),),
                  SizedBox(height: MyConstants.sh*.05,),
                  subject.sectionList!=null
                      ?GridView.builder(
                    shrinkWrap: true,
                    itemCount:subject.sectionList!.length ,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      // childAspectRatio: 0.7,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    physics:const ScrollPhysics(),
                    itemBuilder: (context,index){
                      return MyButtonRound(color: MyColors.blue,textColor: Colors.white, fontSize: 15, cornerRadius: 10,
                          onClick: (){
                            Navigator.pushNamed(context, MyRoutes.prevyearpaperTestsStudentzonePage,
                                arguments: [
                                    subject.subCatId,
                                    subject.sectionList![index].sectionId
                                ]
                            );
                          },
                          title: subject.sectionList!.elementAt(index).sectionName!, paddingSides: 8,
                      );
                    },
                  ):const SizedBox.shrink(),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        child: const Icon(
                          Icons.cancel,
                          color: MyColors.blue,
                        ),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
