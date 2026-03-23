import 'dart:convert';

import 'package:avision/repositories/login_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../data_models/loginRequest.dart';
import '../data_models/loginResponse.dart';
import '../utils/Utilities.dart';

class AuthViewModel{
  final loginRepo= LoginRepo();
  Future<LoginResponse?> login(LoginRequest data,BuildContext context) async{
    var dataObj;
    await loginRepo.login(data.toJson())
        .then((value) {
      if(value!=null) {
        dataObj = LoginResponse.fromJson(value);
      }
      if(dataObj.statusCode!=200.toString()){
        Utility.flushbarErrorMsg(dataObj.message.toString(), context);
      }
    }).onError((error, stackTrace) {
      if(kDebugMode) {
        print("$error\n$stackTrace");
      }
      Utility.flushbarErrorMsg("$error", context);
    });
    return dataObj;
  }
}