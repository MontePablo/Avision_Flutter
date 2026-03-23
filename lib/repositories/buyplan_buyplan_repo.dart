

import '../network/network_api_service.dart';
import '../network/urls.dart';

class BuyplanBuyplanRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch(dynamic data) async{
    try{
      dynamic response= await apiServices.postApi(AppUrl.buyplanBuyplan,data);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}