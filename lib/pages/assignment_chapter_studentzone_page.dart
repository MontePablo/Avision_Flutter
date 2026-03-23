import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/assigmentSubjectStudentzoneResponse.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneRequest.dart';
import 'package:avision/viewmodels/assignment_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../utils/colors.dart';
import '../utils/constants.dart';

void main(){
  runApp(const AssignmentChapterStudentzonePage(data:null));
}
class AssignmentChapterStudentzonePage extends StatefulWidget {
  final AssignmentSubject? data;
  const AssignmentChapterStudentzonePage({super.key, required this.data});

  @override
  State<AssignmentChapterStudentzonePage> createState() => _AssignmentChapterStudentzonePageState();
}

class _AssignmentChapterStudentzonePageState extends State<AssignmentChapterStudentzonePage> {
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
    assignmentStudentzoneViewmodel.dataAssignmentChapter=null;
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    assignmentStudentzoneViewmodel.fetchChapterList(
      context,
      AssignmentChapterStudentzoneRequest(subjectId: widget.data!.typeId!)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<AssignmentStudentzoneViewmodel>(
        builder: (BuildContext context, AssignmentStudentzoneViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title:  Text(widget.data!.typeName??"",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                         assignmentStudentzoneViewmodel.dataAssignmentChapter!=null
                             ?
                         ListView.builder(
                             shrinkWrap: true,
                             physics: const ScrollPhysics(),
                             itemCount: assignmentStudentzoneViewmodel.dataAssignmentChapter!.files!.length,
                             itemBuilder: (context, index) {
                               return MyAssignmentChapterItem(
                                   chapter: assignmentStudentzoneViewmodel
                                       .dataAssignmentChapter!.files!
                                       .elementAt(index),
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
