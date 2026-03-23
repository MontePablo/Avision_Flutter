

import '../network/network_api_service.dart';
import '../network/urls.dart';

class CourseListMainPageRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.courseList , data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}