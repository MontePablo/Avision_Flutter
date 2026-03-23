


import '../../../network/network_api_service.dart';
import '../../../network/urls.dart';

class DailydoseQuizQuestionsRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.dailydoseQuizQuestions, data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}
class AppbarQuizQuizQuestionsRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.quizAppbarQuizQuestions, data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}