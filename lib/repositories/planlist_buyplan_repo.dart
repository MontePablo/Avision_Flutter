

import '../network/network_api_service.dart';
import '../network/urls.dart';

class PlanlistBuyplanRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.planlistBuyplan);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}