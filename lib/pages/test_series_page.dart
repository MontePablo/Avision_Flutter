import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/examListTestSeriesRequest.dart';
import 'package:avision/utils/constants.dart';
import 'package:avision/viewmodels/testseries_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../storage/shared_preferences.dart';
import '../utils/colors.dart';

class TestSeriesPage extends StatefulWidget {
  const TestSeriesPage({super.key});

  @override
  State<TestSeriesPage> createState() => _TestSeriesPageState();
}

class _TestSeriesPageState extends State<TestSeriesPage> {
  late TestSeriesViewModel testSeriesViewModel;
  bool isExpanded=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    testSeriesViewModel = Provider.of<TestSeriesViewModel>(context, listen: false);

  }
  @override
  Future<void> didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    MySharedPreferences().getCourseDetail().then((value) {
      testSeriesViewModel.fetchExamList(
        context,
        ExamListTestSeriesRequest(courseId: value?.coursesId ?? ""),
      );
    });

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Consumer<TestSeriesViewModel>(
        builder: (BuildContext context, TestSeriesViewModel value, Widget? child) {
          return Stack(
            children: [


              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: MyConstants.sh*.1,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(
                                "Exam-wise Test Series",
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text("Try Free mock Test Inside",style: TextStyle(fontSize: 12),)
                            ],
                          ),
                          TextButton(
                              onPressed: () {
                                isExpanded==true?isExpanded=false:isExpanded=true;
                                reloadUi();
                              },
                              child: const Text(
                                "View All",
                                style: TextStyle(
                                    color: MyColors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15),
                              )),
                        ],
                      ),

                    testSeriesViewModel.dataExamListTestSeries!=null?
                           GridView.builder(
                              shrinkWrap: true,
                              itemCount:isExpanded!=true?4:testSeriesViewModel.dataExamListTestSeries!.testSeries!.length ,
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 1.2,
                              ),
                              physics: const ScrollPhysics(),
                              itemBuilder: (context,index){
                                return MyTestSeriesExam(testSeries: testSeriesViewModel!.dataExamListTestSeries!.testSeries!.elementAt(index),);
                              },
                            )
                            :const SizedBox.shrink(),
                      SizedBox(height: MyConstants.sh*.02,),

                      InkWell(
                        onTap: (){

                        },
                        child: Container(
                          width: MyConstants.sw,
                          height: MyConstants.sh*.05,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Colors.orange,
                                Colors.red,
                              ],
                            ),
                          ),
                          child:const Center(child: const Text("Unlock All Tests",style: TextStyle(color: MyColors.white,),)),
                        ),
                      ),
                      SizedBox(height: MyConstants.sh*.02,),
                      const Text("Attempt Your First Free Mock Test",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15)),
                      const Row(
                        children: [
                          Text("Get 100 Coins"),
                          Icon(Icons.monetization_on,color: CupertinoColors.systemYellow,)
                        ],
                      ),

                      SizedBox(height: MyConstants.sh*.02,),
                       Text("FAQ's",style: TextStyle(fontWeight: FontWeight.bold,fontSize:MyConstants.sw*.05 ,),),
                      SizedBox(height: MyConstants.sh*.02,),
                      Container(
                        width: MyConstants.sw,
                        height: MyConstants.sh*.13,
                        decoration: BoxDecoration(
                          color: MyColors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: MyColors.grey.withOpacity(0.5),
                              blurStyle: BlurStyle.normal,
                              spreadRadius: 1,
                              blurRadius: 4,
                              offset: const Offset(2, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Padding(
                          padding:  const EdgeInsets.symmetric(horizontal: 10.0),
                          child:  Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                               Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Fetching issues?"),
                                  Icon(Icons.email,color: Colors.red,size: MyConstants.sw*.1,)
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("Please Email/Whatsapp us on "),
                                  SizedBox(
                                      height: MyConstants.sh*.06,
                                      width: MyConstants.sw*.1,
                                      child: Image.asset("assets/images/whatsapp.png")),
                                ],
                              )
                            ],
                          ),
                        )
                      ),
                    ],
                  ),
                )
              ),


              Center(
                child: Visibility(
                  visible: testSeriesViewModel.isLoading,
                  child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                ),
              ),
            ],
          );
        }
    );
  }
  void reloadUi(){
    setState(() {
    });
  }
}