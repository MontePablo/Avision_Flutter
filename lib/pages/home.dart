import 'dart:async';

import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/multiApiTwoHomeRequest.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/data_models/quiz.dart';
import 'package:avision/database/quizDatabase.dart';
import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/utils/colors.dart';
import 'package:avision/utils/constants.dart';
import 'package:avision/viewmodels/home_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:upgrader/upgrader.dart';
import 'package:url_launcher/url_launcher.dart';

import '../quiz/datamodels/questionResponse.dart';
import '../utils/routes.dart';

import 'package:in_app_update/in_app_update.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;


class Home extends StatefulWidget  {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late HomeViewModel homeViewModel;
  int activeSliderIndex=0;

  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    QuizDatabase().openBox(MyEnumConstants.QUIZ_SECTION_DAILYDOSE.toString());
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    //   checkForUpdate();
    // });
  }
  @override
  Future<void> didChangeDependencies() async {
    super.didChangeDependencies();
    homeViewModel.fetchMultiApiOne(context);
    homeViewModel.fetchJobAlerts(context);
    homeViewModel.fetchDailyAssignmentBanner(context);
    homeViewModel.fetchPopularCourse(context);
    homeViewModel.fetchPopupBanner(context);
    homeViewModel.fetchCurrentAffairs(context);

    var userId=(await MySharedPreferences().getUserDetail())?.userId;
    homeViewModel.fetchMultiApiTwo(context,MultiApiTwoHomeRequest(studentId: userId ?? ""));

  }
  void showPopupBanner() {
    if (homeViewModel.dataPopupBanner != null) {
      Utility.showAlertDialog(context, MyPopupBanner(context: context, banner: homeViewModel.dataPopupBanner!.banner));
    }
  }
  @override
  Widget build(BuildContext context) {

    return UpgradeAlert(
      child: Consumer<HomeViewModel>(
        builder: (BuildContext context, HomeViewModel value, Widget? child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (homeViewModel.dataPopupBanner != null && homeViewModel.dataPopupBanner?.statusCode=="200" && MyConstants.homeBannerCount==0) {
              showPopupBanner();
              MyConstants.homeBannerCount++;
            }
          });

          return Stack(
            children: [
              SingleChildScrollView(
                child: Container(
                  color: MyColors.backround,
                  child: Column(
                    children: [
                      Container(
                        color: MyColors.blue,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyAppbarItem(
                                  iconPath: "assets/images/logo_quiz.png",
                                  iconName: "Quiz",
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.quizAppbarSubjectlistPage);
                                  }),
                              MyAppbarItem(
                                  iconPath: "assets/images/logo_gk_ca.png",
                                  iconName: "GK/CA",
                                  onPressed: () {Navigator.pushNamed(context, MyRoutes.gkcaRoute);}),
                              MyAppbarItem(
                                  iconPath: "assets/images/logo_videos.png",
                                  iconName: "Videos",
                                  onPressed: () {
                                    Utility.flushbarPositiveMsg("msg", context);
                                    Navigator.pushNamed(context, MyRoutes.videosAppBarRoute);
                                  }),
                              MyAppbarItem(
                                  iconPath: "assets/images/logo_article.PNG",
                                  iconName: "News & Articles",
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.newsAppbar);
                                  }),
                              // MyAppbarItem(
                              //     iconPath: "assets/images/icon_feed.PNG",
                              //     iconName: "Doubts",
                              //     onPressed: () {}),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        color: MyColors.white,
                        child: homeViewModel.dataMultiApiOneHome != null
                            ? Stack(
                            children:[
                              CarouselSlider.builder(
                                itemCount: homeViewModel.dataMultiApiOneHome!.newsAnalysis!.bannerFetch!.length,
                                itemBuilder: (BuildContext context, int index, int realIndex) {
                                  return MySliderImage(
                                    image: homeViewModel.dataMultiApiOneHome!.newsAnalysis!.bannerFetch!.elementAt(index).bannerImage!,
                                  );
                                },
                                options: CarouselOptions(
                                    aspectRatio: 16/8,
                                    viewportFraction: 0.95,
                                    autoPlay: true,
                                    onPageChanged: (index,reason){
                                      setState(() {
                                        activeSliderIndex=index;
                                      });
                                      print("Slider changed to index: $index");

                                    }
                                ),
                              ),
                              Positioned(
                                  bottom: 15,left: MyConstants.sw*.4,right: MyConstants.sw*.5,
                                  child: MyIndicator(activeIndex: activeSliderIndex, count: homeViewModel.dataMultiApiOneHome!.newsAnalysis!.bannerFetch!.length,)
                              )
                            ]
                        ): const SizedBox.shrink(),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ExamStudyPracticeItem(
                            iconPath: "assets/images/logo_info_exam.png",
                            title: "Exam Info",
                            onPressed: () {
                              Navigator.pushNamed(context, MyRoutes.examInfoPage);
                            },
                          ),
                          ExamStudyPracticeItem(
                            iconPath: "assets/images/logo_study.png",
                            title: "Study",
                            onPressed: () {
                              Navigator.pushNamed(context, MyRoutes.studyPage);
                            },
                          ),
                          ExamStudyPracticeItem(
                            iconPath: "assets/images/logo_practice.png",
                            title: "Practice",
                            onPressed: () {
                              Navigator.pushNamed(context, MyRoutes.practicePage);
                            },
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: MyConstants.sh*.3,
                        // width: 200,
                        color: MyColors.white,
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.arrow_up_right,
                                    color: MyColors.blue,
                                    size: MyConstants.sw * .06,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "Trending Tests",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            // homeViewModel.dataMultiApiOneHome != null
                            // ?
                            Container(
                              height: MyConstants.sh*.18,
                              child: homeViewModel.dataMultiApiOneHome!=null
                                  ?ListView.builder(
                                  itemCount: homeViewModel
                                      .dataMultiApiOneHome!.newsAnalysis!.trendingTest!.length,
                                  // itemCount: 5,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) {
                                    return MyTrendingTestItem(
                                        trendingTest: homeViewModel
                                            .dataMultiApiOneHome!.newsAnalysis!.trendingTest!
                                            .elementAt(index));
                                    // return const Text("ABCDEFGH",style: TextStyle(fontSize: 10),);
                                  }):const SizedBox.shrink(),
                            ),
                            // :
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: MyColors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.exclamationmark_octagon_fill,
                                    color: MyColors.blue,
                                    size: MyConstants.sw * .06,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "Current Affairs",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8, left: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  homeViewModel.dataCurrentAffairs!=null
                                      ? Text(homeViewModel.dataCurrentAffairs!.newsAnalysis!.currentAffairsOne!.first.postTitle!,
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold))
                                      : const SizedBox.shrink(),
                                  SizedBox(
                                      height: MyConstants.sh * .07,
                                      child:
                                      homeViewModel.dataMultiApiOneHome!=null
                                          ?Html(data: homeViewModel.dataCurrentAffairs!.newsAnalysis!.currentAffairsOne!.first.postContent!)
                                          :const SizedBox.shrink())
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                                child: InkWell(
                                  onTap: (){
                                    Navigator.pushNamed(context, MyRoutes.webviewPage,
                                        arguments: homeViewModel.dataCurrentAffairs!.newsAnalysis!.currentAffairsOne!.first.metaValue);
                                    },
                                  child: Container(
                                    height: MyConstants.sh * .04,
                                    width: MyConstants.sw * .5,
                                    decoration: const BoxDecoration(
                                      color: MyColors.blue,
                                      borderRadius:
                                      BorderRadiusDirectional.all(Radius.circular(10)),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Latest Current Affairs",
                                        style: TextStyle(
                                            color: MyColors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15),
                                      ),
                                    ),
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, MyRoutes.buyPlanPage);
                          },
                        child: Container(
                          color: MyColors.white,
                          height: MyConstants.sh * .20,
                          width: MyConstants.sw,
                          child:  Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: homeViewModel.dataMultiApiOneHome!=null
                                ? Image.network(fit: BoxFit.fill,homeViewModel.dataMultiApiOneHome!.newsAnalysis!.planBanner!.first.bannerImage!,)
                                :
                            const Expanded(child: Icon(Icons.broken_image_sharp,size: 150,color: MyColors.grey,)),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: MyColors.white,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.alarm_fill,
                                          color: MyColors.blue,
                                          size: MyConstants.sw * .06,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 14),
                                          child: Text(
                                            "Job Alerts",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "View All",
                                          style: TextStyle(
                                              color: MyColors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  ],
                                )),

                            homeViewModel.dataJobAlerts!=null
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                MyJobAlertsItem(jobAlert: homeViewModel.dataJobAlerts!.jobAlert!.elementAt(0)),
                                MyJobAlertsItem(jobAlert: homeViewModel.dataJobAlerts!.jobAlert!.elementAt(1)),
                                MyJobAlertsItem(jobAlert: homeViewModel.dataJobAlerts!.jobAlert!.elementAt(2)),
                              ],
                            )
                                :
                            Center(child: Text("No data available",style: TextStyle(fontSize: 20),),),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: MyColors.white,
                        height: MyConstants.sh * .17,
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(
                                context, MyRoutes.dailyAssignmentPage);
                          },
                          child: homeViewModel.dataDailyAssignmentBanner!=null
                              ? Image.network(homeViewModel.dataDailyAssignmentBanner!.banner!.bannerImage!,scale: 1,)
                              : Center(),
                        )


                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: MyColors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    CupertinoIcons.calendar,
                                    color: MyColors.blue,
                                    size: MyConstants.sw * .06,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "Daily Dose : Practice",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.only(left: 14),
                                      child: Container(
                                        height: MyConstants.sh * .03,
                                        width: MyConstants.sw * .09,
                                        decoration: const BoxDecoration(
                                            color: Colors.cyanAccent,
                                            borderRadius: BorderRadiusDirectional.all(
                                                Radius.circular(15))),
                                        child: const Center(
                                            child: Text(
                                              "Free",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10),
                                            )),
                                      )),
                                  SizedBox(width: MyConstants.sw*.01,),
                                  if (homeViewModel.dataMultiApiTwoHome!=null)
                                    Expanded(child: Text(Utility.formatDateRange(homeViewModel.dataMultiApiTwoHome!.newsAnalysis!.randamFetchQuiz!.fromDates.toString(), homeViewModel.dataMultiApiTwoHome!.newsAnalysis!.randamFetchQuiz!.toDates.toString()), style: const TextStyle(fontSize: 11), )),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: MyConstants.sh * .25,
                              child: homeViewModel.dataMultiApiTwoHome != null
                                  ? ListView.builder(
                                itemCount: homeViewModel.dataMultiApiTwoHome!.newsAnalysis!.randamFetchQuiz!.quizArr!.length,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  var quiz = Utility.dailydoseQuizToQuizDetailConvert(homeViewModel.dataMultiApiTwoHome!.newsAnalysis!.randamFetchQuiz!.quizArr!.elementAt(index));

                                  return FutureBuilder(
                                    future: QuizDatabase().getQuizDtlById(quiz.quizId!),
                                    builder: (context, snapshot) {
                                        MyEnumConstants type;

                                        if (quiz.status == 2) {
                                          type = MyEnumConstants.RESULT_QUIZ;
                                        } else if (snapshot.hasData) {
                                          type = MyEnumConstants.RESUME_QUIZ;
                                        } else {
                                          type = MyEnumConstants.START_QUIZ;
                                        }

                                        return MyQuizListSquare(
                                          quiz: quiz,
                                          onClick: () async {
                                            if (quiz.status == 2) {
                                              Navigator.pushNamed(
                                                context,
                                                MyRoutes.quizResultPage,
                                                arguments: [MyEnumConstants.QUIZ_SECTION_DAILYDOSE, quiz.quizId],
                                              );
                                            } else if (snapshot.hasData) {
                                              Navigator.pushNamed(
                                                context,
                                                MyRoutes.quizTestPage,
                                                arguments: [MyEnumConstants.QUIZ_SECTION_DAILYDOSE, quiz, snapshot.data],
                                              );
                                            } else {
                                              MyQuizIntro(
                                                context: context,
                                                quizDetail: quiz,
                                                onClick: () async {
                                                  Navigator.pushNamed(
                                                    context,
                                                    MyRoutes.quizTestPage,
                                                    arguments: [MyEnumConstants.QUIZ_SECTION_DAILYDOSE, quiz],
                                                  );
                                                },
                                              );
                                            }
                                          },
                                          type: type,
                                        );
                                    },
                                  );
                                },
                              )
                                  : const SizedBox.shrink(),
                            )

                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: MyColors.white,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.cast_for_education,
                                    color: MyColors.blue,
                                    size: MyConstants.sw * .06,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "Popular Courses",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                                height: MyConstants.sh*.27,
                                child: homeViewModel.dataPopularCourse!=null
                                    ?ListView.builder(
                                    itemCount: homeViewModel.dataPopularCourse!.popularCourse!.length,
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return MyPopularCourseItem(
                                          popularCourse: homeViewModel.dataPopularCourse!.popularCourse!
                                              .elementAt(index));
                                    }):const SizedBox.shrink()

                            )
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/images/background.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.man,
                                    color: MyColors.blue,
                                    size: MyConstants.sw * .06,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(left: 14),
                                    child: Text(
                                      "Student Zone",
                                      style: TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                MyStudentZoneItem(
                                  title: "Monthly Booster",
                                  icon: CupertinoIcons.bolt_fill,
                                  color: Colors.orangeAccent,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.boosterMagazineGaPage,arguments: MyEnumConstants.MONTHLY_BOOSTER_PAGE);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                MyStudentZoneItem(
                                  title: "News & Articles",
                                  icon: Icons.list_alt,
                                  color: Colors.purple,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.newsAppbar);
                                  },
                                ),

                                MyStudentZoneItem(
                                  title: "Previous Year Paper",
                                  icon: CupertinoIcons.square_stack_3d_up,
                                  color: Colors.greenAccent,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.prevyearpaperSubjectsStudentzonePage);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                MyStudentZoneItem(
                                  title: "Daily Vocab",
                                  icon: Icons.newspaper,
                                  color: Colors.deepOrange,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.dailyVocabStudentzonePage);
                                  },
                                ),
                                // MyStudentZoneItem(
                                //   title: "Capcule",
                                //   icon: Icons.local_fire_department_rounded,
                                //   color: Colors.black26,
                                //   onPressed: () {},
                                // ),
                                MyStudentZoneItem(
                                  title: "Magazine",
                                  icon: Icons.article,
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.boosterMagazineGaPage,arguments: MyEnumConstants.MONTHLY_MAGAZINE_PAGE);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // MyStudentZoneItem(
                                //   title: "Class Schedule",
                                //   icon: Icons.schedule,
                                //   color: Colors.pinkAccent,
                                //   onPressed: () {},
                                // ),
                                MyStudentZoneItem(
                                  title: "Assignment",
                                  icon: Icons.article_outlined,
                                  color: Colors.green,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.assignmentSubjectStudentzonePage);
                                  },
                                ),
                                MyStudentZoneItem(
                                  title: "Monthly GA Booklet",
                                  icon: Icons.menu_book_sharp,
                                  color: Colors.purpleAccent,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.boosterMagazineGaPage,arguments: MyEnumConstants.MONTHLY_GA_PAGE);
                                  },
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                    MyStudentZoneItem(
                                  title: "Daily Current Affairs",
                                  icon: Icons.newspaper_outlined,
                                  color: Colors.grey.shade800,
                                  onPressed: () {
                                    Navigator.pushNamed(context, MyRoutes.dcaStudentzonePage);
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: MyColors.white,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          CupertinoIcons.video_camera_solid,
                                          color: MyColors.blue,
                                          size: MyConstants.sw * .06,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 14),
                                          child: Text(
                                            "Videos",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pushNamed(context, MyRoutes.videosAppBarRoute);
                                        },
                                        child: const Text(
                                          "View All",
                                          style: TextStyle(
                                              color: MyColors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  ],
                                )),
                            SizedBox(
                              height: 200,
                              child: homeViewModel.dataMultiApiTwoHome!=null
                                  ?
                                  // Text(homeViewModel.dataMultiApiTwoHome!.newsAnalysis!.youtubeVideo![0].toJson().toString())
                              ListView.builder(
                                  itemCount: homeViewModel.dataMultiApiTwoHome?.newsAnalysis?.youtubeVideo?.length,
                                  scrollDirection: Axis.horizontal,
                                  // shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    return MyVideoTileShort(
                                        video: homeViewModel
                                            .dataMultiApiTwoHome!.newsAnalysis!.youtubeVideo!.elementAt(index));
                                  })
                                  :Center(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        color: MyColors.white,
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.dynamic_feed_sharp,
                                          color: MyColors.blue,
                                          size: MyConstants.sw * .06,
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(left: 14),
                                          child: Text(
                                            "All Posts",
                                            style: TextStyle(
                                                color: Colors.black87,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                    TextButton(
                                        onPressed: () {},
                                        child: const Text(
                                          "View All",
                                          style: TextStyle(
                                              color: MyColors.blue,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        )),
                                  ],
                                )),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 5,
                                    blurRadius: 7,
                                    offset:
                                    const Offset(0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: homeViewModel.dataMultiApiTwoHome!=null
                                  ?ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: homeViewModel.dataMultiApiTwoHome!.newsAnalysis!.dailyPost!.length,
                                  scrollDirection: Axis.vertical,
                                  itemBuilder: (context, index) {
                                    return MyPostItem(
                                        post: homeViewModel
                                            .dataMultiApiTwoHome!.newsAnalysis!.dailyPost!.elementAt(index));
                                  }):Center(),
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Visibility(
                  visible: homeViewModel.isLoading,
                  child:  SpinKitFadingCircle(color: MyColors.blue,size: MyConstants.sh*.1,),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  //
  // Future<void> checkForUpdate() async {
  //   print("Update check started");
  //   AppUpdateInfo updateInfo;
  //   try {
  //     updateInfo = await InAppUpdate.checkForUpdate();
  //     if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
  //       // Start immediate or flexible update
  //       await InAppUpdate.performImmediateUpdate();
  //     }
  //   } catch (e) {
  //     print("Error checking for update: $e");
  //   }
  //   checkForIosUpdate(context);
  // }
  //
  // Future<void> checkForIosUpdate(BuildContext context) async {
  //   // Check if the platform is iOS
  //   if (Platform.isIOS) {
  //     PackageInfo packageInfo = await PackageInfo.fromPlatform();
  //     String currentVersion = packageInfo.version;
  //
  //     // Fetch the latest version from iTunes API
  //     final response = await http.get(
  //       Uri.parse('https://itunes.apple.com/lookup?bundleId=com.visiabletech.avision'),
  //     );
  //
  //     if (response.statusCode == 200) {
  //       final json = jsonDecode(response.body);
  //       String appStoreVersion = json['results'][0]['version'];
  //
  //       if (currentVersion != appStoreVersion) {
  //         // Show dialog to prompt user to update
  //         _showUpdateDialog(context);
  //       }
  //     } else {
  //       print('Failed to fetch update info');
  //     }
  //   } else {
  //     print('Platform is not iOS; skipping update check.');
  //   }
  // }
  //
  // void _showUpdateDialog(BuildContext context) {
  //   Utility.showCustomDialog(context, AlertDialog(
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
  //     title: const Row(
  //       children: [
  //         Icon(Icons.system_update, color: Colors.blueAccent, size: 28),
  //         SizedBox(width: 8),
  //         Text(
  //           "Update Available",
  //           style: TextStyle(
  //             fontSize: 20,
  //             fontWeight: FontWeight.bold,
  //             color: Colors.black87,
  //           ),
  //         ),
  //       ],
  //     ),
  //     content: const Text(
  //       "A new version of the app is available. Update now to enjoy the latest features and improvements.",
  //       style: TextStyle(fontSize: 16, color: Colors.black54),
  //     ),
  //     actions: [
  //       ElevatedButton(
  //         style: ElevatedButton.styleFrom(
  //           backgroundColor: Colors.blueAccent,
  //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  //         ),
  //         onPressed: () async {
  //           const appStoreUrl = 'https://apps.apple.com/app/idcom.visiabletech.avision';
  //           final Uri appStoreUri = Uri.parse(appStoreUrl);
  //           if (await canLaunchUrl(appStoreUri)) {
  //             await launchUrl(appStoreUri, mode: LaunchMode.externalApplication);
  //           } else {
  //             print('Could not launch $appStoreUrl');
  //           }
  //         },
  //         child: const Text("Update"),
  //       ),
  //     ],
  //   ));
  // }


}
