

import '../network/network_api_service.dart';
import '../network/urls.dart';

class LastdateNewsListNewsAppbarRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.lastdateNewslistNewsAppbar);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}