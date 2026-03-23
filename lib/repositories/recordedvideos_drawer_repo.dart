

import '../network/network_api_service.dart';
import '../network/urls.dart';

class RecordedVideosDrawerRepo{
  BaseApiServices apiServices=NetworkApiService();

  Future<dynamic> fetch() async{
    try{
      dynamic response= await apiServices.getApi(AppUrl.recordedVideosDrawer);
      return response;
    }catch(e){
      print(e.toString());
    }
  }
}