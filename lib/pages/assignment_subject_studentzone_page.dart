import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/viewmodels/assignment_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const AssignmentSubjectStudentzonePage());
}
class AssignmentSubjectStudentzonePage extends StatefulWidget {
  const AssignmentSubjectStudentzonePage({super.key});

  @override
  State<AssignmentSubjectStudentzonePage> createState() => _AssignmentStudentzonePageState();
}

class _AssignmentStudentzonePageState extends State<AssignmentSubjectStudentzonePage> {
  late AssignmentStudentzoneViewmodel assignmentStudentzoneViewmodel;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    assignmentStudentzoneViewmodel = Provider.of<AssignmentStudentzoneViewmodel>(context, listen: false);
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    assignmentStudentzoneViewmodel.dataAssignmentSubject=null;
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    assignmentStudentzoneViewmodel.fetchSubjectList(context);
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentStudentzoneViewmodel>(
        builder: (BuildContext context, AssignmentStudentzoneViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Assignments",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                         assignmentStudentzoneViewmodel.dataAssignmentSubject!=null
                             ?
                         ListView.builder(
                             shrinkWrap: true,
                             physics: const ScrollPhysics(),
                             itemCount: assignmentStudentzoneViewmodel.dataAssignmentSubject!.subjectList!.length,
                             itemBuilder: (context, index) {
                               return MyAssignmentSubjectItem(
                                 subject: assignmentStudentzoneViewmodel
                                     .dataAssignmentSubject!.subjectList!
                                     .elementAt(index),
                                 index: index,
                               );
                             })
                             :
                             const SizedBox.shrink()
                       ],
                     ),
                   ),
                 ),

                 Center(
                   child: Visibility(
                     visible: assignmentStudentzoneViewmodel.isLoading,
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
