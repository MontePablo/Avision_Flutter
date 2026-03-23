

import '../network/network_api_service.dart';
import '../network/urls.dart';

class DcaStudentzoneRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.currentAffairsDca);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}