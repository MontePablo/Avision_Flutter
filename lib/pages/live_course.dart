import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/multiApiLiveCourseResponse.dart';
import 'package:avision/utils/colors.dart';
import 'package:avision/utils/constants.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../viewmodels/livecourse_viewmodel.dart';

class LiveCourse extends StatefulWidget {
  const LiveCourse({super.key});

  @override
  State<LiveCourse> createState() => _LiveCourseState();
}

class _LiveCourseState extends State<LiveCourse> {
  late LiveCourseViewModel liveCourseViewModel;
  void initState() {
    super.initState();
    liveCourseViewModel = Provider.of<LiveCourseViewModel>(context, listen: false);
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    liveCourseViewModel.fetchMultiApiLiveCourse(context);

  }
  @override
  Widget build(BuildContext context) {
    int activeSliderIndex=0;
    return Consumer<LiveCourseViewModel>(
      builder: (BuildContext context, LiveCourseViewModel value, Widget? child) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                color: MyColors.backround,
                child:  Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Popular Courses",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      child: liveCourseViewModel.dataMultiApiLiveCourse != null
                          ? Stack(
                          children:[
                            CarouselSlider.builder(
                              itemCount: liveCourseViewModel.dataMultiApiLiveCourse!.result!.banner!.length,
                              itemBuilder: (BuildContext context, int index, int realIndex) {
                                return MySliderImage(
                                  image: liveCourseViewModel.dataMultiApiLiveCourse!.result!.banner!.elementAt(index).bannerImage!,
                                );
                              },
                              options: CarouselOptions(
                                  autoPlay: true,
                                  onPageChanged: (index,reason){
                                    activeSliderIndex=index;
                                    setState(() {});
                                  }
                              ),
                            ),
                            Positioned(
                                bottom: 15,left: MyConstants.sw*.5,right: MyConstants.sw*.5,
                                child: MyIndicator(activeIndex: activeSliderIndex, count: liveCourseViewModel.dataMultiApiLiveCourse!.result!.banner!.length)
                            )
                          ]
                      ): const SizedBox.shrink(),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "All Courses",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    // MyCourse(course: Course()),
                    liveCourseViewModel.dataMultiApiLiveCourse!=null
                        ?GridView.builder(
                      shrinkWrap: true,
                      itemCount:liveCourseViewModel!.dataMultiApiLiveCourse!.result!.courseApi!.length ,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.7,
                        // crossAxisSpacing: 10,
                        // mainAxisSpacing: 10,
                      ),
                      physics:const ScrollPhysics(),
                      itemBuilder: (context,index){
                        return MyCourse(course: liveCourseViewModel.dataMultiApiLiveCourse!.result!.courseApi!.elementAt(index));
                      },
                    ):const SizedBox.shrink(),
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(
                        "Our Teachers",
                        style: TextStyle(
                            color: Colors.black87,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: MyConstants.sh*.35,
                      child: liveCourseViewModel.dataMultiApiLiveCourse!=null
                          ?GridView.builder(
                        // shrinkWrap: true,
                        itemCount:liveCourseViewModel!.dataMultiApiLiveCourse!.result!.teachersDetails!.length ,
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.5,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: const ScrollPhysics(),
                        itemBuilder: (context,index){
                          return MyTeacher(teachersDetail: liveCourseViewModel.dataMultiApiLiveCourse!.result!.teachersDetails!.elementAt(index));
                        },
                      ):const SizedBox.shrink(),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Visibility(
                visible: liveCourseViewModel.isLoading,
                child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
              ),
            ),
          ]
        );
      },
    );
  }
}
