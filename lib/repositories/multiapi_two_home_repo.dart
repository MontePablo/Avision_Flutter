

import '../network/network_api_service.dart';
import '../network/urls.dart';

class MultiApiTwoHomeRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postMultiPartApi(AppUrl.multiApiTwoHome , data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}