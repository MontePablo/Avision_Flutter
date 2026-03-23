import 'package:avision/custom_widgets/my_custom_widgets.dart';
import 'package:avision/data_models/courseListMainpageRequest.dart';
import 'package:avision/pages/feed.dart';
import 'package:avision/pages/home.dart';
import 'package:avision/pages/live_course.dart';
import 'package:avision/pages/test_series_page.dart';
import 'package:avision/utils/Utilities.dart';
import 'package:avision/utils/colors.dart';
import 'package:avision/utils/constants.dart';
import 'package:avision/viewmodels/mainpage_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../storage/shared_preferences.dart';
import '../utils/routes.dart';

void main() {
  runApp(MainPage());
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late MainPageViewModel mainPageViewModel;

  int currentIndex = 0;
  List<Widget> fragList = [
    const Home(),
    const TestSeriesPage(),
    const LiveCourse(),
    const Feed(),
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    mainPageViewModel = Provider.of<MainPageViewModel>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    MySharedPreferences().getUserDetail().then((value) {
      mainPageViewModel.fetchCourseList(
        context,
        CourseListHomepageRequest(userId: value?.userId ?? ""),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainPageViewModel>(
      builder: (BuildContext context, MainPageViewModel value, Widget? child) {
        if (mainPageViewModel.dataCourseList != null) {
          for (final course in mainPageViewModel.dataCourseList!.courseList!) {
            if (course.priority == "1") {
              MySharedPreferences().saveCourseDetail(course);
            }
          }
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.blue,
            title: Image.asset(
              "assets/images/avision_app_bar.png",
              scale: 2,
            ),
            actions:  [
              // Icon(
              //   Icons.more_vert,
              //   color: Colors.white,
              //   size: 36,
              // )
              InkWell(
                onTap: (){Navigator.pushNamed(context, MyRoutes.buyPlanPage);},
                child: Container(
                  decoration: BoxDecoration(
                   color: MyColors.white,
                   borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0,vertical: 6),
                    child: Row(mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Buy",style: TextStyle(color: Colors.black),),
                        Text("Plan",style: TextStyle(color: Colors.deepOrange),)
                      ],

                    ),
                  ),
                ),
              ),
              SizedBox(width: MyConstants.sw*.03,)
            ],
            iconTheme: const IconThemeData(
                color: Colors.white), // Change the color here
          ),

          drawer: Drawer(
            backgroundColor: Colors.blue,
            child: Container(
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      color: MyColors.blue,
                      height: MyConstants.sh * .15,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: MyConstants.sh * .09,
                              width: MyConstants.sw * .21,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white),
                              child: Image.asset(
                                "assets/images/avatar.png",
                                scale: 5.5,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Customer Name",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13)),
                                Text("test@gmail.com",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 10)),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MyConstants.sh * .01,
                    ),
                    MyDrawerItem(
                        icon: CupertinoIcons.square_favorites,
                        title: "Change Exam",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: Icons.language,
                        title: "Change Language",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: Icons.sticky_note_2,
                        title: "Free Test Series",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: CupertinoIcons.camera,
                        title: "Recorded Videos",
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.videolistDrawerRoute,arguments: [MyEnumConstants.RECORDED_VIDEO_DRAWER]);
                        }),
                    MyDrawerItem(
                        icon: CupertinoIcons.camera_on_rectangle,
                        title: "Combined Recorded Videos",
                        onPressed: () {
                          Navigator.pushNamed(
                              context, MyRoutes.videolistDrawerRoute,arguments: [MyEnumConstants.COMBINED_RECORDED_VIDEO_DRAWER]);
                        }),
                    MyDrawerItem(
                        icon: Icons.shopping_cart,
                        title: "Buy Plan",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: CupertinoIcons.purchased,
                        title: "My Purchases",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: CupertinoIcons.shopping_cart,
                        title: "Buy Study Materials",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: CupertinoIcons.map,
                        title: "Center",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: Icons.details,
                        title: "About Us",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: Icons.tips_and_updates,
                        title: "Current Updates",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: Icons.system_update,
                        title: "Weekly Updates",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: Icons.watch_later,
                        title: "Class Schedule",
                        onPressed: () {}),
                    MyDrawerItem(
                        icon: Icons.star_rate,
                        title: "Rate Us",
                        onPressed: () {}),
                    SizedBox(
                      height: MyConstants.sh * .04,
                    ),
                    Text(
                      "Connect with Us",
                      style: TextStyle(color: Colors.black54, fontSize: 15),
                    ),
                    SizedBox(
                      height: MyConstants.sh * .01,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/fb.png",
                          scale: 1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/images/twitter.png",
                          scale: 1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/images/youtube.png",
                          scale: 1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/images/insta.png",
                          scale: 1,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Image.asset(
                          "assets/images/linkedin.png",
                          scale: 1,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MyConstants.sh * .02,
                    ),
                    MyDrawerItem(
                        icon: Icons.logout,
                        title: "Log Out",
                        onPressed: () {
                          logout();
                        }),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              currentIndex = index;
              reloadUi();
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: MyColors.blue,
            // backgroundColor: Colors.green,
            showSelectedLabels: true,
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  label: "Home",
                  icon: Image.asset(
                    "assets/images/icon_home.png",
                    color: currentIndex == 0 ? MyColors.blue : Colors.grey,
                    scale: 1.3,
                  )),
              BottomNavigationBarItem(
                  label: "Test Series",
                  icon: Image.asset("assets/images/icon_test.png",
                      color: currentIndex == 1 ? MyColors.blue : Colors.grey,
                      scale: 1.3)),
              BottomNavigationBarItem(
                  label: "Live Course",
                  icon: Image.asset("assets/images/icon_livecourse.PNG",
                      color: currentIndex == 2 ? MyColors.blue : Colors.grey,
                      scale: 1.3)),
              BottomNavigationBarItem(
                  label: "Feed",
                  icon: Image.asset("assets/images/icon_feed.PNG",
                      color: currentIndex == 3 ? MyColors.blue : Colors.grey,
                      scale: 1.3))
            ],
          ),
          // body: IndexedStack(
          //   index: currentIndex,
          //   children: fragList,
          // )
          body: fragList[currentIndex],
        );
      },
    );
  }

  void reloadUi() {
    setState(() {});
  }

  void logout() {
    MySharedPreferences().removeAll();
    Navigator.pushReplacementNamed(context, MyRoutes.loginRoute);
  }
}
