import 'dart:ui';

import 'package:avision/database/quizDatabase.dart';
import 'package:avision/pages/assignment_chapter_studentzone_page.dart';
import 'package:avision/pages/assignment_subject_studentzone_page.dart';
import 'package:avision/pages/booster_magazine_ga_page.dart';
import 'package:avision/pages/buyplan_page.dart';
import 'package:avision/pages/currentaffair_gkca_detail_page.dart';
import 'package:avision/pages/daily_assignment_page.dart';
import 'package:avision/pages/dailyvocab_studentzone_page.dart';
import 'package:avision/pages/datelist_news_appbar_page.dart';
import 'package:avision/pages/dca_page.dart';
import 'package:avision/pages/examinfo__examstudypractice_page.dart';
import 'package:avision/pages/gkca_appbar_page.dart';
import 'package:avision/pages/main_page.dart';
import 'package:avision/pages/login_page.dart';
import 'package:avision/pages/news_appbar_page.dart';
import 'package:avision/pages/news_detail_news_appbar_page.dart';
import 'package:avision/pages/newslist_news_appbar_page.dart';
import 'package:avision/pages/practice_examstudypractice_page.dart';
import 'package:avision/pages/prevyearpaper_subjects_page.dart';
import 'package:avision/pages/quiz_appbar_quizlist_page.dart';
import 'package:avision/pages/quiz_appbar_subjectlist_page.dart';
import 'package:avision/pages/study_examstudypractice_page.dart';
import 'package:avision/quiz/datamodels/questionResponse.dart';

import 'package:avision/quiz/pages/quiz_correctAns_page.dart';
import 'package:avision/quiz/pages/quiz_result_page.dart';
import 'package:avision/quiz/pages/quiz_test_page.dart';
import 'package:avision/pages/videolist_drawer_page.dart';
import 'package:avision/pages/splash_screen.dart';
import 'package:avision/pages/videos_appbar_page.dart';
import 'package:avision/pages/webview_page.dart';
import 'package:avision/pages/youtube_player_page.dart';
import 'package:avision/storage/shared_preferences.dart';
import 'package:avision/utils/constants.dart';
import 'package:avision/utils/routes.dart';
import 'package:avision/viewmodels/assignment_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/auth_viewmodel.dart';
import 'package:avision/viewmodels/buyplan_viewmodel.dart';
import 'package:avision/viewmodels/dailyassignment_home_viewmodel.dart';
import 'package:avision/viewmodels/dailyvocab_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/dca_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/exam_examstudypractice_viewmodel.dart';
import 'package:avision/viewmodels/feed_viewmodel.dart';
import 'package:avision/viewmodels/gkca_appbar_viewmodel.dart';
import 'package:avision/viewmodels/home_viewmodel.dart';
import 'package:avision/viewmodels/livecourse_viewmodel.dart';
import 'package:avision/viewmodels/mainpage_viewmodel.dart';
import 'package:avision/viewmodels/news_appbar_viewmodel.dart';
import 'package:avision/viewmodels/practice_examstudypractice_viewmodel.dart';
import 'package:avision/viewmodels/prevyearpaper_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/quiz_appbar_viewmodel.dart';
import 'package:avision/viewmodels/quiz_viewmodel.dart';
import 'package:avision/viewmodels/recordedvideos_drawar_viewmodel.dart';
import 'package:avision/viewmodels/magazineGaBooster_studentzone_viewmodel.dart';
import 'package:avision/viewmodels/study_examstudypractice_viewmodel.dart';
import 'package:avision/viewmodels/testseries_viewmodel.dart';
import 'package:avision/viewmodels/videos_appbar_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  DartPluginRegistrant.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive and Flutter Hive
  await QuizDatabase().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    MyConstants(context);
    MySharedPreferences().init();


    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => LiveCourseViewModel()),
          ChangeNotifierProvider(create: (_) => TestSeriesViewModel()),
          ChangeNotifierProvider(create: (_) => MainPageViewModel()),
          ChangeNotifierProvider(create: (_) => FeedViewModel()),
          ChangeNotifierProvider(create: (_) => RecordedVideosDrawerViewModel()),
          ChangeNotifierProvider(create: (_) => VideosAppbarViewModel()),
          ChangeNotifierProvider(create: (_) => GkcaAppbarViewmodel()),
          ChangeNotifierProvider(create: (_) => NewsAppbarViewmodel()),
          ChangeNotifierProvider(create: (_) => MagazineGaBoosterStudentzoneViewmodel()),
          ChangeNotifierProvider(create: (_) => DcaStudentzoneViewmodel()),
          ChangeNotifierProvider(create: (_) => DailyvocabStudentzoneViewmodel()),
          ChangeNotifierProvider(create: (_) => AssignmentStudentzoneViewmodel()),
          ChangeNotifierProvider(create: (_) => PrevyearpaperStudentzoneViewmodel()),
          ChangeNotifierProvider(create: (_) => QuizViewmodel()),
          ChangeNotifierProvider(create: (_) => DailyassignmentHomeViewmodel()),
          ChangeNotifierProvider(create: (_) => QuizAppbarViewmodel()),
          ChangeNotifierProvider(create: (_) => BuyplanViewmodel()),
          ChangeNotifierProvider(create: (_) => ExamExamstudypracticeViewmodel()),
          ChangeNotifierProvider(create: (_) => StudyExamstudypracticeViewmodel()),
          ChangeNotifierProvider(create: (_) => PracticeExamstudypracticeViewmodel()),

        ],
        child: MaterialApp(
              theme: ThemeData(
              primarySwatch: Colors.blue,
                fontFamily: GoogleFonts.lato().fontFamily,
                textTheme: GoogleFonts.latoTextTheme(),
              ),
              debugShowCheckedModeBanner: false,
              initialRoute: "/",
              routes: {
              "/": (context) => const SplashScreen(),
              // MyRoutes.homeRoute: (context) => HomePage(),
              MyRoutes.loginRoute: (context) => LoginPage(),

              },
              onGenerateRoute: (settings) {
                dynamic args=settings.arguments;
                print(settings.name);
                print(args??"args=null");

                switch (settings.name) {
                  case MyRoutes.homeRoute:
                    return PageTransition(child: const MainPage(), type: PageTransitionType.rightToLeft);
                  // case MyRoutes.loginRoute:
                  //   return PageTransition(child: LoginPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.splashRoute:
                    return PageTransition(child: const SplashScreen(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.youtubePlayerRoute:
                    return PageTransition(child:  YoutubePlayerPage(data: args,), type: PageTransitionType.rightToLeft);

                  case MyRoutes.videolistDrawerRoute:
                    return PageTransition(child:  VideolistPage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.videosAppBarRoute:
                    return PageTransition(child: const VideosAppBarPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.gkcaRoute:
                    return PageTransition(child: const GkcaAppbarPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.currentAffairGkcaDetail:
                    return PageTransition(child:  CurrentAffairGkcaDetailPage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.newsAppbar:
                    return PageTransition(child:  const NewsAppbarPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.newsDetailNewsAppbar:
                  return PageTransition(child:  NewsDetailNewsAppbarPage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.boosterMagazineGaPage:
                    return PageTransition(child:  BoosterMagazineGaPage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.webviewPage:
                    return PageTransition(child:  WebViewPage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.dcaStudentzonePage:
                    return PageTransition(child:  const DcaStudentzonePage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.dailyVocabStudentzonePage:
                    return PageTransition(child:  const DailyVocabStudentzonePage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.assignmentSubjectStudentzonePage:
                    return PageTransition(child:  const AssignmentSubjectStudentzonePage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.assignmentChapterStudentzonePage:
                    return PageTransition(child: AssignmentChapterStudentzonePage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.prevyearpaperSubjectsStudentzonePage:
                    return PageTransition(child: const PrevyearpaperSubjectsPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.prevyearpaperTestsStudentzonePage:
                    return PageTransition(child: AssignmentChapterStudentzonePage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.quizTestPage:
                    return PageTransition(child: QuizTestPage(data: args), type: PageTransitionType.rightToLeft);
                  case MyRoutes.quizResultPage:
                    return PageTransition(child: QuizResultPage(data: args), type: PageTransitionType.rightToLeft);
                  case MyRoutes.quizCorrectAnsPage:
                    return PageTransition(child: QuizCorrectAnsPage(data: args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.dailyAssignmentPage:
                    return PageTransition(child: const DailyAssignmentPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.quizAppbarSubjectlistPage:
                    return PageTransition(child: const QuizAppbarSubjectlistPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.quizAppbarQuizlistPage:
                    return PageTransition(child: QuizAppbarQuizlistPage(data:args,), type: PageTransitionType.rightToLeft);
                  case MyRoutes.buyPlanPage:
                    return PageTransition(child: const BuyplanPage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.examInfoPage:
                    return PageTransition(child: const ExaminfoExamstudypracticePage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.studyPage:
                    return PageTransition(child: const StudyExamstudypracticePage(), type: PageTransitionType.rightToLeft);
                  case MyRoutes.practicePage:
                    return PageTransition(child: const PracticeExamstudypracticePage(), type: PageTransitionType.rightToLeft);

                  default:
                    print('Unknown route: ${settings.name}');
                    return null;
                }
              },
        ),

    );

  }


}
