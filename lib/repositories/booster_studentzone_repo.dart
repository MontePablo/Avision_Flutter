

import '../network/network_api_service.dart';
import '../network/urls.dart';

class BoosterStudentzoneRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.boosterStudentZone);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}