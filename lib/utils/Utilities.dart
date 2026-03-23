import 'dart:ffi';
import 'dart:io';
import 'dart:math';

import 'package:another_flushbar/flushbar.dart';
import 'package:another_flushbar/flushbar_route.dart';
import 'package:avision/data_models/quizAppbarQuizlistResponse.dart';
import 'package:avision/data_models/quizlistGkcaResponse.dart';
import 'package:avision/utils/constants.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:uuid/uuid.dart';
import 'package:path/path.dart' as path;

import '../data_models/multiApiTwoHomeResponse.dart';
import '../data_models/quiz.dart';


class Utility {
  static toastMsg(String msg) {
    Fluttertoast.showToast(msg: msg);
  }

  static flushbarPositiveMsg(String msg, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(15),
          message: msg,
          borderRadius: BorderRadius.circular(20),
          title: "Success!",
          backgroundColor: Colors.green,
          titleColor: Colors.white,
          positionOffset: 20,
          icon: Icon(
            Icons.add_alert_rounded,
            size: 28,
            color: Colors.white,
          ),
          duration: Duration(seconds: 3),
        )..show(context));
  }

  static flushbarErrorMsg(String msg, BuildContext context) {
    showFlushbar(
        context: context,
        flushbar: Flushbar(
          forwardAnimationCurve: Curves.decelerate,
          reverseAnimationCurve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          padding: EdgeInsets.all(15),
          borderRadius: BorderRadius.circular(20),
          message: msg,
          backgroundColor: Colors.red,
          title: "Oups!",
          titleColor: Colors.white,
          flushbarPosition: FlushbarPosition.TOP,
          icon: Icon(
            Icons.error,
            size: 28,
            color: Colors.white,
          ),
          positionOffset: 20,
          duration: Duration(seconds: 3),
        )..show(context));
  }

  static snackBarMsg(String msg, BuildContext context) {
    return ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(msg)));
  }

  static focusChange(BuildContext context, FocusNode current, FocusNode next) {
    current.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static String formatDateRange(String fromDateStr, String toDateStr) {
    // Parse the date strings into DateTime objects
    DateTime fromDate = DateTime.parse(fromDateStr);
    DateTime toDate = DateTime.parse(toDateStr);

    // Format the dates
    DateFormat dateFormat = DateFormat.yMMMMd();
    String formattedFromDate = dateFormat.format(fromDate);
    String formattedToDate = dateFormat.format(toDate);

    // Extract the day and month from the formatted dates
    String fromDayMonth = formattedFromDate.split(' ')[0];
    String toDayMonth = formattedToDate.split(' ')[0];
    String monthAbbreviation = formattedToDate.split(' ')[1];

    // Combine the formatted strings
    String formattedDateRange =
        '$fromDayMonth to $toDayMonth $monthAbbreviation';

    return formattedDateRange;
  }

  String formatDate(String dateString) {
    // 12-4-2024 to 12 Jun 2024 convert
    // Parse the input date string
    DateTime date = DateTime.parse(dateString);

    // Format the date to 'dd MMM yyyy'
    String formattedDate = DateFormat('dd MMM yyyy').format(date);

    return formattedDate;
  }

  Future<void> downloadFile(String url, BuildContext context) async {
    Dio dio = Dio();
    try {
      // Get the app-specific external directory for saving files
      Directory? dir = await getExternalFilesDir();

      // Extract the filename from the URL
      String fileName = path.basename(url);

      // If the filename is empty, generate a random name with extension
      if (fileName.isEmpty) {
        String fileExtension = path.extension(url);
        fileName = "${const Uuid().v4()}$fileExtension";
      }

      // Create the full path to save the file
      String savePath = "${dir!.path}/$fileName";

      // Show loading dialog
      showLoadingDialog(context, "downloading...");

      // Start the download
      await dio.download(url, savePath).whenComplete(() async {
        closeLoadingDialog(context); // Close the loading dialog
        print("File downloaded to: $savePath");

        // Open the file once the download is complete
        final result = await OpenFilex.open(savePath);
        if (result.type == ResultType.noAppToOpen) {
          flushbarErrorMsg("No application found to open the file", context);
        }
      }).catchError((error) {
        closeLoadingDialog(context);
        // Handle the error
        if (error is DioException) {
          // Handle Dio specific errors here
          print("Download failed: ${error.message}");
          flushbarErrorMsg("Download failed: ${error.message}", context);
        } else {
          // Handle other errors
          print("Unexpected error: $error");
          flushbarErrorMsg("Unexpected error: $error", context);
        }
      });

      flushbarPositiveMsg("File downloaded", context);
    } catch (e) {
      closeLoadingDialog(context);
      flushbarErrorMsg("Error downloading file: $e", context);
    }
  }

// Helper function to get app-specific external directory
  Future<Directory?> getExternalFilesDir() async {
    return await getExternalStorageDirectory();
  }
  static showLoadingDialog(BuildContext context, String text) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              height: MyConstants.sh*.05,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SpinKitCircle(
                    color: Theme.of(context).primaryColor,
                    size: 50.0,
                  ),
                  const SizedBox(width: 16.0),
                  Text(text),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
  static closeLoadingDialog(BuildContext context){
    Navigator.of(context).pop();
  }


//   static List<String> getListOfCalculatedDate(int days) {
//     List<String> dateList = [];
//
//     if (days >= 0) {
//       for (int i = 0; i < days; i++) {
//         String calculatedDate = getCalculatedDate(i, 'yyyy-MM-dd');
//         dateList.add(calculatedDate);
//       }
//     } else {
//       for (int i = 0; i >= days; i--) {
//         String calculatedDate = getCalculatedDate(i, 'yyyy-MM-dd');
//         dateList.add(calculatedDate);
//       }
//     }
//
//     return dateList;
//   }
// Function to get a list of calculated dates, excluding Sundays

  static List<String> getListOfCalculatedDate(int days) {
    List<String> dateList = [];

    if (days >= 0) {
      for (int i = 0; i < days; i++) {
        String calculatedDate = getCalculatedDate(i, 'yyyy-MM-dd');

        // Check if the calculated date is a Sunday
        DateTime calculatedDateTime = DateTime.now().add(Duration(days: i));
        if (calculatedDateTime.weekday != DateTime.sunday) {
          dateList.add(calculatedDate);  // Add only if not a Sunday
        }
      }
    } else {
      for (int i = 0; i >= days; i--) {
        String calculatedDate = getCalculatedDate(i, 'yyyy-MM-dd');

        // Check if the calculated date is a Sunday
        DateTime calculatedDateTime = DateTime.now().add(Duration(days: i));
        if (calculatedDateTime.weekday != DateTime.sunday) {
          dateList.add(calculatedDate);  // Add only if not a Sunday
        }
      }
    }

    return dateList;
  }


// Function to calculate date based on a count and format
  static String getCalculatedDate(int count, String dateFormat) {
    DateTime currentDate = DateTime.now();
    DateTime calculatedDate = currentDate.add(Duration(days: count));

    // Using DateFormat from intl package to format the date
    DateFormat formatter = DateFormat(dateFormat);
    return formatter.format(calculatedDate);
  }

// Function to get the month of the year based on input integer
  static String getMonthOfYear(int month) {
    switch (month) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jun';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Invalid Month';
    }
  }
  static List<String> splitDate(String date) {
    // Split the date string using '-' as the delimiter
    List<String> dateParts = date.split('-');
    // Return the list containing [year, month, day]
    return dateParts;
  }
  static List<String> splitDateWithMonthName(String date) {
    List<String> dateParts = splitDate(date);
    int monthNumber = int.parse(dateParts[1]);
    String monthName = getMonthOfYear(monthNumber);
    return [dateParts[0], monthName, dateParts[2]]; // [year, month name, day]
  }






  static QuizIntroDetail dailydoseQuizToQuizDetailConvert(DailyDoseQuiz quiz){
    QuizIntroDetail data=QuizIntroDetail();
    data.totalMarks= quiz.totalMarks;
    data.totalTime=quiz.totalTime;
    data.totalQuestion=quiz.totalQuestion;
    data.quizName=quiz.quizName;
    data.quizId=quiz.quizId;
    data.date=quiz.createdDate;
    data.status=quiz.status;
    return data;
  }
  static QuizIntroDetail feedPostQuizToQuizDetailConvert(FeedPostQuiz quiz){
    QuizIntroDetail data=QuizIntroDetail();
    data.totalMarks= int.parse(quiz.totQus!);
    data.totalTime=quiz.totTime!.length<=2?int.parse(quiz.totTime!)*60:int.parse(quiz.totTime!);
    data.totalQuestion=quiz.totQus;
    data.quizName=quiz.quizName;
    data.quizId=quiz.quizId;
    data.status=1;
    return data;
  }
  static QuizIntroDetail appbarQuizToQuizDetailConvert(AppbarQuiz quiz){
    QuizIntroDetail data=QuizIntroDetail();
    data.totalMarks=int.parse(quiz.totQus??"0");
    data.totalTime=quiz.totTime!.length<=2?int.parse(quiz.totTime!)*60:int.parse(quiz.totTime!);
    data.totalQuestion=quiz.totQus;
    data.quizName=quiz.quizName;
    data.quizId=quiz.quizId;
    data.status=1;
    return data;
  }
  static QuizIntroDetail gkcaQuizToQuizDetailConvert(GkcaQuiz quiz){
    QuizIntroDetail data=QuizIntroDetail();
    data.totalMarks=int.parse(quiz.totQus??"0");
    data.totalTime=quiz.totTime!.length<=2?int.parse(quiz.totTime!)*60:int.parse(quiz.totTime!);
    data.totalQuestion=quiz.totQus;
    data.quizName=quiz.quizName;
    data.quizId=quiz.quizId;
    data.status=1;
    return data;
  }


  // Color getRandomMatchingColor({Color? baseColor = Colors.blue}) {
  //   Random _random = Random();
  //
  //   // Convert baseColor to HSL to adjust hue
  //   final hslBaseColor = HSLColor.fromColor(baseColor!);
  //
  //   // Generate a slight variation in hue for matching color (±15 degrees)
  //   final double hueVariation = (_random.nextDouble() * 30) - 15; // Hue variation between -15 and +15
  //   final double newHue = (hslBaseColor.hue + hueVariation) % 360;
  //
  //   // Keep saturation and lightness relatively close to the base color for harmony
  //   final double newSaturation = hslBaseColor.saturation + (_random.nextDouble() * 0.1 - 0.05); // ±5% saturation
  //   final double newLightness = hslBaseColor.lightness + (_random.nextDouble() * 0.1 - 0.05); // ±5% lightness
  //
  //   // Return the new color by adjusting hue, saturation, and lightness
  //   return HSLColor.fromAHSL(
  //     hslBaseColor.alpha,
  //     newHue.clamp(0.0, 360.0),
  //     newSaturation.clamp(0.0, 1.0),
  //     newLightness.clamp(0.0, 1.0),
  //   ).toColor();
  // }

  // Function to get a random matching color from the palette
  static Color getRandomMatchingColor() {
    final Random _random = Random();

    // Define a few color palettes (each list represents a harmonious palette)
    final List<List<Color>> palettes = [
      [Colors.blue, Colors.orange, Colors.green, Colors.red],
      [Colors.purple, Colors.cyan, Colors.teal, Colors.amber],
      [Colors.pink, Colors.indigo, Colors.lime, Colors.deepOrange],
      [Colors.brown, Colors.lightGreen, Colors.deepPurple, Colors.yellow],
    ];
    final List<Color> palette = palettes[_random.nextInt(palettes.length)];

    // Return a random color from the selected palette
    return palette[_random.nextInt(palette.length)];
  }

  static void showAlertDialog(BuildContext context,Widget widget){
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor:
            Colors.transparent, // Set background color to transparent
            contentPadding: EdgeInsets.zero,
            elevation: 0,
            content: widget,
          );
        });
  }
  static void showCustomDialog(BuildContext context,Widget widget){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return widget;
      },
    );
  }
}
