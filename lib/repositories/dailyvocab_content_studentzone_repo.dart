

import '../network/network_api_service.dart';
import '../network/urls.dart';

class DailyVocabContentStudentzoneRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.dailyVocabContentStudentZone, data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}