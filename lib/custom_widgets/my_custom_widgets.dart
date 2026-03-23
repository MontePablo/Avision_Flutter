import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:avision/data_models/JobAlertsHomeResponse.dart';
import 'package:avision/data_models/assigmentSubjectStudentzoneResponse.dart';
import 'package:avision/data_models/assignmentChapterStudentzoneResponse.dart';
import 'package:avision/data_models/courselist_buyplan_response.dart';
import 'package:avision/data_models/currentAffairsDcaResponse.dart';
import 'package:avision/data_models/currentAffairsGkcaResponse.dart';
import 'package:avision/data_models/multiapiBannerResponse.dart';
import 'package:avision/data_models/dailyVocabListStudentzoneResponse.dart';
import 'package:avision/data_models/dateListNewsAppbarResponse.dart';
import 'package:avision/data_models/examListTestSeriesResponse.dart';
import 'package:avision/data_models/examlistExaminfoExamstudypracticeResponse.dart';
import 'package:avision/data_models/loginResponse.dart';
import 'package:avision/data_models/magazineStudentzoneResponse.dart';
import 'package:avision/data_models/multiApiTwoHomeResponse.dart';
import 'package:avision/data_models/multiApiLiveCourseResponse.dart';
import 'package:avision/data_models/newsListNewsAppBarResponse.dart';
import 'package:avision/data_models/planlist_buyplan_response.dart';
import 'package:avision/data_models/popularCourseHomeResponse.dart';
import 'package:avision/data_models/prevyearpaperSubjectsResponse.dart';
import 'package:avision/data_models/prevyearpaperTestsResponse.dart';
import 'package:avision/data_models/recordedvideosDrawerResponse.dart';
import 'package:avision/data_models/studentreviews_buyplan_response.dart';
import 'package:avision/data_models/subjectlistStudyExamstudypracticeResponse.dart';
import 'package:avision/data_models/subjectsPracticeExamstudypracticeResponse.dart';
import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';
import 'package:avision/database/quizDatabase.dart';
import 'package:avision/network/urls.dart';
import 'package:avision/quiz/datamodels/ansSubmitRequest.dart';
import 'package:avision/quiz/datamodels/questionResponse.dart';
import 'package:avision/quiz/datamodels/rankResponse.dart';
import 'package:avision/repositories/courselist_buyplan_repo.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/utils/colors.dart';
import 'package:avision/utils/constants.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../data_models/multiApiOneHomeResponse.dart';
import '../data_models/quiz.dart';
import '../data_models/quizAppbarSubjectlistResponse.dart';
import '../utils/routes.dart';

class MyButtonRound extends StatelessWidget {
  final Color color;
  final Color textColor;
  final double fontSize;
  final double cornerRadius;
  final VoidCallback onClick;
  final String title;
  final double paddingSides;
  MyButtonRound(
      {required this.color,
      required this.textColor,
      required this.fontSize,
      required this.cornerRadius,
      required this.onClick,
      required this.title,
      required this.paddingSides});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(cornerRadius),
        ),
        child: Center(
          child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: paddingSides, vertical: 8),
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButtonBordered extends StatelessWidget {
  final double paddingSides;
  final Color color;
  final Color textColor;
  final Color borderColor;
  final double fontSize;
  final double cornerRadius;
  final double borderWidth;
  final VoidCallback onClick;
  final String title;
  MyButtonBordered({
    required this.paddingSides,
    required this.color,
    required this.textColor,
    required this.borderColor,
    required this.fontSize,
    required this.cornerRadius,
    required this.borderWidth,
    required this.onClick,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(cornerRadius),
          border: Border.all(
            color: borderColor, // Replace with your desired border color
            width: borderWidth, // Adjust the border width as needed
          ),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(paddingSides, 4, paddingSides, 4),
            child: Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: fontSize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MyButtonWithIcon extends StatelessWidget {
  final double width;
  final IconData icon;
  final double iconSize;
  final double paddingSides;
  final String direction;
  final Color color;
  final Color textColor;
  final double fontSize;
  final double cornerRadius;
  final VoidCallback onClick;
  final String title;
  MyButtonWithIcon({
    required this.width,
    required this.icon,
    required this.iconSize,
    required this.paddingSides,
    required this.direction,
    required this.color,
    required this.textColor,
    required this.fontSize,
    required this.cornerRadius,
    required this.onClick,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: width,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              child: direction == "left"
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          icon,
                          size: iconSize,
                          color: textColor,
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                color: textColor,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                              title,
                              style: TextStyle(
                                color: textColor,
                                fontSize: fontSize,
                              ),
                            ),
                          ),
                        ),
                        Icon(
                          icon,
                          size: iconSize,
                          color: textColor,
                        ),
                      ],
                    )),
        ),
      ),
    );
  }
}

class MyCircularProgressIndicator extends StatelessWidget {
  final double size;
  final Color color;
  const MyCircularProgressIndicator({
    super.key,
    this.size = 60.0,
    this.color = Colors.blue,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          strokeWidth: 8.0,
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}

class MyAppbarItem extends StatelessWidget {
  final String iconPath;
  final String iconName;
  final VoidCallback onPressed;

  const MyAppbarItem({
    Key? key,
    required this.iconPath,
    required this.iconName,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [

          Container(
            height: MyConstants.sh*.08,
            width: MyConstants.sw*.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MyConstants.sh*.07,width: MyConstants.sw*.07,
                child: Image.asset(
                  iconPath,
                  color: MyColors.blue,
                ),
              ),
            ),
          ),
          Text(
            iconName,
            style: const TextStyle(color: Colors.white, fontSize: 10),
          )
        ],
      ),
    );
  }
}

class MyDrawerItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onPressed;
  const MyDrawerItem({
    super.key,
    required this.icon,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 0, 5),
      child: InkWell(
        onTap: onPressed,
        child: Row(
          children: [
            Icon(
              icon,
              size: MyConstants.sw * .06,
            ),
            SizedBox(
              width: MyConstants.sw * .07,
            ),
            Text(
              title,
              style: const TextStyle(color: Colors.black54, fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}

class ExamStudyPracticeItem extends StatelessWidget {
  final String iconPath;
  final String title;
  final VoidCallback onPressed;

  const ExamStudyPracticeItem(
      {super.key,
      required this.iconPath,
      required this.title,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.yellowToned,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          height: MyConstants.sh * .1,
          width: MyConstants.sw * .28,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                iconPath,
                scale: 1.5,
                color: MyColors.blue,
              ),
              Text(
                title,
                style: const TextStyle(color: MyColors.blue, fontSize: 12),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyStudentZoneItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final VoidCallback onPressed;
  const MyStudentZoneItem(
      {super.key,
      required this.title,
      required this.icon,
      required this.color,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          height: MyConstants.sh * 0.14,
          width: MyConstants.sw * .26,
          decoration: BoxDecoration(
            color: color,
            borderRadius:
                const BorderRadiusDirectional.all(Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(
                      icon,
                      size: MyConstants.sh*.07,
                      color: Colors.white,
                    )
                  ],
                ),
                Container(alignment: Alignment.center,
                    width: MyConstants.sw * .22,
                    height: MyConstants.sh*.06,
                    child: AutoSizeText(
                      overflow: TextOverflow.fade,
                      title,
                      maxLines: 2,textAlign: TextAlign.center,
                      style:  TextStyle(
                        color: MyColors.white,
                        fontSize: MyConstants.sw*.04
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyTrendingTestItem extends StatelessWidget {
  final TrendingTest trendingTest;
  const MyTrendingTestItem({
    super.key,
    required this.trendingTest,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        width: MyConstants.sw * .28,
        height: MyConstants.sh * .05,
        decoration: BoxDecoration(
          color: MyColors.grey,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MyConstants.sh * .1,
              width: MyConstants.sw * .16,
              child: CircleAvatar(
                backgroundColor: MyColors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: trendingTest.subCategoryImage != null
                      ? Image.network(trendingTest.subCategoryImage!, scale: 1)
                      : const Icon(
                          Icons.image_not_supported,
                          size: 100,
                        ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 1, right: 1),
              child: Text(
                trendingTest.subCategoryName ?? "",
                style: TextStyle(
                  color: MyColors.white,
                  fontSize: trendingTest.subCategoryName!.length < 7 ? 13 : 9,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MyJobAlertsItem extends StatelessWidget {
  final JobAlert jobAlert;
  const MyJobAlertsItem({
    super.key,
    required this.jobAlert,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: MyColors.grey.withOpacity(0.5),
                blurStyle: BlurStyle.outer,
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(5, 5), // changes position of shadow
              ),
            ],
          ),
          height: MyConstants.sh * .10,
          width: MyConstants.sw * .94,
          child: Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                          child: Text(
                        jobAlert.jobTitle!,
                      )),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: InkWell(
                            child: Icon(
                          Icons.share,
                          size: MyConstants.sh * .025,
                        )),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 1.0, right: 1),
                child: SizedBox(
                    width: MyConstants.sw * .3,
                    child: Image.network(
                      jobAlert.jobImg!,
                      scale: 1,
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyQuizListSquare extends StatelessWidget {
  final QuizIntroDetail? quiz;
  final VoidCallback? onClick;
  final MyEnumConstants type;
  const MyQuizListSquare(
      {super.key,required this.type, required this.quiz, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all(MyConstants.sh*.01),
      child: Container(
        width: MyConstants.sw * .8,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: MyColors.grey.withOpacity(0.5),
              blurStyle: BlurStyle.normal,
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: MyConstants.sh*.11,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: AutoSizeText(
                    overflow: TextOverflow.fade,
                    minFontSize: 5,
                    maxLines: 3,
                    quiz?.quizName ?? "",textAlign: TextAlign.center,
                    style:  TextStyle(color: Colors.black,fontSize: MyConstants.sh*.025, fontWeight: FontWeight.bold),),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.circle,
                              color: Colors.red,
                              size: 12,
                            ),
                            Text(
                              "  LIVE",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyConstants.sw*.03),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                             Icon(
                              Icons.access_time_filled,
                              color: Colors.black54,
                              size: MyConstants.sw*.03,
                            ),
                            Text(
                              "  ${(quiz?.totalTime ?? 0) ~/ 60} Minutes | ${quiz?.totalMarks!} Marks",
                              style:  TextStyle(
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyConstants.sw*.03),
                            ),
                          ],
                        ),
                      ),
                       Padding(
                        padding: EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            Icon(
                              Icons.language,
                              color: Colors.black54,
                              size: MyConstants.sw*.03,
                            ),
                            Text(
                              "  English / Bengali / Hindi",
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                  fontSize: MyConstants.sw*.03),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: MyConstants.sw*.04),
                    child: MyButtonRound(
                      color:(type==MyEnumConstants.RESULT_QUIZ?Colors.green:type==MyEnumConstants.RESUME_QUIZ?Colors.yellow:MyColors.blue),
                      textColor: Colors.white,
                      fontSize: MyConstants.sw * .03,
                      cornerRadius: 5,
                      onClick: onClick!,
                      title:(type==MyEnumConstants.RESULT_QUIZ?"View Result":type==MyEnumConstants.RESUME_QUIZ?"Resume Test":"Start Test"),
                      paddingSides: 8,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class MyQuizListLong extends StatelessWidget {
  final QuizIntroDetail? quiz;
  final VoidCallback? onClick;
  final MyEnumConstants type;
  const MyQuizListLong(
      {super.key,required this.type, required this.quiz, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onClick,
        child: Container(
          height: MyConstants.sh * .13,
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: MyColors.grey.withOpacity(0.5),
                blurStyle: BlurStyle.normal,
                spreadRadius: 3,
                blurRadius: 2,
                offset: const Offset(2, 2), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 50,  // Width of the circle
                  height: 50, // Height of the circle
                  decoration: BoxDecoration(
                    color: Utility.getRandomMatchingColor(), // Background color of the circle
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(50), // Make it circular
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black.withOpacity(0.2), // Shadow color with slight transparency
                    //     spreadRadius: 1,   // How much the shadow should spread
                    //     blurRadius: 5,     // How blurry the shadow should be
                    //     offset: Offset(0, 2), // Shadow position
                    //   ),
                    // ],
                  ),
                  child: Center(
                    child: Text(quiz!.quizName!.substring(0,1),style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  )
                ),
                SizedBox(
                  width: MyConstants.sw*.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(quiz!.quizName!,style:const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text("${quiz!.totalQuestion!} Questions",style: const TextStyle(color: Colors.black54),),
                          Text("${quiz!.totalTime.toString().length<=2 ? quiz!.totalTime.toString() : quiz!.totalTime!/60} Minutes",style: const TextStyle(color: Colors.black54),)

                        ],),
                    ],
                  ),
                ),
                // Row(
                //   children: [
                //     Icon(CupertinoIcons.play_arrow_solid,color: Colors.blue,),
                //     Text("Attempt",style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
                //   ],
                // )
                SizedBox(
                  height: MyConstants.sh*.05,
                  child: MyButtonRound(
                    color:(type==MyEnumConstants.RESULT_QUIZ?Colors.green:type==MyEnumConstants.RESUME_QUIZ?Colors.yellow:MyColors.blue),
                    textColor: Colors.white,
                    fontSize: MyConstants.sw * .03,
                    cornerRadius: 5,
                    onClick: onClick!,
                    title:(type==MyEnumConstants.RESULT_QUIZ?"View Result":type==MyEnumConstants.RESUME_QUIZ?"Resume Test":"Start Test"),
                    paddingSides: 6,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPopularCourseItem extends StatelessWidget {
  final PopularCourse popularCourse;
  const MyPopularCourseItem({
    super.key,
    required this.popularCourse,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: MyConstants.sh*.02,vertical: MyConstants.sw*.02),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: MyColors.black.withOpacity(0.5),
              blurStyle: BlurStyle.normal,
              spreadRadius: 5,
              blurRadius: 5,
              offset: const Offset(5, 5), // changes position of shadow
            ),
          ],
        ),
        height: MyConstants.sh * .2,
        width: MyConstants.sw * .80,
        alignment: Alignment.center,
        child: ClipRRect(
          borderRadius:
              BorderRadius.circular(10), // Match container's border radius
          child: Image.network(
            popularCourse.productImage!,
            fit: BoxFit.fill,
            width:
                double.infinity, // Ensure image covers entire container width
            height:
                double.infinity, // Ensure image covers entire container height
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

class MyPostItem extends StatelessWidget {
  final Post post;
  const MyPostItem({
    super.key,
    required this.post,
  });

  @override
  Widget build(BuildContext context) {
    var quiz=QuizIntroDetail();
    if(post.quizArray!=null && post.quizArray!.isNotEmpty){
      quiz=Utility.feedPostQuizToQuizDetailConvert(post.quizArray!.first);
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: MyColors.grey.withOpacity(0.5),
              blurStyle: BlurStyle.normal,
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 0), // changes position of shadow
            ),
          ],
        ),
        // width: MyConstants.sw * .9,
        // height: MyConstants.sh * .8,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/avatar.png",
                        scale: MyConstants.sh * .013,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Column(
                            children: [
                              Text(
                                post.userName ?? "Avision Admin",
                                style: TextStyle(fontSize: 13),
                              ),
                              Text(
                                post.postCategory!,
                                style: TextStyle(
                                    fontSize: 12,
                                    color: MyColors.blue,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.share_outlined),
                  )
                ],
              ),
            ),
            (post.quizArray == null || post.quizArray!.isEmpty)
                ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          post.postTitle!,
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.bold),
                        ),
                        Image.network(
                          post.postImage!,
                        ),
                      ],
                    ),
                )
                :
            FutureBuilder(
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

                return MyQuizListSquareTwo(
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
            ),
          ],
        ),
      ),
    );
  }
}
class MyQuizListSquareTwo extends StatelessWidget {
  final QuizIntroDetail? quiz;
  final VoidCallback onClick;
  final MyEnumConstants type;
  const MyQuizListSquareTwo(
      {super.key,required this.type, required this.quiz, required this.onClick});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: MyColors.grey.withOpacity(0.5),
              blurStyle: BlurStyle.normal,
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(
                  2, 2), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Image.asset(
              "assets/images/quiz.png",
              scale: 3,
            ),
            Text(
              quiz?.quizName??"",
              style: TextStyle(
                  fontWeight: FontWeight.bold, fontSize: 15),
            ),
            Text("${quiz?.totalQuestion!} questions | ${(quiz?.totalTime ?? 0) ~/ 60} minutes"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: MyButtonRound(
                color: (type==MyEnumConstants.RESULT_QUIZ?Colors.green:type==MyEnumConstants.RESUME_QUIZ?Colors.yellow:MyColors.blue),
                textColor: Colors.white,
                fontSize: 12,
                cornerRadius: 10,
                onClick: onClick,
                title: (type==MyEnumConstants.RESULT_QUIZ?"View Result":type==MyEnumConstants.RESUME_QUIZ?"Resume Test":"Start Test"),
                paddingSides: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MySliderImage extends StatelessWidget {
  final String image;
  const MySliderImage(
      {super.key,
      required this.image,});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: MyColors.grey.withOpacity(0.5),
              blurStyle: BlurStyle.normal,
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(2, 2), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              image,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
            )),
      ),
    );
  }
}

class MyIndicator extends StatelessWidget {
  int activeIndex;
  final int count;
  MyIndicator({
    super.key,
    required this.activeIndex,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      activeIndex: activeIndex,
      count: count,
      effect: const ColorTransitionEffect(
        dotColor: MyColors.grey,
        activeDotColor: Colors.lightBlueAccent,
        dotWidth: 10,
        dotHeight: 10,
        strokeWidth: 10,
      ),
      // effect: ExpandingDotsEffect(activeDotColor: MyColors.blue,dotWidth: MyConstants.sw*.007,dotHeight: MyConstants.sh*.01,dotColor: MyColors.grey,strokeWidth: 10),
    );
  }
}

class MyCourse extends StatelessWidget {
  final Course course;
  const MyCourse({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Container(
        decoration: BoxDecoration(
          color: MyColors.yellowToned,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: MyColors.grey.withOpacity(0.5),
              blurStyle: BlurStyle.normal,
              spreadRadius: 3,
              blurRadius: 2,
              offset: const Offset(2, 1), // changes position of shadow
            ),
          ],
        ),
        // height: MyConstants.sh*.27,
        // width: MyConstants.sw*.46,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(course.courseImage!,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}

class MyTeacher extends StatelessWidget {
  final TeachersDetail teachersDetail;
  const MyTeacher({super.key, required this.teachersDetail});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: MyColors.grey.withOpacity(0.5),
                blurStyle: BlurStyle.normal,
                spreadRadius: 3,
                blurRadius: 2,
                offset: const Offset(2, 1), // changes position of shadow
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      teachersDetail.teacherImage!,
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                    )),
              ),
              SizedBox(
                width: MyConstants.sw * .03,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    teachersDetail.teacherName!,
                    style: const TextStyle(color: Colors.brown, fontSize: 16),
                  ),
                  SizedBox(
                      width: MyConstants.sh * .2,
                      child: Text(
                          "${teachersDetail.teacherExperience!} years experience in ${teachersDetail.teacherSpecialization!}",
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ))),
                  Text(
                    teachersDetail.qualification!,
                    style: const TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                ],
              )
            ],
          )),
    );
  }
}

class MyPopupBanner extends StatelessWidget {
  final SingleBanner? banner;
  final BuildContext context;
  const MyPopupBanner({super.key,required this.banner,required this.context});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MyConstants.sh * .7,
      width: MyConstants.sw,
      child: Stack(
        children: [
          Image.network(
            banner!.bannerImage!,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fill,
          ),
          Positioned(
            left: 0,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: InkWell(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: const Icon(
                      Icons.cancel,
                      color: MyColors.blue,
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyPriceClickDialog extends StatelessWidget {
  final Plans plan;
  final VoidCallback onClick;
  const MyPriceClickDialog({super.key,required this.plan,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Material(
            color: Colors.transparent, // Ensures the dialog background is transparent
            child: InkWell(
              onTap: onClick,
              child: Container(
                height: MyConstants.sh * 0.08, // Adjust height as needed
                width: MyConstants.sw, // Adjust width as needed
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white,width: 2),
                  color: Colors.deepOrangeAccent, // Background color of the dialog
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Center(
                  child: Text(
                    "${int.parse(plan.duration!)~/30} MONTH PLAN | CONTINUE TO PAY ₹${plan.offerPrice}",
                    style:const TextStyle(fontSize: 16, color: Colors.white,fontWeight: FontWeight.bold),
                  ), // Placeholder for your content
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class MyTestSeriesExam extends StatelessWidget {
  final TestSeries testSeries;
  const MyTestSeriesExam({super.key, required this.testSeries});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(testSeries.testSeriesImage!),
            Text(
              testSeries.testSeriesName!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(testSeries.testSeriesTotalTest! + " Total Test")
          ],
        ),
      ),
    );
  }
}

class MyVideoTileLong extends StatelessWidget {
  final Video video;
  const MyVideoTileLong({
    super.key,
    required this.video,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.youtubePlayerRoute,
            arguments: video);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8, bottom: 8),
        child: Container(
          // height: MyConstants.sh * .12,
          width: MyConstants.sw * .9,
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
          child: Row(
            children: [
              SizedBox(
                width: MyConstants.sw * .35,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // child: Image.network(video.videoImg!)
                  child: CachedNetworkImage(
                    imageUrl: video.videoImg!,
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: CircularProgressIndicator(),
                    ),
                    // progressIndicatorBuilder: (context, url, downloadProgress) =>
                    //     CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: MyConstants.sw * .6,
                      child: Text(
                        video.videoName!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      )),
                  Text(video.typeName!)
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyVideoTileShort extends StatelessWidget {
  final Video video;
  const MyVideoTileShort({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.youtubePlayerRoute,
            arguments: video);
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 15),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: MyColors.grey.withOpacity(0.5),
                blurStyle: BlurStyle.normal,
                spreadRadius: 2,
                blurRadius: 2,
                offset: const Offset(2, 1), // changes position of shadow
              ),
            ],
          ),
          height: MyConstants.sh * .2,
          width: MyConstants.sw * .7,
          child: Image.network(
            video.videoImg!,
            fit: BoxFit.cover,
            width: double.infinity,
            alignment: Alignment.center,
          ),
        ),
      )
    );
  }
}

class MySubjectwiseVideoListItem extends StatelessWidget {
  final SubjectWiseVideo subjectWiseVideo;
  const MySubjectwiseVideoListItem({
    super.key,
    required this.subjectWiseVideo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, bottom: 8),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  subjectWiseVideo.subjectName!,
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, MyRoutes.videolistDrawerRoute,
                          arguments: [MyEnumConstants.SUBJECTWISE_VIDEO_LIST,subjectWiseVideo.subjectId!]
                          );
                    },
                    child: const Text(
                      "View All",
                      style: TextStyle(
                          color: MyColors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),
              ],
            ),
            Text(
              subjectWiseVideo.videoCount.toString() + " Videos",
              style: TextStyle(color: Colors.black87, fontSize: 14),
            ),
            SizedBox(
              height: MyConstants.sh * .01,
            ),
            subjectWiseVideo.videoCount! > 0
                ? SizedBox(
                    height: MyConstants.sh * .32,
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: subjectWiseVideo.videosList!.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return MyVideoTileShort(
                              video: subjectWiseVideo.videosList!
                                  .elementAt(index));
                        }),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}

class MyCurrentAffairHome extends StatefulWidget {
  final CurrentAffairMultiapione currentAffair;
  // final VoidCallback onClick;
  const MyCurrentAffairHome({super.key, required this.currentAffair});

  @override
  State<MyCurrentAffairHome> createState() => _MyCurrentAffairHomeState();
}

class _MyCurrentAffairHomeState extends State<MyCurrentAffairHome> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InkWell(
        onTap: () {
          widget.currentAffair.isExpanded = !widget.currentAffair.isExpanded;
          setState(() {});
        },
        child: Container(
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
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MyConstants.sw * .7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.currentAffair.postTitle!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.yellow),
                      ),
                      Text(
                        getQestions(),
                      ),
                    ],
                  ),
                ),
                Image.asset(
                  "assets/images/currentAffairs.png",
                  scale: 4,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getQestions() {
    String txt = "";
    if (widget.currentAffair.isExpanded == false) {
      for (var i = 0; i < 2; i++) {
        txt += "\n" + widget.currentAffair.metaValue!.elementAt(i) + "\n";
      }
    } else {
      for (final i in widget.currentAffair.metaValue!) {
        txt += "\n$i\n";
      }
    }
    return txt;
  }
}

class MyCurrentAffairGkcaItem extends StatelessWidget {
  const MyCurrentAffairGkcaItem({super.key, required this.currentAffair});
  final CurrentAffairGkca currentAffair;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.currentAffairGkcaDetail,
            arguments: currentAffair);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  currentAffair.postTitle!.length >= 110
                      ? currentAffair.postTitle!.substring(0, 109)
                      : currentAffair.postTitle!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(currentAffair.postContent!.length >= 180
                    ? currentAffair.postContent!.substring(0, 179)
                    : currentAffair.postContent!),
                Text(
                  currentAffair.postDate!,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyNewsItemNewsAppbar extends StatelessWidget {
  final News news;
  const MyNewsItemNewsAppbar({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.newsDetailNewsAppbar,
            arguments: news);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
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
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  news.title!.length >= 110
                      ? news.title!.substring(0, 109)
                      : news.title!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.start,
                ),
                SizedBox(
                  height: MyConstants.sh * 0.01,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: MyConstants.sw * .5,
                      height: MyConstants.sh * .1,
                      // child: Text(news.content!.length>=180
                      //     ?news.content!.substring(0,179)
                      //     :news.content!,textAlign: TextAlign.start,),
                      child: Html(
                        data: news.content,
                      ),
                    ),
                    Expanded(
                      child: CachedNetworkImage(
                        imageUrl: news.imageUrl!,
                        placeholder: (context, url) => const CircleAvatar(
                          backgroundColor: Colors.white,
                          child: CircularProgressIndicator(),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.image_not_supported),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDateItemNewsAppbar extends StatelessWidget {
  final NewsDate? date;
  final VoidCallback onClick;
  const MyDateItemNewsAppbar(
      {super.key, required this.date, required this.onClick});

  @override
  Widget build(BuildContext context) {
    List<String> dateArray =
        (Utility().formatDate(date!.postedDate!.toString())).split(" ");

    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0, right: 2.0, left: 2),
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                dateArray.elementAt(0),
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(dateArray.elementAt(1)),
              Text(dateArray.elementAt(2)),
            ],
          ),
        ),
      ),
    );
  }
}

class MyMagazineItem extends StatelessWidget {
  final Magazine mag;
  const MyMagazineItem({super.key, required this.mag});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.webviewPage,
            arguments: mag.magagineLink);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  // child: Image.network(video.videoImg!)
                  child: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: CachedNetworkImage(
                      fit: BoxFit.fill,
                      imageUrl: mag.magagineImg!,
                      placeholder: (context, url) => const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: CircularProgressIndicator(),
                      ),
                      // progressIndicatorBuilder: (context, url, downloadProgress) =>
                      //     CircularProgressIndicator(value: downloadProgress.progress),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.image_not_supported),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: MyConstants.sw * .03,
              ),
              SizedBox(
                width: MyConstants.sw * .55,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      mag.magagineTitle!,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: MyColors.blue),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          mag.magagineDate!,
                          style: TextStyle(color: MyColors.grey),
                        ),
                        InkWell(
                            onTap: () {
                              Utility()
                                  .downloadFile(mag.magagineLink!, context);
                            },
                            child: const Icon(Icons.download_for_offline,
                                color: MyColors.blue, size: 35)),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
class MyDcaItem extends StatelessWidget {
  final CurrentAffairHomeDca data;
  const MyDcaItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.webviewPage,
            arguments: data.metaValue);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset("assets/images/coloured_calender_logo.png",scale: 1.7,),
                SizedBox(
                  width: MyConstants.sw * .03,
                ),
                SizedBox(
                  width: MyConstants.sw * .7,
                  child: Column(
                    children: [
                      Text(
                        data.postTitle!,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: MyColors.blue),
                      ),
                       Html(data: data.postContent!)
                    ],
                  ),
                ),
                InkWell(
                    onTap: () {
                      Utility()
                          .downloadFile(data.metaValue!, context);
                    },
                    child: const Icon(Icons.download_for_offline,
                        color: MyColors.blue, size: 35)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyDailyVocabItem extends StatelessWidget {
  final Vocab vocab;
  final VoidCallback onClick;
  const MyDailyVocabItem(
      {super.key, required this.vocab, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: vocab.image!,
                    placeholder: (context, url) => const CircleAvatar(
                      backgroundColor: Colors.white,
                      child: CircularProgressIndicator(),
                    ),
                    // progressIndicatorBuilder: (context, url, downloadProgress) =>
                    //     CircularProgressIndicator(value: downloadProgress.progress),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              SizedBox(
                width: MyConstants.sw * .03,
              ),
              SizedBox(
                width: MyConstants.sw * .55,
                child: Text(
                  vocab.title!,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MyAssignmentSubjectItem extends StatelessWidget {
  final AssignmentSubject subject;
  final int index;
  const MyAssignmentSubjectItem(
      {super.key, required this.subject, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.assignmentChapterStudentzonePage,
            arguments: subject);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
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
            border: Border.all(
              color: MyColors.blue, // Replace with your desired border color
              width: 1, // Adjust the width as needed
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  // Adjust the height as needed
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: MyColors
                          .blue, // Replace with your desired border color
                      width: 2.0, // Adjust the border width as needed
                    ),
                  ),
                  child: CircleAvatar(
                    backgroundColor: MyColors
                        .white, // Replace with your desired background color
                    child: Center(
                        child: Text(index.toString(),
                            style: const TextStyle(
                                color: MyColors.blue,
                                fontWeight: FontWeight.bold))),
                  ),
                ),
              ),
              Expanded(
                  child: Center(
                      child: Text(
                subject.typeName ?? "",
                style: const TextStyle(color: MyColors.blue),
              )))
            ],
          ),
        ),
      ),
    );
  }
}

class MyAssignmentChapterItem extends StatelessWidget {
  final AssignmentChapter chapter;
  const MyAssignmentChapterItem({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, MyRoutes.webviewPage,
            arguments: chapter.fileUrl);
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: Container(
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
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  chapter.assignmentName ?? "",
                ),
                const Icon(Icons.keyboard_arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyPrevYrPaperSubjectItem extends StatelessWidget {
  final PrevYrSubject subject;
  final VoidCallback onClick;
  const MyPrevYrPaperSubjectItem(
      {super.key, required this.subject, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network(subject.subCatImg!),
              Text(subject.subCategoryName!,textAlign: TextAlign.center,)
            ]
          ),
        ),
      ),
    );
  }
}

class MyPrevYrPaperTestItem extends StatelessWidget {
  final PrevYrTest test;
  final VoidCallback onClick;

  const MyPrevYrPaperTestItem(
      {super.key, required this.test, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          child: Center(),
        ),
      ),
    );
  }
}

class MyQuizIntro {
  final BuildContext context;
  final QuizIntroDetail quizDetail;
  final VoidCallback onClick;
  MyQuizIntro(
      {required this.context,
      required this.quizDetail,
      required this.onClick}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
                Colors.transparent, // Set background color to transparent
            contentPadding: EdgeInsets.zero,
            elevation: 0,
            content: SizedBox(
              height: MyConstants.sh * .9,
              width: MyConstants.sw,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: MyColors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: MyColors.grey.withOpacity(0.5),
                          blurStyle: BlurStyle.normal,
                          spreadRadius: 1,
                          blurRadius: 4,
                          offset:
                              const Offset(2, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    // color: Colors.white,
                    child: Column(
                      children: [
                        Image.asset("assets/images/back_drawing.png"),
                        SizedBox(
                          height: MyConstants.sh * .07,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/totalquestion.png",
                                  height: 30,
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Text(quizDetail.totalQuestion ?? "",
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    const Text("Questions",
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/totaltime.png",
                                  height: 30,
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Text(
                                        (quizDetail.totalTime! / 60).toString(),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    const Text("Minutes",
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ],
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/totalmarks.png",
                                  height: 30,
                                  width: 30,
                                ),
                                Column(
                                  children: [
                                    Text(quizDetail.totalMarks.toString(),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                    const Text("Marks",
                                        style:
                                            TextStyle(color: Colors.black54)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                        SizedBox(
                          height: MyConstants.sh * .05,
                        ),
                        Center(
                          child: SizedBox(
                            width: MyConstants.sw * .3,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.candlestick_chart,
                                      color: Colors.red,
                                    ),
                                    Text(
                                      quizDetail.negativeMarks.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Marks",
                                      style: TextStyle(color: Colors.black54),
                                    )
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Icon(
                                      Icons.candlestick_chart,
                                      color: Colors.green,
                                    ),
                                    Text(
                                      quizDetail.positiveMarks.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const Text(
                                      "Marks",
                                      style: TextStyle(color: Colors.black54),
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: MyConstants.sh * .03,
                        ),
                        Text("Available language"),
                        SizedBox(
                          height: MyConstants.sh * .01,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.all(
                              color: MyColors
                                  .blue, // Replace with your desired border color
                              width: 2.0, // Adjust the border width as needed
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Text("English"),
                          ),
                        ),
                        SizedBox(
                          height: MyConstants.sh * .02,
                        ),
                        const Text(
                          "Instructions",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: MyConstants.sh * .005,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Text(
                            "The clock will be set by server.The cowndown timer in the top right corner of the screen will display the remaining time available for you to complete the exam. when the timer reaches zero, the examination will end by itself",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      onTap: onClick,
                      child: Container(
                        width: MyConstants.sw,
                        height: MyConstants.sh * .05,
                        decoration:
                            BoxDecoration(color: Colors.lightBlueAccent),
                        child: const Center(
                          child: Text(
                            "Start Test",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: InkWell(
                        child: const Icon(
                          Icons.arrow_back,
                          color: MyColors.white,
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

class QuizQuestion extends StatelessWidget {
  final MyEnumConstants usage;
  final QuestionDtl questionDtl;
  final int index;
  final Function(int, QuestionDtl) onAnsClick;
  const QuizQuestion(
      {super.key,
      required this.usage,
      required this.questionDtl,
      required this.index,
      required this.onAnsClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.red,
      height: MyConstants.sh * .8,
      width: MyConstants.sw,
      child: Column(
        children: [
          Container(
            height: MyConstants.sh * .05,
            width: MyConstants.sw,
            color: Colors.black12,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                (index + 1).toString(),
                style: const TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Text(
                    questionDtl.question ?? "",
                    style: const TextStyle(
                        color: Colors.black87, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                    color: questionDtl.isReviewed ?? false
                        ? Colors.yellow
                        : Colors.white,
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: questionDtl.ans!.length,
                        itemBuilder: (context, index) {
                          return usage == MyEnumConstants.LIVE_EXAM
                              ? QuizAnswerForLiveExam(
                                  index: index,
                                  ans: questionDtl.ans![index],
                                  questionDtl: questionDtl,
                                  onClick: onAnsClick)
                              : QuizAnswerForResult(
                                  index: index,
                                  ans: questionDtl.ans![index],
                                  questionDtl: questionDtl,
                                  onClick: onAnsClick);
                        }))
              ],
            ),
          )
        ],
      ),
    );
  }
}

class QuizAnswerForLiveExam extends StatelessWidget {
  final int index;
  final QuestionDtl questionDtl;
  final Ans ans;
  final Function(int, QuestionDtl) onClick;
  const QuizAnswerForLiveExam(
      {super.key,
      required this.index,
      required this.ans,
      required this.questionDtl,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () => onClick(index, questionDtl),
        child: Container(
          decoration: BoxDecoration(
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
            color: index == (questionDtl.selectedAnsPos ?? -1)
                ? Colors.blueGrey[300]
                : Colors.white,
            // borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(
              color: index == (questionDtl.selectedAnsPos ?? -1)
                  ? Colors.black54
                  : Colors
                      .transparent, // Replace with your desired border color
              width: 2, // Adjust the border width as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text((index + 1).toString()),
                SizedBox(
                  width: MyConstants.sw * .1,
                ),
                SizedBox(
                    width: MyConstants.sw * .75, child: Text(ans.answer ?? "")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class QuizAnswerForResult extends StatelessWidget {
  final int index;
  final QuestionDtl questionDtl;
  final Ans ans;
  final Function(int, QuestionDtl) onClick;
  const QuizAnswerForResult(
      {super.key,
      required this.index,
      required this.ans,
      required this.questionDtl,
      required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: InkWell(
        onTap: () => onClick(index, questionDtl),
        child: Container(
          decoration: BoxDecoration(
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
            color: ans.answerStatus == "1" && ans.answerId == questionDtl.givenAnsStat
                ? Colors.lightGreenAccent
                : ans.answerStatus != "1" && ans.answerId == questionDtl.givenAnsStat
                    ? Colors.redAccent
                    : ans.answerStatus == "1" && ans.answerId != questionDtl.givenAnsStat
                        ? Colors.blueGrey[300]
                        : Colors.white,
            // borderRadius: BorderRadius.circular(cornerRadius),
            border: Border.all(
              color: ans.answerStatus=="1" || ans.answerId==questionDtl.givenAnsStat
                  ? Colors.black54
                  : Colors
                      .transparent, // Replace with your desired border color
              width: 2, // Adjust the border width as needed
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text((index + 1).toString()),
                SizedBox(
                  width: MyConstants.sw * .1,
                ),
                SizedBox(
                    width: MyConstants.sw * .75, child: Text(ans.answer ?? "")),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CountdownTimerWidget extends StatefulWidget {
  final GlobalKey<CountdownTimerWidgetState> key;

  const CountdownTimerWidget({required this.key}) : super(key: key);

  // Wrappers to expose the internal methods of the state
  void setTime(int seconds) {
    key.currentState?.setTime(seconds);
  }

  bool? isRunning() {
    return key.currentState?.isRunning();
  }

  int getTotalTimeTaken() {
    return key.currentState?.getTotalTimeTaken() ?? 0;
  }

  int getTimeLeft() {
    return key.currentState?.getTimeLeft() ?? 0;
  }

  void setOnFinish(Function() callback) {
    key.currentState?.setOnFinish(callback);
  }

  void stopTimer() {
    key.currentState?.stopTimer();

  }
  void dispose(){
    key.currentState?.dispose();
  }

  @override
  CountdownTimerWidgetState createState() => CountdownTimerWidgetState();
}

class CountdownTimerWidgetState extends State<CountdownTimerWidget> {
  int _totalSeconds = 0;
  int _secondsBackup = 0;
  Timer? _timer;
  bool _isRunning = false;
  VoidCallback? _onFinish;

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void setTime(int seconds) {
    setState(() {
      _totalSeconds = seconds;
      _secondsBackup = seconds;
      _isRunning = false;
    });
    _timer?.cancel();
    startTimer();
  }

  void stopTimer() {
    if (_isRunning) {
      _timer?.cancel();
    }
    _isRunning=false;
  }

  void startTimer() {
    if (!_isRunning) {
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (_totalSeconds > 0) {
          setState(() {
            _totalSeconds--;
          });
        } else {
          _timer?.cancel();
          setState(() {
            _isRunning = false;
          });
          if (_onFinish != null) {
            _onFinish!();
          }
        }
      });
      setState(() {
        _isRunning = true;
      });
    }
  }

  bool isRunning() {
    return _isRunning;
  }

  int getTotalTimeTaken() {
    return _secondsBackup - _totalSeconds;
  }

  int getTimeLeft() {
    return _totalSeconds;
  }

  void setOnFinish(VoidCallback callback) {
    _onFinish = callback;
  }

  String formatTime(int totalSeconds) {
    int hours = totalSeconds ~/ 3600;
    int minutes = (totalSeconds % 3600) ~/ 60;
    int seconds = totalSeconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          formatTime(_totalSeconds),
          style: const TextStyle(fontSize: 20, color: Colors.white),
        ),
      ],
    );
  }
}

class MyQuizFinalDialog {
  final BuildContext context;
  final int currentTime;
  final QuizAnsSubmitRequest ansSubmit;
  final VoidCallback onClick;

  MyQuizFinalDialog(
      {required this.context,
      required this.currentTime,
      required this.ansSubmit,
      required this.onClick}) {
    CountdownTimerWidget timer =
        CountdownTimerWidget(key: GlobalKey<CountdownTimerWidgetState>());
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, setState) {
            if (!(timer.isRunning() ?? false)) {
              timer.setTime(currentTime);
            }
            Timer(const Duration(milliseconds: 1), () {
              setState(() {});
            });
            return AlertDialog(
              backgroundColor:
                  Colors.transparent, // Set background color to transparent
              contentPadding: EdgeInsets.zero,
              elevation: 0,
              content: SizedBox(
                height: MyConstants.sh * .35,
                width: MyConstants.sw,
                child: Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            width: MyConstants.sw,
                            color: CupertinoColors.systemGrey,
                            child: Column(
                              children: [
                                Text(
                                  "Time remaining",
                                  style: TextStyle(color: MyColors.white),
                                ),
                                timer
                              ],
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    "Answered",
                                    style: TextStyle(color: MyColors.blue),
                                  ),
                                  Text(
                                    "Not Answered",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                  Text(
                                    "Marked as Reviewed",
                                    style: TextStyle(color: Colors.yellow),
                                  ),
                                ],
                              ),
                              SizedBox(width: MyConstants.sw * .1),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    ansSubmit.attempt.toString(),
                                    style: TextStyle(color: MyColors.blue),
                                  ),
                                  Text(
                                    ansSubmit.notAttempt.toString(),
                                    style: TextStyle(color: MyColors.blue),
                                  ),
                                  Text(
                                    ansSubmit.review.toString(),
                                    style: TextStyle(color: MyColors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(
                              width: MyConstants.sw * .4,
                              child: MyButtonRound(
                                  color: Colors.greenAccent,
                                  textColor: Colors.white,
                                  fontSize: 17,
                                  cornerRadius: 10,
                                  onClick: onClick,
                                  title: "Submit Test",
                                  paddingSides: 10)),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: InkWell(
                          child: const Icon(
                            Icons.arrow_back,
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
        });
  }
}
class PauseExitDialog {
  final BuildContext context;
  final VoidCallback onPause;
  PauseExitDialog({
    required this.context,
    required this.onPause,
  }) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
            Colors.transparent, // Set background color to transparent
            contentPadding: EdgeInsets.zero,
            elevation: 0,
            content: Container(
              color: Colors.white,
              height: MyConstants.sh * .15,
              width: MyConstants.sw,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                          width: MyConstants.sw*.8,
                          child: const Text("Do you really want to Pause and go back to previous menu?",style: TextStyle(fontWeight: FontWeight.bold,),textAlign:  TextAlign.center,)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children:[
                          MyButtonRound(color: Colors.grey, textColor: Colors.white, fontSize: 15, cornerRadius: 10, onClick: (){Navigator.of(context).pop();}, title: "Cancel", paddingSides: 20),
                          MyButtonRound(color: Colors.blue, textColor: Colors.white, fontSize: 15, cornerRadius: 10, onClick: onPause, title: "Pause & Exit", paddingSides: 20)

                    ]
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}


class MyQuizRank extends StatelessWidget {
  final StudentRank studentRank;
  final int total;
  const MyQuizRank({super.key, required this.studentRank, required this.total});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, right: 4, bottom: 8),
      child: Container(
        height: MyConstants.sh * .05,
        width: MyConstants.sw,
        decoration: BoxDecoration(
          color: MyColors.white,
          borderRadius: BorderRadius.circular(20),
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
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              studentRank.userImage != null && studentRank.userImage!.isNotEmpty
                  ? Image.network(studentRank.userImage!)
                  : Image.asset("assets/images/user_placeholder.png"),
              Text(studentRank.userName ?? ""),
              Text("${studentRank.rank}/$total")
            ],
          ),
        ),
      ),
    );
  }
}
class MyCalenderDate extends StatelessWidget {
  final String date;
  final bool isSelected;
  const MyCalenderDate({super.key,required this.date,required this.isSelected});

  @override
  Widget build(BuildContext context) {
    var splittedDate=Utility.splitDateWithMonthName(date);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0,bottom: 4),
      child:   Container(
      width: 50,  // Width of the circle
      height: 50, // Height of the circle
      decoration: BoxDecoration(
        color: isSelected?Colors.cyanAccent:Colors.white, // Background color of the circle
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(50), // Make it circular
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color with slight transparency
            spreadRadius: 1,   // How much the shadow should spread
            blurRadius: 5,     // How blurry the shadow should be
            offset: Offset(0, 2), // Shadow position
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(splittedDate[2],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
          Text(splittedDate[1],style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold),),
        ],
      ),
    ),
    );
  }
}
class QuizSubjectList extends StatelessWidget {
  final Subject subject;
  final VoidCallback onClick;
  const QuizSubjectList({super.key,required this.subject, required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onClick,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: Utility.getRandomMatchingColor(),
                  child: Text(subject.name!.substring(0,1),style:const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
                ),
                Text(subject.name??"",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                Text("Total Tests: ${subject.noQuiz}",style: TextStyle(color: Colors.black38),),
                InkWell(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Colors.orangeAccent, Colors.deepOrange],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15), // optional for rounded corners
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text("START QUIZ",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                    ),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}
class MyExamlistExamstudypractice extends StatelessWidget {
  final ExamCategory exam;
  const MyExamlistExamstudypractice({super.key,required this.exam});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        width: MyConstants.sw*.3,
        height: MyConstants.sh*.12,
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
        child: SizedBox(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.network(exam.subCategoryImage!),
              SizedBox(
                width: MyConstants.sw*.3,
                  child: Text(exam.subCategoryName!,style:const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),textAlign: TextAlign.center,)),
            ],
          ),
        ),
      ),
    );
  }
}
class MySubjectStudyExamstudypractice extends StatelessWidget {
  final StudyExamstudypracticeSubject subject;
  final VoidCallback onClick;
  const MySubjectStudyExamstudypractice({super.key, required this.subject,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.orangeAccent, Colors.deepOrange],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15), // optional for rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CircleAvatar(
                backgroundColor: Utility.getRandomMatchingColor(),
                child: Text(subject.typeName!.substring(0,1),style:const TextStyle(color: Colors.white,fontSize: 25,fontWeight: FontWeight.bold),),
              ),
              Column(
                children: [
                  Text(subject.typeName!,style: const TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                  Text("${subject.topicCount} topics  ${subject.totalConceptCount} concepts  ${subject.totalVideoCount} videos")
                ],
              ),
              const Icon(CupertinoIcons.right_chevron,color: Colors.white,)
            ],
          ),
        ),
      ),
    );
  }
}
class MyBuyPlans extends StatelessWidget {
  final VoidCallback onClick;
  final bool isSelected;
  final Plans plan;
  const MyBuyPlans({super.key,required this.plan,required this.isSelected,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(4),
    child: InkWell(
      onTap: onClick,
      child: Container(
        height: MyConstants.sh*.2,
        decoration: BoxDecoration(
        color:isSelected?Colors.cyanAccent[100]:Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.lightBlue, // Replace with your desired border color
          width: 2, // Adjust the border width as needed
        ),
          boxShadow: [
      BoxShadow(
      color: Colors.grey.withOpacity(0.5),
        spreadRadius: 2,
        blurRadius: 7,
        offset: Offset(0, 3), // changes position of shadow
      ),]
      ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: MyConstants.sh*.15,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                Visibility(
                  visible:  (int.parse(plan.duration!)~/30)>1? true:false,
                  child: Container(
                    decoration: BoxDecoration(
                      color: CupertinoColors.activeBlue,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child:const Padding(
                      padding:  EdgeInsets.symmetric(horizontal: 16.0,vertical: 2),
                      child:  Text("Recommended",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(plan.planName!,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.black),),
                  Row(children: [
                    Text("₹ ${plan.price!}",style: const TextStyle(color: Colors.orange,decoration: TextDecoration.lineThrough,fontWeight: FontWeight.bold),),
                    SizedBox(width:4,),
                    Text("Pay ₹ ${plan.offerPrice} for ${int.parse(plan.duration!)~/30} months",style: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),)
              ],),
                  Text("You save ₹ ${int.parse(plan.price!)-int.parse(plan.offerPrice!)}"),
                    (int.parse(plan.duration!)~/30)>1
                        ? Text("₹ ${int.parse(plan.offerPrice!)~/(int.parse(plan.duration!)~/30)} / month",style: TextStyle(color: CupertinoColors.activeOrange,fontWeight: FontWeight.bold),)
                        : const SizedBox.shrink()
              ],
              )
              ],),
            ),
            Container(
              height: MyConstants.sh*.04,
              decoration: BoxDecoration(
                borderRadius:const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                color: isSelected?Colors.white:Colors.blue[100],
                border: Border.all(
                  color: Colors.lightBlue, // Replace with your desired border color
                  width: 1, // Adjust the border width as needed
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Discount applied",style: TextStyle(fontWeight: FontWeight.bold,color: MyColors.blue),),
                  SizedBox(width: 4,),
                  Icon(Icons.play_circle_fill,color: MyColors.blue,)
                ],
              ),
            ),
          ],
        ),
      ),
    )
    );
  }
}
class MyCourseBuyplan extends StatelessWidget {
  final CourseBuyplan course;
  const MyCourseBuyplan({super.key,required this.course});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.all(8),
     child: Container(
       // height: MyConstants.sh*.08,
       width: MyConstants.sw*.28 ,
       decoration: BoxDecoration(
           color: Colors.blue[50],
           borderRadius: BorderRadius.circular(10),
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.5),
               spreadRadius: 2,
               blurRadius: 7,
               offset: Offset(0, 3), // changes position of shadow
             ),]
       ),
       child: Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SizedBox(height: MyConstants.sh*.03,width: MyConstants.sw*.06,
             child:Image.network(course.coursesIcon!),),
             Text("${course.testCount}+",style: const TextStyle(fontWeight: FontWeight.bold),),
             Text(course.coursesName!,)
           ],
         ),
       ),
    ),
    );
  }
}

class MyStudentreview extends StatelessWidget {
  final StudentReview studentreview;
  const MyStudentreview({super.key,required this.studentreview});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(
        child:Stack(
          alignment: AlignmentDirectional.topCenter,
          children: [
            SizedBox(
              height: MyConstants.sh*.25,
                child: Image.asset("assets/images/speech_bubble.png")),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(22.0),
                  child: SizedBox(
                      height: MyConstants.sh*.15,
                      child: Text(studentreview.reviewDetails!)),
                ),
                SizedBox(height: MyConstants.sh*.03,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StarRating(
                        size: 25.0,
                        rating: double.parse(studentreview.rating!),
                        color: Colors.yellow,
                        borderColor: Colors.grey,
                        starCount: 5,
                      ),
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: NetworkImage(studentreview.image!),
                          ),
                          const SizedBox(width: 5,),
                          Text(studentreview.studentName!)
                        ],
                      )
                    ],),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
class MySubjectsExamstudypractice extends StatelessWidget {
  final SubjectPractice subject;
  final VoidCallback onClick;
  const MySubjectsExamstudypractice({super.key,required this.subject,required this.onClick});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClick,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Container(
          decoration: BoxDecoration(
            color: MyColors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(children: [
                     Padding(
                       padding: const EdgeInsets.all(8.0),
                       child: CircleAvatar(backgroundColor: Utility.getRandomMatchingColor(),child: Text(subject.subjectName!.substring(0,1),style:const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),)),
                     ),
                     Column(children: [
                       Text(subject.subjectName!,style: const TextStyle(fontWeight: FontWeight.bold),),
                       Text("${subject.givenQnCount}/${subject.count} Questions")
                     ],),
                   ],),
                    const Row(children: [
                      Icon(Icons.play_arrow,color: Colors.blue,),
                      Text("Attempt",style: TextStyle(color: Colors.blue),)
                    ],),
                  ],
                ),
                LinearProgressIndicator(color: Colors.blue,value: subject.givenQnCount!=0?(subject.givenQnCount! * 100) / subject.count!/100:0,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
