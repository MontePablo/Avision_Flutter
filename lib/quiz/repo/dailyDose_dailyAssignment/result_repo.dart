


import '../../../network/network_api_service.dart';
import '../../../network/urls.dart';

class DailydoseResultRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.dailydoseResult, data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}