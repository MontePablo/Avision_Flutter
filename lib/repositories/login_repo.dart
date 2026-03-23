

import '../network/network_api_service.dart';
import '../network/urls.dart';

class LoginRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> login(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.login, data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}