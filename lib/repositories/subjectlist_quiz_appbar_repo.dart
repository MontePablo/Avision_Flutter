

import '../network/network_api_service.dart';
import '../network/urls.dart';

class SubjectlistQuizAppbarRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.subjectlistQuizAppbar);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}