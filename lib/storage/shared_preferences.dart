import 'dart:ui';
import 'dart:convert';
import 'package:avision/data_models/courseListMainpageResponse.dart';
import 'package:avision/data_models/loginResponse.dart';
import 'package:avision/data_models/subjectwisevideoVideosAppBarResponse.dart';
import 'package:avision/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MySharedPreferences {
  static final MySharedPreferences _instance = MySharedPreferences._internal();
  late SharedPreferences _prefs;

  factory MySharedPreferences() {
    return _instance;
  }

  MySharedPreferences._internal();

  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future<bool> saveString(String key, String value) {
    return _prefs.setString(key, value);
  }

  Future<String?> getString(String key) async {
    return _prefs.getString(key);
  }

  void deleteData(String key) {
    _prefs.remove(key);
  }

  Future<void> saveUserDetail(LoginResponse data) async {
    bool isSaved=await saveString(MyEnumConstants.USER_DETAILS.toString(), jsonEncode(data.toJson()));
    print("LOGG"+" userDetails while saving:"+ jsonEncode(data));
    print("LOGG"+ " isSaved: "+ isSaved.toString());
  }

  Future<void> saveZZ(SubjectWiseVideoVideosAppBarResponsse data) async {
    bool isSaved=await saveString("ZZ", jsonEncode(data.toJson()));
    print("LOGG"+" subjectwisevideo while saving:"+ jsonEncode(data));
    print("LOGG"+ " subjectwise video isSaved: "+ isSaved.toString());
  }
  Future<SubjectWiseVideoVideosAppBarResponsse?> getZZ() async {
    var data =await getString("ZZ");
    if(data==null) {
      return null;
    }
    return SubjectWiseVideoVideosAppBarResponsse.fromJson(jsonDecode(data.toString()));
  }
  Future<void> saveCourseDetail(Course data) async {
    bool isSaved=await saveString(MyEnumConstants.COURSE_DETAILS.toString(), jsonEncode(data.toJson()));
    print("LOGG"+" courseDetail while saving:"+ jsonEncode(data));
    print("LOGG"+ " isSaved: "+ isSaved.toString());
  }
  Future<void> removeAll() async{
    _prefs.clear();
  }

  Future<LoginResponse?> getUserDetail() async {
    var data =await getString(MyEnumConstants.USER_DETAILS.toString());
    if(data==null) {
      return null;
    }
    return LoginResponse.fromJson(jsonDecode(data.toString()));
  }
  Future<Course?> getCourseDetail() async {
    var data =await getString(MyEnumConstants.COURSE_DETAILS.toString());
    if(data==null) {
      return null;
    }
    return Course.fromJson(jsonDecode(data.toString()));
  }
}