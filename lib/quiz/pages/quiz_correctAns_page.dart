import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/my_custom_widgets.dart';
import '../../data_models/multiApiLiveCourseResponse.dart';
import '../../storage/shared_preferences.dart';
import '../../utils/colors.dart';
import '../../utils/constants.dart';
import '../../viewmodels/quiz_viewmodel.dart';
import '../datamodels/questionResponse.dart';
import '../datamodels/studentIdQuizIdRequest.dart';


void main(){
  runApp(const QuizCorrectAnsPage(data: []));
}
class QuizCorrectAnsPage extends StatefulWidget {
  final List<dynamic> data;
  const QuizCorrectAnsPage({super.key,required this.data});

  @override
  State<QuizCorrectAnsPage> createState() => _QuizCorrectAnsPageState();
}

class _QuizCorrectAnsPageState extends State<QuizCorrectAnsPage> {
  late MyEnumConstants section;
  late String quidId;
  late QuizViewmodel quizViewmodel;
  late List<QuestionDtl>? offlineQuesAns;

  final CarouselSliderController _carouselSliderController = CarouselSliderController();

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();

    quizViewmodel = Provider.of<QuizViewmodel>(context, listen: false);
    section=widget.data[0];
    quidId=widget.data[1];
    offlineQuesAns=widget.data[2];
  }

  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    String studentId=(await MySharedPreferences().getUserDetail())!.userId!;
    quizViewmodel.fetchResultWithAns(context,section,
        StudentIdQuizIdRequest(quizId: quidId, studentId:studentId )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<QuizViewmodel>(
        builder: (BuildContext context, QuizViewmodel value, Widget? child){
          return Scaffold(
            appBar: AppBar(
              backgroundColor: MyColors.blue,
              title: const Text("Correct Answers",style: TextStyle(color: MyColors.white,fontSize: 20),),

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
                         offlineQuesAns!=null?dataToUi(offlineQuesAns!)
                             :quizViewmodel.dataResultWithGivenAns!=null && quizViewmodel.dataResultWithGivenAns?.statusCode==200
                              ?dataToUi(quizViewmodel.dataResultWithGivenAns!.questionList!) :const SizedBox.shrink()
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
          );
        }
    );
  }
  Widget dataToUi(List<QuestionDtl> questions){
    return  CarouselSlider(
      carouselController: _carouselSliderController, // Attach the controller
      items: questions.asMap().entries.map((entry) {
        var index = entry.key;
        var question = entry.value;
        return QuizQuestion(usage:MyEnumConstants.CORRECT_ANS_VIEW,questionDtl: question, index: index, onAnsClick: (int index,QuestionDtl question){});
      }).toList(),
      options: CarouselOptions(
        height: MyConstants.sh*.83,
        enlargeCenterPage: true,
        // autoPlay: true,
        aspectRatio: 16/9,
        viewportFraction: 1,
        onPageChanged: (index, reason) {
          // setState(() {
          //   _currentIndex = index;
          // });
        },
      ),

    );
  }
}
